import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/*class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _searchAvailableCourts() {
    // Implement the logic to fetch available courts based on _selectedDate and _selectedTime
    // For now, we just print the selected date and time
    print('Selected Date: $_selectedDate');
    print('Selected Time: $_selectedTime');

    // You would typically navigate to a results page here
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AvailableCourtsPage(
          selectedDate: _selectedDate!,
          selectedTime: _selectedTime!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose Date and Time'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            Text('Selected Date: ${_selectedDate?.toLocal().toString().split(' ')[0] ?? ''}'),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            Text('Selected Time: ${_selectedTime?.format(context) ?? ''}'),
            ElevatedButton(
              onPressed: _searchAvailableCourts,
              child: Text('Search'),
            ),
          ],
        ),
      ),
    );
  }
}

class AvailableCourtsPage extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;

  AvailableCourtsPage({required this.selectedDate, required this.selectedTime});

  @override
  Widget build(BuildContext context) {
    // Implement the logic to fetch available courts based on selectedDate and selectedTime
    List<String> availableCourts = ['Court 1', 'Court 2', 'Court 3']; // Example data

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Courts'),
      ),
      body: ListView.builder(
        itemCount: availableCourts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(availableCourts[index]),
          );
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  Widget build(BuildContext context) {
    // Get the screen width and height
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: screenWidth,
        height: screenHeight,
        decoration: BoxDecoration(
          color: Color.fromRGBO(247, 247, 247, 1),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
              bottom: 0,
              child: Container(
                width: screenWidth,
                height: screenHeight * 0.1,  // Adjusted height
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                      offset: Offset(5, 0),
                      blurRadius: 20,
                    ),
                  ],
                  color: Color.fromRGBO(255, 255, 255, 1),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: screenWidth * 0.9,
                      height: 24,
                      decoration: BoxDecoration(),
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            top: 5.333,
                            left: 1.162,
                            child: Container(
                              width: screenWidth * 0.88,
                              height: 13.333,
                              child: null,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.24,
              left: screenWidth * 0.1,
              child: Container(
                width: screenWidth * 1.08,
                height: screenHeight * 0.15,
                decoration: BoxDecoration(),
                child: Stack(
                  children: <Widget>[],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.14,
              left: screenWidth * 0.05,
              child: Container(
                width: screenWidth * 0.9,
                height: screenHeight * 0.18,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: _buildDateTimeContainer(
                        screenWidth,
                        screenHeight,
                        'Date',
                        selectedDate != null ? '${selectedDate!.toLocal()}'.split(' ')[0] : 'Any day',
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: () => _selectTime(context),
                      child: _buildDateTimeContainer(
                        screenWidth,
                        screenHeight,
                        'Time',
                        selectedTime != null ? selectedTime!.format(context) : 'Any hour',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.92,  // Adjust this value to lower the buttons
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  width: screenWidth * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = null;
                            selectedTime = null;
                          });
                        },
                        child: Text(
                          'Clear all',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Color.fromRGBO(98, 91, 91, 1),
                            fontFamily: 'Roboto',
                            fontSize: 13,
                            fontWeight: FontWeight.normal,
                            height: 1,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle the "Next" button press
                        },
                        child: Container(
                          width: screenWidth * 0.28,
                          height: screenHeight * 0.06,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Color.fromRGBO(65, 105, 225, 1),
                          ),
                          child: Center(
                            child: Text(
                              'Next',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                color: Color.fromRGBO(255, 255, 255, 1),
                                fontFamily: 'Roboto',
                                fontSize: 13,
                                fontWeight: FontWeight.normal,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.07,
              left: screenWidth * 0.07,
              child: Icon(
                Icons.arrow_back,
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateTimeContainer(
      double screenWidth,
      double screenHeight,
      String label,
      String value,
      ) {
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.25),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
        color: Color.fromRGBO(255, 255, 255, 1),
        border: Border.all(
          color: Color.fromRGBO(244, 244, 244, 1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Color.fromRGBO(118, 118, 118, 1),
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                height: 1.57,
              ),
            ),
            Text(
              value,
              style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1),
                fontFamily: 'Roboto',
                fontSize: 14,
                fontWeight: FontWeight.normal,
                height: 1.57,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
  }
}
