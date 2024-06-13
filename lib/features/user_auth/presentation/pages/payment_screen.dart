import 'package:flutter/material.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/payment_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';

/*class PaymentScreen extends StatelessWidget {
  final double amount;
  final String currency;

  PaymentScreen({required this.amount, required this.currency});

  final StripePaymentHandle _stripePaymentHandle = StripePaymentHandle();

  @override
  Widget build(BuildContext context) {
    initiatePayment();

    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press logic here if needed
        // Return true to allow the back navigation
        // Return false to prevent the back navigation
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment'),
        ),
        body: Center(
          child: CircularProgressIndicator(), // Show loading indicator while payment is being processed
        ),
      ),
    );
  }

  void initiatePayment() async {
    try {
      await _stripePaymentHandle.stripeMakePayment(amount.toString(), currency);
    } catch (e) {
      print(e.toString());
      Fluttertoast.showToast(msg: e.toString());
    }
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
      Fluttertoast.showToast(msg: 'Payment successfully completed');
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
}*/
