import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/admin_dashboard.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/navigation_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/sign_up_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:sportcbs2024/global/common/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sportcbs2024/features/user_auth/presentation/services/firebase_service.dart';
import '../../firebase_auth_implementation/firebase_auth_services.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}): super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isSigningIn = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signOut() async {
    await _firebaseAuth.signOut();
    // Add any other sign-out logic specific to your authentication service here
  }

  void _signIn() async {
    setState(() {
      _isSigningIn = true;
    });

    // Ensure the user is signed out before signing in
    await _signOut();

    User? user = await _authService.signInWithEmailAndPassword(
      _emailController.text,
      _passwordController.text,
    );

    if (user != null) {
      DocumentSnapshot? userDoc = await _firebaseService.getUserData(user.uid);

      if (userDoc != null && userDoc.exists && userDoc['isAdmin'] == true) {
        // If the user is an admin, proceed with admin-specific actions
        showToast(message: "Admin login successful");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        // If the user is not an admin, proceed with regular user actions
        await _firebaseService.updateLastLogin(user.uid);

        if (userDoc == null) {
          await _firebaseService.createUser(user, 'Default Name', 'Default Phone');
        } else {
          await _firebaseService.updateUser(user.uid, userDoc['name'], userDoc['phone'], user.email!);
        }

        showToast(message: "User successfully signed in");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage1()),
        );
      }
    } else {
      showToast(message: "Error occurred during sign in");
    }



    setState(() {
      _isSigningIn = false;
    });
  }

  Future<void> _signInWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        UserCredential userCredential = await _firebaseAuth
            .signInWithCredential(credential);
        User? user = userCredential.user;

        if (user != null) {
          await _firebaseService.updateLastLogin(user.uid);

          // Ensure user document exists and update it if needed
          DocumentSnapshot? userData = await _firebaseService.getUserData(
              user.uid);
          if (userData == null) {
            await _firebaseService.createUser(
                user, 'Default Name', 'Default Phone');
          } else {
            await _firebaseService.updateUser(
                user.uid, userData['name'], userData['phone'], user.email!);
          }

          showToast(message: "User successfully signed in with Google");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavigationPage1()),
          );
        }
      }
    } catch (e) {
      showToast(message: "Error occurred during Google sign in: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(""),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login",
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              FormContainerWidget(
                controller: _emailController,
                hintText: "Email",
                isPasswordField: false,
              ),
              const SizedBox(
                height: 10,
              ),
              FormContainerWidget(
                controller: _passwordController,
                hintText: "Password",
                isPasswordField: true,
              ),
              const SizedBox(
                height: 30,
              ),
              GestureDetector(
                onTap: () {
                  _signIn();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: _isSigningIn ? const CircularProgressIndicator(
                      color: Colors.white,) : const Text(
                      "Login",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              GestureDetector(
                onTap: () {
                  _signInWithGoogle();
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(FontAwesomeIcons.google, color: Colors.white,),
                        SizedBox(width: 5,),
                        Text(
                          "Sign in with Google",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),


              const SizedBox(
                height: 20,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New Member?"),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()),
                            (route) => false,
                      );
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*if (user != null) {

      //Check if the user is an admin
      //bool isAdmin = (_emailController.text == 'admin@admin.com');

      if (isAdmin) {
        //If the user is admin, proceed with admin-specific actions
        showToast(message: "Admin Login Successful");
        //Example navigation to admin dash board
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AdminDashboard()),
        );
      } else {
        //If the user is not an admin, proceed with regular user actions
        await _firebaseService.updateLastLogin(user.uid);

        // Ensure user document exists and update it if needed
        DocumentSnapshot? userData = await _firebaseService.getUserData(
            user.uid);
        if (userData == null) {
          await _firebaseService.createUser(
              user, 'Default Name', 'Default Phone');
        } else {
          await _firebaseService.updateUser(
              user.uid, userData['name'], userData['phone'], user.email!);
        }

        showToast(message: "User successfully signed in");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavigationPage1()),
        );
      }
    } else {
      showToast(message: "Error occurred during sign in");
    }

    setState(() {
      _isSigningIn = false;
    });
  }*/

  /*void _signIn() async {
    setState(() {
      _isSigning = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      _isSigning = false;
    });

    if (user != null) {

      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'lastLogin': FieldValue.serverTimestamp(),
      });

      showToast(message: "User is successfully signed in");
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NavigationPage1()),
      );
    } else {
      showToast(message: "some error occured");
    }
  }


  _signInWithGoogle()async{

    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {

      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

      if(googleSignInAccount != null ){
        final GoogleSignInAuthentication googleSignInAuthentication = await
        googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        Navigator.pushNamed(context, "/");
      }

    }catch(e) {
showToast(message: "some error occured $e");
    }


  }


}*/