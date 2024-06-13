import 'package:flutter/material.dart';
import 'package:sportcbs2024/features/user_auth/presentation/widgets/court_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CourtAvailabilityScreen extends StatelessWidget {
  final List<Map<String, dynamic>> courtsAvailabilityData;

  CourtAvailabilityScreen(this.courtsAvailabilityData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Court Availability'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchCourtData(), // Fetch court data asynchronously
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show loading indicator while fetching data
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}'); // Show error message if fetching data fails
          } else {
            List<Map<String, dynamic>> courtsData = snapshot.data!;
            return ListView.builder(
              itemCount: courtsData.length,
              itemBuilder: (context, index) {
                final courtData = courtsData[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourtDetailScreen(courtData: courtData),
                      ),
                    );
                  },
                  child: CourtAvailabilityCard(courtData),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _fetchCourtData() async {
    CollectionReference courtsCollection = FirebaseFirestore.instance.collection('courts');
    QuerySnapshot querySnapshot = await courtsCollection.get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['CourtId'] = doc.id; // Include CourtId from document id
      return data;
    }).toList();
  }
}

class CourtAvailabilityCard extends StatelessWidget {
  final Map<String, dynamic> courtData;

  CourtAvailabilityCard(this.courtData);

  @override
  Widget build(BuildContext context) {
    // Set a default value for isVisible
    bool isVisible = courtData['isVisible'] ?? false;

    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${courtData['courtName']}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Description: ${courtData['description']}'),
            SizedBox(height: 5),
            Text('Price: RM ${courtData['price'].toInt()}'),
            SizedBox(height: 5),
            Text('Visible on Homepage: ${isVisible ? "Yes" : "No"}'),
          ],
        ),
      ),
    );
  }
}
