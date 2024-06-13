import 'package:flutter/material.dart';
import 'package:sportcbs2024/model/booking_model.dart'; // Import your Booking model

class BookingProvider with ChangeNotifier {
  List<Booking> _bookings = []; // List of bookings

  List<Booking> get bookings => _bookings; // Getter for bookings

  // Method to fetch bookings from Firestore or any other source
  Future<void> fetchBookings() async {
    // Logic to fetch bookings goes here
    // Example: fetching bookings from Firestore
    // You may need to import FirebaseFirestore from cloud_firestore package

    // Example fetching bookings from Firestore
    // QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('bookings').get();
    // _bookings = snapshot.docs.map((doc) => Booking.fromMap(doc.data())).toList();

    // Notify listeners after fetching data
    notifyListeners();
  }
}
