import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';


class BookingQRCode extends StatelessWidget {
  final String bookingId;
  final String courtId;
  final String date;
  final String time;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;

  BookingQRCode({
    required this.bookingId,
    required this.courtId,
    required this.date,
    required this.time,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final bookingInfo = {
      'bookingId': bookingId,
      'courtId': courtId,
      'date': date,
      'time': time,
      'duration': duration,
      'startTime': DateFormat('HH:mm').format(startTime),
      'endTime': DateFormat('HH:mm').format(endTime),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking QR Code'),
      ),
      body: Center(
        child: QrImageView(
          data: jsonEncode(bookingInfo),
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}
