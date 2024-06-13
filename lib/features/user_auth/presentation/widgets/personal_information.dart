import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/info_field.dart';
import '../services/firebase_service.dart';
import 'package:flutter/material.dart';


/*class PersonalInfo extends StatelessWidget {
  const PersonalInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text('Personal Information'),
      ),
      body: Center(
        child: Text('Personal Information Screen'),
      ),
    );
  }
}*/

class PersonalInfo extends StatefulWidget {
  final User user;

  const PersonalInfo({Key? key, required this.user}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  bool _isEditingName = false;
  bool _isEditingPhone = false;
  bool _isEditingEmail = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _docId; //State variable to hold the document ID


  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    DocumentSnapshot? userData = await FirebaseService().getUserData(
        widget.user.uid);
    if (userData != null) {
      setState(() {
        _docId = userData.id;
        _nameController.text = userData['name'];
        _phoneController.text = userData['phone'];
        _emailController.text = userData['email'];
      });
    }
  }

  Future<void> _updateUser() async {
    if (_docId != null) {
      await FirebaseService().updateUser(_docId!, _nameController.text, _phoneController.text, _emailController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Personal Info'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenWidth = constraints.maxWidth;
          final screenHeight = constraints.maxHeight;
          final double containerWidth = screenWidth * 0.9;
          final double containerHeight = screenHeight * 0.9;

          return Center(
            child: Container(
              width: containerWidth,
              height: containerHeight,
              padding: EdgeInsets.symmetric(
                vertical: containerHeight * 0.05,
                horizontal: containerWidth * 0.05,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InfoField(
                    title: 'Name',
                    controller: _nameController,
                    isEditing: _isEditingName,
                    onEditPressed: () {
                      setState(() {
                        _isEditingName = true;
                      });
                    },
                    onSavePressed: () async {
                      await _updateUser();
                      setState(() {
                        _isEditingName = false;
                      });
                    },
                  ),
                  SizedBox(height: containerHeight * 0.02),
                  InfoField(
                    title: 'Phone Number',
                    controller: _phoneController,
                    isEditing: _isEditingPhone,
                    onEditPressed: () {
                      setState(() {
                        _isEditingPhone = true;
                      });
                    },
                    onSavePressed: () async {
                      await _updateUser();
                      setState(() {
                        _isEditingPhone = false;
                      });
                    },
                  ),
                  SizedBox(height: containerHeight * 0.02),
                  InfoField(
                    title: 'Email',
                    controller: _emailController,
                    isEditing: _isEditingEmail,
                    onEditPressed: () {
                      setState(() {
                        _isEditingEmail = true;
                      });
                    },
                    onSavePressed: () async {
                      await _updateUser();
                      setState(() {
                        _isEditingEmail = false;
                      });
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

/*
  Widget _buildInfoField({
    required String title,
    required String value,
    required bool isEditing,
    required VoidCallback onEditPressed,
    required VoidCallback onSavePressed,
    required TextEditingController controller,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              isEditing
                  ? TextField(
                controller: controller..text = value,
              )
                  : Text(value),
            ],
          ),
        ),
        isEditing
            ? TextButton(
          onPressed: onSavePressed,
          child: Text('Save'),
        )
            : TextButton(
          onPressed: onEditPressed,
          child: Text('Edit'),
        ),
      ],
    );
  }*/

  /*Widget _buildInfoField({
    required String title,
    required String value,
    required bool isEditing,
    required VoidCallback onEditPressed,
    required VoidCallback onSavePressed,
    required TextEditingController controller,
    required String docId,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0x22222222)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (isEditing)
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  labelText: title,
                ),
              ),
            )
          else
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  value,
                  style: TextStyle(
                    color: Color(0xFF767676),
                    fontSize: 15,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          if (isEditing)
            TextButton(
              onPressed: () {
                onSavePressed();
                updateUser(docId, controller.text, _phoneController.text, _emailController.text);
              },
              //onPressed: onSavePressed,
              child: Text(
                'Save',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          else
            TextButton(
              onPressed: onEditPressed,
              child: Text(
                'Edit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }*/

  /*Future<void> updateUser(String docId, String name, String phone, String email) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update({
      'name': name,
      'phone': phone,
      'email': email,
    })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }*/




