
import 'package:flutter/material.dart';

class CentreLayoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Centre Layout'),
      ),
      body: Center(
        child: Text('Centre Layout Page Content'),
      ),
    );
  }
}