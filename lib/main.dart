import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/payment_page.dart';
import 'package:sportcbs2024/model/court_model.dart'; // Import your Court model
import 'package:sportcbs2024/providers/auth_provider.dart';
import 'package:sportcbs2024/providers/booking_provider.dart';
import 'package:sportcbs2024/providers/court_provider.dart';

// Import Firebase Auth
import 'package:sportcbs2024/features/app/splash_screen/splash_screen.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/admin_dashboard.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/home_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/login_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/navigation_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/notification_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/profile_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/scan_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/personal_information.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message: ${message.messageId}');
}

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    //await dotenv.load(fileName: ".env");
    Stripe.publishableKey = "pk_test_51PLQfbCFyJQbKjkX03kp6VPH3VvHcS8aqnZZtbRpP6aRYQCI1TXWIVBAS4Ucrgq7UxV5qDvHyIAsgWO1dn34uXr900Cu02fS48";
    //await Stripe.instance.applySettings();
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    print('Error loading .env file: $e');
    // Handle the error gracefully, e.g., provide a fallback value for Stripe publishable key
  }

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDInOa2pdya5LTJoekZ6HrN_Xem5Pmo7HU",
        appId: "1:782982781563:web:d468ba8bc473b3eb3360de",
        messagingSenderId: "782982781563",
        projectId: "sportcbs-224ae",
        // Your web Firebase config options
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  //Initialize Stripe SDK

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    //return MultiProvider(
        //providers: [
          //ChangeNotifierProvider(create: (_) => AuthProvider()),
          //ChangeNotifierProvider(create: (_) => CourtProvider()),
          //ChangeNotifierProvider(create: (_) => BookingProvider()),
        //])




    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(
          // Here, you can decide whether to show the LoginPage or HomePage based on user authentication
          child: LoginPage(),
        ),
        '/login': (context) => const LoginPage(),
        '/signUp': (context) => const SignUpPage(),
        '/home': (context) => const HomePage(),
        '/profile': (context) => const ProfilePage(),
        '/notification': (context) => const NotificationPage(),
        //'scan': (context) => const ScanPage(),
        'navigation':(context) => const NavigationPage1(),
        'admindashboard':(context) => const AdminDashboard(),
        //'/payment': (context) => PaymentScreen(),



      },
    );
  }
}


class NavigationPage extends StatefulWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;
  int _notificationCount = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ScanPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null) {
        setState(() {
          _notificationCount++;
        });
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NotificationPage()),
      );
    });

    messaging.getToken().then((value) {
      print("FirebaseMessaging token: $value");
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(),
    body: _pages[_selectedIndex],
    bottomNavigationBar: SafeArea (
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 10.0,
            spreadRadius: 1.0,
          ),
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          activeColor: Colors.blueAccent,
          tabBackgroundColor: Colors.blue.shade100,
          padding: EdgeInsets.all(16),
          selectedIndex: _selectedIndex,
          tabs: [
            GButton(icon: Icons.home, text: 'Home',onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },),
            GButton(icon: Icons.scanner, text: 'Scan',onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },),
            GButton(icon: Icons.notifications, text: 'Notification',onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },),
            GButton(icon: Icons.settings, text: 'Profile',onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },),
          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    ),
    ),
  );
}




