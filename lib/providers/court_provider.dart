import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportcbs2024/model/court_model.dart'; // Import your Court model

class CourtProvider with ChangeNotifier {
  List<Court> _courts = []; // List of courts

  List<Court> get courts => _courts; // Getter for courts

  // Method to fetch courts from Firestore or any other source
  Future<void> fetchCourts() async {
    // Logic to fetch courts goes here
    // Example: fetching courts from Firestore
    // You may need to import FirebaseFirestore from cloud_firestore package

    // Example fetching courts from Firestore
    // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('courts').get();
    // _courts = snapshot.docs.map((doc) => Court.fromMap(doc.data())).toList();

    // Notify listeners after fetching data
    notifyListeners();
  }
}
