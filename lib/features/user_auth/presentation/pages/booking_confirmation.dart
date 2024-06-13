import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/qr_code.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/scan_page.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:qr_flutter/qr_flutter.dart';

class BookingConfirmation extends StatelessWidget {
  double price = 0;

  final String bookingId;
  final String courtId;
  final String date;
  final String time;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  //final double totalPrice;

  BookingConfirmation({
    required this.bookingId,
    required this.courtId,
    required this.date,
    required this.time,
    required this.duration,
    required this.startTime,
    required this.endTime,
    //required this.totalPrice,
  });

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StripePaymentHandle _stripePaymentHandle = StripePaymentHandle();

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Confirmation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                  border: Border.all(
                    color: Color.fromRGBO(244, 244, 244, 1),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildInfoRow('Court ID', courtId),
                      _buildInfoRow('Date', date),
                      _buildInfoRow('Time', time),
                      _buildInfoRow('Duration', '$duration hour(s)'),
                      _buildInfoRow(
                          'Start Time', DateFormat('HH:mm').format(startTime)),
                      _buildInfoRow(
                          'End Time', DateFormat('HH:mm').format(endTime)),

                      // Fetch court document to get price and other details
                      FutureBuilder<DocumentSnapshot>(
                        future: _firestore.collection('courts')
                            .doc(courtId)
                            .get(),
                        builder: (context, courtSnapshot) {
                          if (courtSnapshot.connectionState == ConnectionState
                              .waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (courtSnapshot.hasError) {
                            return Text('Error: ${courtSnapshot.error}');
                          }
                          if (!courtSnapshot.hasData || !courtSnapshot.data!
                              .exists) {
                            print(
                                'Court data not available for courtId: $courtId'); // Debug print
                            return Text('Court data not available.');
                          }

                          final courtData = courtSnapshot.data!.data() as Map<
                              String,
                              dynamic>?;
                          if (courtData != null) {
                            final price = courtData['price'];

                            // Initiate payment process

                            final totalPrice = price * duration;
                            this.price = totalPrice;
                            return _buildInfoRow('Price', 'RM $totalPrice');
                          } else {
                            print(
                                'Price data not available in court document for courtId: $courtId'); // Debug print
                            return Text(
                                'Price data not available in this document.');
                          }
                        },
                      ),
                      SizedBox(height: 430),
                      //_buildCouponSection(),
                      SizedBox(height: 20),
                      Divider(color: Colors.black),
                      _buildTotalSection(price, duration),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      initiatePayment(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(65, 105, 225, 1),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void initiatePayment(BuildContext context) async {
    try {
      await _stripePaymentHandle.stripeMakePayment(price.toString(), 'MYR');
      Fluttertoast.showToast(msg: 'Payment successfully completed');
      Navigator.push(context,
      MaterialPageRoute(builder: (context) => BookingQRCode(
        bookingId: bookingId,
        courtId: courtId,
        date: date,
        time: time,
        duration: duration,
        startTime: startTime,
        endTime: endTime,
        totalPrice: price,
      ),
      ),
      );
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: 'Payment failed: ${e.toString()}');
    }
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalSection(double price, int duration) {
    double totalPrice = price * duration;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow('TOTAL', 'RM ${totalPrice.toStringAsFixed(2)}'), // Use totalPrice here
      ],
    );
  }
}

class StripePaymentHandle {
  Map<String, dynamic>? paymentIntent;

  Future<void> stripeMakePayment(String amount, String currency) async {
    try {
      paymentIntent = await createPaymentIntent(amount, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          billingDetails: BillingDetails(
            name: 'YOUR NAME',
            email: 'YOUREMAIL@gmail.com',
            phone: 'YOUR NUMBER',
            address: Address(
              city: 'YOUR CITY',
              country: 'YOUR COUNTRY',
              line1: 'YOUR ADDRESS 1',
              line2: 'YOUR ADDRESS 2',
              postalCode: 'YOUR PINCODE',
              state: 'YOUR STATE',
            ),
          ),
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          style: ThemeMode.dark,
          merchantDisplayName: 'Ikay',
        ),
      );

      // Display Payment sheet
      await displayPaymentSheet();
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<void> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      Fluttertoast.showToast(msg: 'Error from Stripe: ${e.error.localizedMessage}');
    } catch (e) {
      Fluttertoast.showToast(msg: 'Unforeseen error: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['STRIPE_SECRET']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return json.decode(response.body);
    } catch (err) {
      throw Exception(err.toString());
    }
  }

  String calculateAmount(String amount) {
    final calculatedAmount = (double.parse(amount) * 100).toInt();
    return calculatedAmount.toString();
  }
}
