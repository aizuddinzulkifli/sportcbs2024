import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportcbs2024/model/booking_model.dart';

/*Future<List<Booking>> fetchUserBookings(String userId) async {
  try {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
        .collection('bookings')
        .where('userId', isEqualTo: userId) // Filter bookings by userId
        .get();

    List<Booking> bookings = querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data();
      return Booking(
        id: doc.id,
        userId: data['userId'], // Use userId from data
        courtId: data['courtId'],
        date: data['date'],
        time: data['time'],
        duration: data['duration'],
        startTime: data['startTime'].toDate(),
        endTime: data['endTime'].toDate(),
        totalPrice: data['totalPrice'].toDouble(),
      );
    }).toList();

    return bookings;
  } catch (e) {
    print('Error fetching user bookings: $e');
    return [];
  }
}*/
