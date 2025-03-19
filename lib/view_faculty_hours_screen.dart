import 'package:flutter/material.dart';

class ViewFacultyHoursScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Office Hours'),
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
            ListTile(title: Text('Dr. Smith: Mon-Fri, 10 AM - 12 PM', style: TextStyle(color: Colors.black))),
            ListTile(title: Text('Prof. Johnson: Tue-Thu, 1 PM - 3 PM ', style: TextStyle(color: Colors.black))),
            ListTile(title: Text('Ms. Lee: Wed, 2 PM - 4 PM', style: TextStyle(color: Colors.black))),
          ],
        ),
      ),
    );
  }
}