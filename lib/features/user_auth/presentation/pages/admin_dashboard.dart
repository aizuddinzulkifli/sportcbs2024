import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/home_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/report_analytics.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/system_performance.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/court_availability.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/user_availability.dart';
import '../../../../global/common/toast.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({Key? key}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _currentUser;
  bool _isAdmin = false;

  int _activeUsers = 0;
  int _totalBookings = 0;
  double _totalRevenue = 0.0;

  int _activeUsersLastWeek = 0;
  int _totalBookingsLastWeek = 0;
  double _totalRevenueLastWeek = 0.0;

  @override
  void initState() {
    super.initState();
    _checkIfAdmin();
    _fetchAnalyticsData();
  }

  Future<void> _checkIfAdmin() async {
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();
        if (userDoc.exists && userDoc.get('isAdmin') == true) {
          setState(() {
            _currentUser = user;
            _isAdmin = true;
          });
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()), // Replace with your HomePage
          );
        }
      } catch (e) {
        print('Error checking admin status: $e');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()), // Replace with your HomePage
        );
      }
    }
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

  @override
  Widget build(BuildContext context) {
    if (!_isAdmin) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Admin Dashboard',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
        padding: const EdgeInsets.all(20.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    const SizedBox(height: 5),
    SizedBox(height: 16),
    _buildAnalyticsCard('Active Users', _activeUsers.toString(), _activeUsersLastWeek.toString()),
    _buildAnalyticsCard('Total Bookings', _totalBookings.toString(), _totalBookingsLastWeek.toString()),
    _buildAnalyticsCard('Total Revenue', 'RM$_totalRevenue', 'RM$_totalRevenueLastWeek'),
    const SizedBox(height: 20),
    const Text(
    'Settings',
    style: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(height: 16),
    SettingItem(
    title: 'Report & Analytics',
    leading: Icon(Icons.analytics),
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => ReportAnalyticsScreen()),
    );
    },
    ),
    const Divider(color: Colors.grey),
    SettingItem(
    title: 'Court Management',
    leading: Icon(Icons.sports_tennis),
    onTap: () async {
    QuerySnapshot courtsSnapshot = await FirebaseFirestore.instance.collection('courts').get();
    List<Map<String, dynamic>> courtsAvailabilityData = courtsSnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CourtAvailabilityScreen(courtsAvailabilityData)),
    );
    },
    ),
    const Divider(color: Colors.grey),
    SettingItem(
    title: 'User Management',
    leading: Icon(Icons.people),
    onTap: () {
    Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => UserManagementScreen()),
    );
    },
    ),
    const Divider(color: Colors.grey),
    SettingItem(
    title: 'System Performance',
    leading: Icon(Icons.bar_chart
    ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SystemPerformanceScreen()),
        );
      },
    ),
      const Divider(color: Colors.grey),
      SignOutButton(),
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

class SettingItem extends StatelessWidget {
  final String title;
  final Widget leading;
  final VoidCallback onTap;

  const SettingItem({required this.title, required this.leading, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(title),
      onTap: onTap,
    );
  }
}

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.logout),
      title: Text('Sign Out'),
      onTap: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushReplacementNamed(context, "/login");
      },
    );
  }
}

