import 'package:flutter/material.dart';

class ViewEmergencyContactsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Contacts'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors:  [
                Color(0xFFFF971A),
                Color(0xFFFFFF67),
              ],
                  transform: GradientRotation(24)
              )
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/intro-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          children: [
            ListTile(title: Text('Campus Security: 123-456-7890', style: TextStyle(color: Colors.black))),
            ListTile(title: Text('Health Services: 987-654-3210', style: TextStyle(color: Colors.black))),
            ListTile(title: Text('Counseling Center: 555-555-5555', style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}