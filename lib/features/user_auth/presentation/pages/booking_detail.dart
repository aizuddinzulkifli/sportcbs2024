import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/booking_confirmation.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class BookingForm extends StatefulWidget {
  final String courtId;
  final Map<String, dynamic> court;

  BookingForm({required this.courtId, required this.court});

  @override
  _BookingFormState createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  int duration = 1;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  Set<int> _selectedTimes = {};
  Set<int> _bookedTimes = {};

  @override
  void initState() {
    super.initState();
    durationController.text = duration.toString();
  }

  @override
  void dispose() {
    dateController.dispose();
    timeController.dispose();
    durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('bookings').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (_selectedDay != null) {
          _updateBookedTimes(snapshot);
        }

        return buildBookingForm(context,snapshot);
      },
    );
  }

  void _updateBookedTimes(AsyncSnapshot<QuerySnapshot> snapshot) {
    _bookedTimes.clear();
    for (var doc in snapshot.data!.docs) {
      var data = doc.data() as Map<String, dynamic>?;
      if (data != null &&
          data.containsKey('courtId') &&
          data['courtId'] == widget.courtId &&
          data.containsKey('date') &&
          data['date'] == DateFormat('yyyy-MM-dd').format(_selectedDay!)) {
        DateTime bookedStartTime = DateFormat('yyyy-MM-dd HH:mm').parse(
            '${data['date']} ${data['time']}');
        int bookedDuration = data['duration'] ?? 1;
        for (int i = 0; i < bookedDuration; i++) {
          _bookedTimes.add(bookedStartTime.hour + i);
        }
      }
    }
  }

  Widget buildBookingForm(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {
    if (_selectedDay != null) {
      _updateBookedTimes(snapshot);
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 4.0,
              width: 50.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: Text(
              'Booking',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Divider(color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'Date',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                dateController.text =
                    DateFormat('yyyy-MM-dd').format(selectedDay);
                _selectedTimes.clear(); // Clear selected times when date changes
                _bookedTimes.clear(); // Clear booked times when date changes
              });
            },
            calendarFormat: CalendarFormat.month,
          ),
          SizedBox(height: 16),
          Text(
            'Duration',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    if (duration > 1) {
                      duration--;
                      durationController.text = duration.toString();
                      _selectedTimes.clear(); // Clear selected times when duration changes
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  foregroundColor: Color.fromRGBO(65, 105, 225, 1),
                  shadowColor: Colors.transparent,
                ),
                child: Icon(
                    Icons.remove, color: Color.fromRGBO(65, 105, 225, 1)),
              ),
              SizedBox(width: 16),
              Text('$duration', style: TextStyle(fontSize: 18)),
              SizedBox(width: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    duration++;
                    durationController.text = duration.toString();
                    _selectedTimes.clear(); // Clear selected times when duration changes
                  });
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  foregroundColor: Color.fromRGBO(65, 105, 225, 1),
                  shadowColor: Colors.transparent,
                ),
                child: Icon(Icons.add, color: Color.fromRGBO(65, 105, 225, 1)),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Time',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                14,
                    (index) {
                  final time = TimeOfDay(hour: 10 + index, minute: 0);
                  final isSelected = _selectedTimes.contains(index);
                  final isBooked = _bookedTimes.contains(10 + index);

                  if (!isBooked) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (isSelected) {
                              _selectedTimes.remove(index);
                              if (timeController.text == time.format(context)) {
                                timeController.clear();
                              }
                            } else {
                              _selectedTimes.add(index);
                              timeController.text = time.format(context);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSelected
                              ? Color.fromRGBO(65, 105, 225, 1)
                              : Colors.white,
                          foregroundColor: isSelected ? Colors.white : Color.fromRGBO(
                              65, 105, 225, 1),
                          shadowColor: Colors.transparent,
                        ),
                        child: Text(
                          time.format(context),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Color.fromRGBO(
                                65, 105, 225, 1),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return SizedBox(); // Return an empty SizedBox for booked slots
                  }
                },
              ),
            ),
          ),
          Spacer(),
          Container(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                _saveBooking(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromRGBO(65, 105, 225, 1),
                padding: EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Confirm Booking',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isTimeSlotUnavailable(int startHour) {
    for (int i = 0; i < duration; i++) {
      if (_bookedTimes.contains(startHour + i) ||
          _selectedTimes.contains(startHour + i)) {
        return true; //Slot is unavailable
      }
    }
    return false; //Slot is available
  }

  Future<void> _saveBooking(BuildContext context) async {
    String courtId = widget.courtId;
    String date = dateController.text;
    String time = timeController.text;

    // Ensure that all fields are filled and valid
    if (courtId.isEmpty || date.isEmpty || time.isEmpty || duration <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields correctly.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

      DateTime startTime;
      try {
        // Parse date and time
        startTime = DateFormat('yyyy-MM-dd HH:mm').parse('$date $time');
      } catch (e) {
        // Handle invalid date/time format
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid date or time format.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      DateTime endTime = startTime.add(Duration(hours: duration));

      try {
        // Fetch existing bookings for the selected court and date
        final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('bookings')
            .where('courtId', isEqualTo: courtId)
            .where('date', isEqualTo: date)
            .get();

        // Check for overlapping bookings
        for (QueryDocumentSnapshot bookingSnapshot in querySnapshot.docs) {
          DateTime bookedStartTime = (bookingSnapshot['startTime'] as Timestamp).toDate();
          DateTime bookedEndTime = (bookingSnapshot['endTime'] as Timestamp).toDate();

          if (startTime.isBefore(bookedEndTime) &&
              endTime.isAfter(bookedStartTime)) {
            // Handle overlapping bookings
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Selected time slot is already booked.'),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
        }

        // Save the booking to Firestore and get the generated booking ID
        DocumentReference bookingRef = await FirebaseFirestore.instance
            .collection('bookings')
            .add({
          'courtId': courtId,
          'date': date,
          'time': time,
          'duration': duration,
          'startTime': startTime,
          'endTime': endTime,
        });

        String bookingId = bookingRef.id; // Get the booking ID

        // Navigate to the booking confirmation page with the generated booking ID
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                BookingConfirmation(
                  bookingId: bookingId,
                  courtId: courtId,
                  date: date,
                  time: time,
                  duration: duration,
                  startTime: startTime,
                  endTime: endTime,
                ),
          ),
        );
      } catch (e) {
        // Handle Firestore errors
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
