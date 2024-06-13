import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Fetch User Data
  Future<DocumentSnapshot?> getUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        print("User document does not exist");
        return null;
      }
    } catch (e) {
      print("Failed to fetch user data: $e");
      return null;
    }
  }

  // Create user data
  Future<void> createUser(User user, String name, String phone,{bool isAdmin = false}) async {
    try {
      await _firestore.collection('users').doc(user.uid).set({
        'name': name,
        'email': user.email,
        'phone': phone,
        'isAdmin': isAdmin,
        'createdAt': FieldValue.serverTimestamp(),
        'lastLogin': FieldValue.serverTimestamp(),
      });
      print("User Created");
    } catch (e) {
      print("Failed to create user: $e");
    }
  }

  // Update user data
  Future<void> updateUser(String uid, String name, String phone, String email) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        await _firestore.collection('users').doc(uid).update({
          'name': name,
          'phone': phone,
          'email': email,
          'lastLogin': FieldValue.serverTimestamp(),
        });
        print("User Updated");
      } else {
        await createUser(_auth.currentUser!, name, phone);
      }
    } catch (e) {
      print("Failed to update user: $e");
    }
  }

// Update last login timestamp
  Future<void> updateLastLogin(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await _firestore.collection('users').doc(uid).get();
      if (documentSnapshot.exists) {
        await _firestore.collection('users').doc(uid).update({
          'lastLogin': FieldValue.serverTimestamp(),
        });
        print("Last login updated");
      } else {
        print("User document does not exist for updating last login");
      }
    } catch (e) {
      print("Failed to update last login: $e");
    }
  }
}