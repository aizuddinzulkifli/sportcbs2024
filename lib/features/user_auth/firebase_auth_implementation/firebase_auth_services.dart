



import 'package:firebase_auth/firebase_auth.dart';

import '../../../global/common/toast.dart';


class FirebaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {

      if (e.code == 'email-already-in-use') {
        showToast(message: 'The email address is already in use.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }
    }
    return null;

  }

  Future<User?> signInWithEmailAndPassword(String email, String password) async {

    try {
      UserCredential credential =await _auth.signInWithEmailAndPassword(email: email, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: 'Invalid email or password.');
      } else {
        showToast(message: 'An error occurred: ${e.code}');
      }

    }
    return null;

  }

// Reauthenticate the user with their current password
  Future<void> reauthenticateUser(String currentPassword) async {
    try {
      // Create a credential with the user's current email and password
      AuthCredential credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: currentPassword,
      );

      // Reauthenticate the user with the credential
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } catch (e) {
      throw Exception('Failed to reauthenticate user: $e');
    }
  }
// Change the user's password
  Future<void> changeUserPassword(String newPassword) async {
    try {
      // Update the user's password
      await _auth.currentUser!.updatePassword(newPassword);
    } catch (e) {
      throw Exception('Failed to change user password: $e');
    }
  }



}


