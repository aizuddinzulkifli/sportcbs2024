import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CourtDetailScreen extends StatefulWidget {
  final Map<String, dynamic> courtData;

  CourtDetailScreen({required this.courtData});

  @override
  _CourtDetailScreenState createState() => _CourtDetailScreenState();
}

class _CourtDetailScreenState extends State<CourtDetailScreen> {
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late bool _isVisible;

  @override
  void initState() {
    super.initState();

    // Initialize the controllers with non-null values.
    _descriptionController = TextEditingController(text: widget.courtData['description'] ?? '');
    _priceController = TextEditingController(text: (widget.courtData['price'] ?? 0).toInt().toString());
    _isVisible = widget.courtData['isVisible'] ?? false;

    // Print initial values for debugging
    print('Court Data: ${widget.courtData}');
    print('Initial Description: ${_descriptionController.text}');
    print('Initial Price: ${_priceController.text}');
    print('Initial Visibility: $_isVisible');
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _updateCourtData() async {
    // Ensure that 'CourtId' key exists in the data
    if (!widget.courtData.containsKey('CourtId') || widget.courtData['CourtId'] == null) {
      print('Error: courtID is missing or null');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid court data: CourtId is missing')),
      );
      return;
    }

    String courtID = widget.courtData['CourtId'];
    String description = _descriptionController.text;
    double? price = double.tryParse(_priceController.text);
    bool isVisible = _isVisible;

    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid price')),
      );
      return;
    }

    try {
      print('Updating courtID: $courtID');
      print('Description: $description');
      print('Price: $price');
      print('IsVisible: $isVisible');

      await FirebaseFirestore.instance.collection('courts').doc(courtID).update({
        'description': description,
        'price': price,
        'isVisible': isVisible,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Court data updated successfully')),
      );
    } catch (e) {
      print('Error updating court data for courtID $courtID: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update court data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Court Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${widget.courtData['courtName']}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Visible on Homepage'),
                Switch(
                  value: _isVisible,
                  onChanged: (value) {
                    setState(() {
                      _isVisible = value;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _updateCourtData,
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
