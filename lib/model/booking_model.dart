class Booking {
  final String id;
  final String userId; // Add userId field
  final String courtId;
  final DateTime startTime;
  final DateTime endTime;
  final String bookingId;
  final String date;
  final String time;
  final int duration;
  final double totalPrice;

  Booking({
    required this.id,
    required this.userId,
    required this.courtId,
    required this.startTime,
    required this.endTime,
    required this.bookingId,
    required this.date,
    required this.time,
    required this.duration,
    required this.totalPrice,
  });

  // Factory method to create a Booking instance from a map
  factory Booking.fromMap(Map<String, dynamic> map) {
    return Booking(
      id: map['id'],
      userId: map['userId'], // Update to use userId field
      courtId: map['courtId'],
      startTime: DateTime.parse(map['startTime']),
      endTime: DateTime.parse(map['endTime']),
      bookingId: map['bookingId'],
      date: map['date'],
      time: map['time'],
      duration: map['duration'],
      totalPrice: map['totalPrice'].toDouble(),
    );
  }
}
