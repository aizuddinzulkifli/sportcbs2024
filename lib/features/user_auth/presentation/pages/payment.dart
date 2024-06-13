
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';


Future<Map<String, dynamic>> createPaymentIntent({
  required String amount,
  required String currency,
}) async {
  try {
    final url = Uri.parse("https://api.stripe.com/v1/payment_intents");
    final secretKey=dotenv.env["STRIPE_SECRET_KEY"]!;
    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $secretKey",
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: jsonEncode({
        'amount': amount,
        'currency': currency,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create payment intent');
    }
  } catch (error) {
    print('Error creating payment intent: $error');
    throw error;
  }
}

