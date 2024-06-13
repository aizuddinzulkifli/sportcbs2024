
/*import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Scan Page',
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Text('This is the Scan page'),
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:get/get.dart';

// scan_page.dart
import 'package:flutter/material.dart';
import 'package:sportcbs2024/model/booking_model.dart';
import 'package:sportcbs2024/features/user_auth/presentation/services/booking_service.dart';

/*class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  final String userId;

  //ScanPage({required this.userId});

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late Future<List<Booking>> _futureBookings;

  @override
  void initState() {
    super.initState();
    _futureBookings = fetchUserBookings(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Bookings'),
      ),
      body: FutureBuilder<List<Booking>>(
        future: _futureBookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Booking> bookings = snapshot.data!;
            return ListView.builder(
              itemCount: bookings.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Booking ID: ${bookings[index].bookingId}'),
                  subtitle: Text('Court: ${bookings[index].courtId} | Date: ${bookings[index].date}'),
                  // Implement more details as needed
                );
              },
            );
          }
        },
      ),
    );
  }
}*/



class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    final aspectRatio = screenSize.width / screenSize.height;


    return Scaffold(
      appBar: AppBar(
        title: Text('Check In',
          style: TextStyle(fontSize: 30,
              fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                width: screenSize.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                  border: Border.all(
                    color: Color.fromRGBO(244, 244, 244, 1),
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('TEST TEST TEST'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}


/*import 'package:flutter/material.dart';

class ScanPage extends StatefulWidget {

  final String bookingId;
  final String courtId;
  final String date;
  final String time;
  final int duration;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;

  ScanPage({
    required this.bookingId,
    required this.courtId,
    required this.date,
    required this.time,
    required this.duration,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
  });

  const ScanPage({Key? key}) : super(key: key);

  @override
  _ScanPageWidgetState createState() => _ScanPageWidgetState();
}

class _ScanPageWidgetState extends State<ScanPage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    double bookingDetailsWidth = screenWidth * 0.9; // 90% of the screen width
    double bookingDetailsHeight = bookingDetailsWidth * 0.8; // 80% of the width

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = constraints.maxWidth;
          double screenHeight = constraints.maxHeight;

          return Container(
            width: screenWidth,
            height: screenHeight,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                Positioned(
                  top: screenHeight * 0.06,
                  left: screenWidth * 0.06,
                  child: Text(
                    'Check in',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: screenHeight * 0.2,
                  left: screenWidth * 0.05,
                  child: Container(
                    width: bookingDetailsWidth,
                    height: bookingDetailsHeight,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.17),
                          offset: Offset(0, 4),
                          blurRadius: 18,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 35,
                          left: 8,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(38)),
                            ),
                            child: Stack(
                              children: <Widget>[],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 17,
                          right: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(100)),
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(0, 0, 0, 0.25),
                                  offset: Offset(0, 0),
                                  blurRadius: 4,
                                ),
                              ],
                              color: Colors.white,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Icon(Icons.more_vert),
                          ),
                        ),
                        Positioned(
                          top: 220,
                          left: 10,
                          child: Container(
                            width: bookingDetailsWidth * 0.9,
                            height: 154,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'No. ID',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Date time',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Start time',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'End time',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'Price',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    'RM 13',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Roboto',
                                      fontSize: 13,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 220,
                          right: 10,
                          child: Container(
                            width: bookingDetailsWidth * 0.4,
                            height: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '5685465',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '18 April 2024',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '8:00 AM',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '9:00 AM',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Roboto',
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 17,
                          left: 12,
                          child: Container(
                            width: bookingDetailsWidth * 0.4,
                            height: 105,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              //image: DecorationImage(
                                //image: AssetImage('assets/images/Katamacourt2.png'),
                                //fit: BoxFit.fitWidth,
                              //),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}*/
