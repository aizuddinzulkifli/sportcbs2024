/*import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Stripe.publishableKey = 'YOUR_PUBLISHABLE_KEY'; // Replace with your Stripe publishable key
  }

  Future<void> _payWithCard() async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(
            billingDetails: BillingDetails(),
          ),
        ),
      );
      // Handle successful payment
    } catch (error) {
      // Handle payment failure
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: SlidingUpPanel(
        panel: _buildPaymentPanel(),
        body: Container(
          // Your main content here
        ),
      ),
    );
  }

  Widget _buildPaymentPanel() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TextField(
            controller: _cardNumberController,
            decoration: InputDecoration(
              labelText: 'Card Number',
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _expiryDateController,
                  decoration: InputDecoration(
                    labelText: 'Expiry Date (MM/YY)',
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: TextField(
                  controller: _cvvController,
                  decoration: InputDecoration(
                    labelText: 'CVV',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _payWithCard,
            child: Text('Pay Now'),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/payment.dart';


import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



/*class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _ready = false;

  Future<void> initPaymentSheet() async {
    try {
      final data = await _createTestPaymentSheet();

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: false,
          merchantDisplayName: 'Flutter Stripe Store Demo',
          paymentIntentClientSecret: data['paymentIntent'],
          customerEphemeralKeySecret: data['ephemeralKey'],
          customerId: data['customer'],
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            testEnv: true,
          ),
          style: ThemeMode.dark,
        ),
      );

      setState(() {
        _ready = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  Future<Map<String, dynamic>> _createTestPaymentSheet() async {
    final url = Uri.parse('https://api.stripe.com/v1/payment_intents');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({'amount': 2000}), // Example amount
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create payment intent');
    }
  }

  void _presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Payment Sheet'),
      ),
      body: Center(
        child: _ready
            ? ElevatedButton(
          onPressed: _presentPaymentSheet,
          child: Text('Pay'),
        )
            : ElevatedButton(
          onPressed: initPaymentSheet,
          child: Text('Initialize Payment'),
        ),
      ),
    );
  }
}*/



/*class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  // Replace with your backend endpoint to create a Payment Intent
  final String backendUrl = 'https://your-backend.com/create-payment-intent';

  Future<void> _handlePayment() async {
    try {
      // 1. Create a Payment Intent on the server
      final paymentIntentData = await createPaymentIntent('1000', 'usd');

      // 2. Initialize the payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData['client_secret'],
          merchantDisplayName: 'Your Merchant Name',
        ),
      );

      // 3. Display the payment sheet
      await Stripe.instance.presentPaymentSheet();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment successful')),
      );
    } catch (e) {
      print('Payment failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Payment failed')),
      );
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(String amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        body: jsonEncode({
          'amount': amount,
          'currency': currency,
          'payment_method_types': ['card'],
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer your_secret_key',
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error creating payment intent: ${err.toString()}');
      throw err;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stripe Payment'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _handlePayment,
          child: Text('Make Payment'),
        ),
      ),
    );
  }
}*/
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

void initiatePayment(BuildContext context) {
  // Call the function to initiate the payment process
  _startPaymentProcess(context).then((_) {
    // Payment initiated successfully, you can navigate to the next screen or show a success message
    // For example:
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentSuccessScreen()));
    // or
    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Payment initiated successfully')));
  }).catchError((error) {
    // Error handling for failed payment initiation
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to initiate payment')));
  });
}

Future<void> _startPaymentProcess(BuildContext context) async {
  try {
    // Call the function to initiate the payment process here
    // For example:
    // await initiatePayment();
  } catch (error) {
    // Handle error if the payment process fails
    throw error;
  }
}

