import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/pricing.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/opening_hours.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/centre_layout.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/amenities_facilities.dart';
import 'package:sportcbs2024/features/user_auth/presentation/pages/booking_detail.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class BookingPage extends StatelessWidget {
  final Map<String, dynamic> court;
  final PanelController _panelController = PanelController();

  BookingPage({required this.court});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'courtImage_${court['courtName']}',
                    child: Image.network(
                      court['pictureUrl'],
                      width: double.infinity,
                      height: 350,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 50, // Adjust this value based on your design
                    left: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  court['courtName'],
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Price: RM${court['price'].toInt()}/hour',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  court['description'],
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => PricingPage()),
                  );
                },
                child: SettingItem(
                  title: 'Pricing',
                  leading: Icon(Icons.price_change),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => OpeningHoursScreen()),
                  );
                },
                child: SettingItem(
                  title: 'Opening Hours',
                  leading: Icon(Icons.hourglass_bottom),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => CentreLayoutScreen()),
                  );
                },
                child: SettingItem(
                  title: 'Centre Layout',
                  leading: Icon(Icons.sports),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Divider(color: Colors.grey),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(builder: (context) => AmenitiesFacilitiesScreen()),
                  );
                },
                child: SettingItem(
                  title: 'Amenities & Facilities',
                  leading: Icon(Icons.payment),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: (){
                      _panelController.open();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(65, 105, 225, 1),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text (
                      'Book Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SlidingUpPanel(
            controller: _panelController,
            panel: BookingForm(courtId: '${court['courtName']}_${court['courtType']}', court: court),
            minHeight: 0,
            maxHeight: 900,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final Icon leading;

  SettingItem({required this.title, required this.leading});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
      child: ListTile(
        leading: leading,
        title: Text(title),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          // Define the action when the setting item is tapped
        },
      ),
    );
  }
}