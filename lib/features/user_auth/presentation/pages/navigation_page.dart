import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/home_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/notification_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/profile_page.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/scan_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationPage1 extends StatefulWidget {
  const NavigationPage1({Key? key}) : super(key: key);

  @override
  _NavigationPage1State createState() => _NavigationPage1State();
}

class _NavigationPage1State extends State<NavigationPage1> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const ScanPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    resizeToAvoidBottomInset: false,
    extendBody: true,
    body: Center(
      child: _pages[_selectedIndex],
    ),
    bottomNavigationBar: Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 10.0,
              spreadRadius: 1.0,
            ),
          ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GNav(
          gap: 8,
          backgroundColor: Colors.white,
          activeColor: Colors.blueAccent,
          tabBackgroundColor: Colors.blue.shade100,
          padding: EdgeInsets.all(16),
          selectedIndex: _selectedIndex,
          tabs: [
            GButton(icon: Icons.home, text: 'Home', onPressed: () {
              setState(() {
                _selectedIndex = 0;
              });
            },),
            GButton(icon: FontAwesomeIcons.qrcode, text: 'Scan', onPressed: () {
              setState(() {
                _selectedIndex = 1;
              });
            },),
            GButton(icon: Icons.notifications, text: 'Notification', onPressed: () {
              setState(() {
                _selectedIndex = 2;
              });
            },),
            GButton(icon: Icons.person, text: 'Profile', onPressed: () {
              setState(() {
                _selectedIndex = 3;
              });
            },),
          ],
          onTabChange: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    ),

  );
}
