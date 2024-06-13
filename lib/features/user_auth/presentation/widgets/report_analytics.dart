import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class ReportAnalyticsScreen extends StatefulWidget {
  @override
  _ReportAnalyticsScreenState createState() => _ReportAnalyticsScreenState();
}

class _ReportAnalyticsScreenState extends State<ReportAnalyticsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  int _activeUsers = 0;
  int _totalBookings = 0;
  double _totalRevenue = 0.0;

  int _activeUsersLastWeek = 0;
  int _totalBookingsLastWeek = 0;
  double _totalRevenueLastWeek = 0.0;

  @override
  void initState() {
    super.initState();
    _fetchAnalyticsData();
  }

  Future<void> _fetchAnalyticsData() async {
    try {
      // Fetch active users for the current week
      QuerySnapshot userSnapshot = await _firestore.collection('users').get();
      setState(() {
        _activeUsers = userSnapshot.docs.length;
      });

      // Fetch total bookings for the current week
      QuerySnapshot bookingSnapshot = await _firestore.collection('bookings').get();
      setState(() {
        _totalBookings = bookingSnapshot.docs.length;
      });

      // Fetch total revenue for the current week
      QuerySnapshot revenueSnapshot = await _firestore.collection('revenue').get();
      double totalRevenue = 0.0;
      revenueSnapshot.docs.forEach((doc) {
        totalRevenue += doc['amount'];
      });
      setState(() {
        _totalRevenue = totalRevenue;
      });

      // Fetch data for the last week (adjust the date range as needed)
      DateTime now = DateTime.now();
      DateTime lastWeekStart = DateTime(now.year, now.month, now.day - now.weekday - 6);
      DateTime lastWeekEnd = DateTime(now.year, now.month, now.day - now.weekday);
      DateTime twoWeeksAgoStart = DateTime(now.year, now.month, now.day - now.weekday - 13);
      DateTime twoWeeksAgoEnd = DateTime(now.year, now.month, now.day - now.weekday - 7);

      // Fetch active users for the last week
      QuerySnapshot userSnapshotLastWeek = await _firestore.collection('users')
          .where('lastActive', isGreaterThanOrEqualTo: Timestamp.fromDate(lastWeekStart))
          .where('lastActive', isLessThanOrEqualTo: Timestamp.fromDate(lastWeekEnd))
          .get();
      setState(() {
        _activeUsersLastWeek = userSnapshotLastWeek.docs.length;
      });

      // Fetch total bookings for the last week
      QuerySnapshot bookingSnapshotLastWeek = await _firestore.collection('bookings')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(lastWeekStart))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(lastWeekEnd))
          .get();
      setState(() {
        _totalBookingsLastWeek = bookingSnapshotLastWeek.docs.length;
      });

      // Fetch total revenue for the last week
      QuerySnapshot revenueSnapshotLastWeek = await _firestore.collection('revenue')
          .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(lastWeekStart))
          .where('date', isLessThanOrEqualTo: Timestamp.fromDate(lastWeekEnd))
          .get();
      double totalRevenueLastWeek = 0.0;
      revenueSnapshotLastWeek.docs.forEach((doc) {
        totalRevenueLastWeek += doc['amount'];
      });
      setState(() {
        _totalRevenueLastWeek = totalRevenueLastWeek;
      });

    } catch (e) {
      print('Error fetching analytics data: $e');
      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching analytics data: $e'),
          duration: Duration(seconds: 3),
        ),
      );
    }
  }


  Future<void> _exportAnalyticsData() async {
    // Collect analytics data
    List<List<dynamic>> dataRows = [
      ['Metrics', 'Current Week', 'Last Week'],
      ['Active Users', _activeUsers, _activeUsersLastWeek],
      ['Total Bookings', _totalBookings, _totalBookingsLastWeek],
      ['Total Revenue', _totalRevenue, _totalRevenueLastWeek],
    ];

    // Generate CSV content
    String csvContent = dataRows.map((row) => row.join(',')).join('\n');

    // Save CSV file to external storage directory
    final directory = await getExternalStorageDirectory();
    final filePath = '${directory?.path}/analytics_report.csv'; // Path to the generated CSV file
    final file = File(filePath);
    await file.writeAsString(csvContent);

    // Show a message indicating that the file has been exported
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Analytics data exported as CSV file to: $filePath'),
        duration: Duration(seconds: 3),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report & Analytics'),
        actions: [
          IconButton(
            icon: Icon(Icons.file_download),
            onPressed: _exportAnalyticsData,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Analytics Summary',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildAnalyticsCard('Active Users', _activeUsers.toString(), _activeUsersLastWeek.toString()),
            _buildAnalyticsCard('Total Bookings', _totalBookings.toString(), _totalBookingsLastWeek.toString()),
            _buildAnalyticsCard('Total Revenue', 'RM$_totalRevenue', 'RM$_totalRevenueLastWeek'),
          ],
        ),
      ),
    );
  }

  Widget _buildAnalyticsCard(String title, String value, String lastWeekValue) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        subtitle: lastWeekValue.isNotEmpty
            ? Text('Last Week: $lastWeekValue', style: TextStyle(fontSize: 14, color: Colors.grey))
            : null,
        trailing: Text(value, style: TextStyle(fontSize: 18)),
      ),
    );
  }
}




/*class ReportAnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Analytics'),
      ),
      body: Center(
        child: Text('Report Analytics Screen'),
      ),
    );
  }
}*/