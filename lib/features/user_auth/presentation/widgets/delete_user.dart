// DeleteUserScreen.dart
import 'package:flutter/material.dart';

class DeleteUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete User'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Are you sure you want to delete this user?'),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Implement logic to delete user from Firestore
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}