import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> fetchUser(String uid) async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    _user = User(
      uid: uid,
      name: userDoc['name'],
      role: userDoc['role'],
    );
    notifyListeners();
  }
}

class User {
  final String uid;
  final String name;
  final String role;

  User({
    required this.uid,
    required this.name,
    required this.role,
  });
}
