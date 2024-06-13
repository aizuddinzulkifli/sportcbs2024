import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditUserScreen extends StatefulWidget {
  final String userId;
  final Map<String, dynamic> userData;

  const EditUserScreen({required this.userId, required this.userData});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  // Define TextEditingController for form fields
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values for form fields from userData
    _nameController.text = widget.userData['name'] ?? '';
    _emailController.text = widget.userData['email'] ?? '';
    _phoneController.text = widget.userData['phone'] ?? '';
    _roleController.text = widget.userData['role'] ?? '';
  }

  Future<void> _updateUserData() async {
    try {
      // Get the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Reference to the user document
      DocumentReference userDocRef = firestore.collection('users').doc(widget.userId);

      // Update the user data in Firestore
      await userDocRef.update({
        'name': _nameController.text,
        'email': _emailController.text,
        'phone': _phoneController.text,
      });

      // Show a success message or navigate back to previous screen
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('User details updated successfully'),
      ));
    } catch (error) {
      // Handle errors
      print('Error updating user data: $error');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error updating user data. Please try again.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit User'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _updateUserData,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
