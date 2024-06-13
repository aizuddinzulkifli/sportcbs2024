
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/personal_information.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/login_security.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/profile_notifications.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/profile_payments.dart';
import '../../../../global/common/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';



class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late User? _currentUser;

  @override
  void initState() {
    super.initState();
    _currentUser = _auth.currentUser;
  }

  Future<void> _signOut() async {
    try {
      // Sign out from Google if signed in using Google
      if (await _googleSignIn.isSignedIn()) {
        await _googleSignIn.signOut();
      }
      // Sign out from Firebase
      await _auth.signOut();
      showToast(message: "Logged out successfully");
      Navigator.pushReplacementNamed(context, "/login");
    } catch (e) {
      showToast(message: "Error signing out. Please try again later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
            ),
          ),
        ),


      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            //ProfileHeader(),
            ProfileInfo(),
            SettingsList(currentUser: _currentUser),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () async {
                try {
                  await _auth.signOut();
                  showToast(message: "Logged out successfully");
                  Navigator.pushReplacementNamed(context, "/login");
                } catch (e) {
                  showToast(message: "Error signing out. Please try again later.");
                }
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class ProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage("https://via.placeholder.com/80x80"),
            ),
            SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Deng',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'Show Profile',
                  style: TextStyle(
                    color: Color(0xFF767676),
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class CustomUser {
  final String uid;

  CustomUser({required this.uid});
}


class SettingsList extends StatelessWidget {
  final User? currentUser;
  const SettingsList({Key? key, required this.currentUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Text('Settings',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          )),
        ),
        GestureDetector(
        onTap: () {
        Navigator.push(
          context,CupertinoPageRoute(builder: (context) =>PersonalInfo(user: currentUser as User )),
        );
        },
          child: SettingItem(
          title: 'Personal Information',
          leading: Icon(Icons.info),
          ),
        ),
          Divider(color: Colors.grey),
          GestureDetector(
          onTap: () {
          Navigator.push(
          context,CupertinoPageRoute(builder: (context) =>LoginSecurityScreen()),
          );
        },
        child: SettingItem(
          title: 'Login & Security',
          leading: Icon(Icons.lock),
          ),
        ),
        Divider(color: Colors.grey),
        GestureDetector(
        onTap: () {
        Navigator.push(
        context,CupertinoPageRoute(builder: (context) =>NotificationsScreen()),
        );
        },
        child: SettingItem(
          title: 'Notifications',
          leading: Icon(Icons.notifications),
        ),
        ),
        Divider(color: Colors.grey),
        GestureDetector(
        onTap: () {
        Navigator.push(
        context,CupertinoPageRoute(builder: (context) =>PaymentsScreen()),
        );
        },
        child: SettingItem(
          title: 'Payments',
          leading: Icon(Icons.payment),
        ),
        ),
      ],
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final Widget leading;

  SettingItem({required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 15,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios),
    );
  }
}

/*body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
                  "Profilepage!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                )),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
                showToast(message: "Successfully signed out");
              },
              child: Container(
                height: 45,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: Text(
                    "Sign out",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ),
              ),
            )
          ],
        ),*/




























