// ChangeStatusScreen.dart
import 'package:flutter/material.dart';

class ChangeStatusScreen extends StatefulWidget {
  @override
  _ChangeStatusScreenState createState() => _ChangeStatusScreenState();
}

class _ChangeStatusScreenState extends State<ChangeStatusScreen> {
  // Define variable to store user status (active or inactive)
  bool isActive = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change User Status'),
      ),
      body: Column(
        children: [
          Text('User Status: ${isActive ? 'Active' : 'Inactive'}'),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              // Implement logic to toggle user status
              setState(() {
                isActive = !isActive;
              });
            },
            child: Text('${isActive ? 'Deactivate' : 'Activate'} User'),
          ),
        ],
      ),
    );
  }
}