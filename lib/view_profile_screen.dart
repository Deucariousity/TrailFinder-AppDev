import 'package:flutter/material.dart';

class ViewProfileScreen extends StatelessWidget {
  final String studentName;
  final String studentId;
  final String email;
  final String course;
  final String profilePhoto;

  ViewProfileScreen({
    required this.studentName,
    required this.studentId,
    required this.email,
    required this.course,
    required this.profilePhoto,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Profile'),
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
            image: AssetImage('assets/home-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage(profilePhoto),
                ),
                SizedBox(height: 20),
                Text('Name: $studentName', style: TextStyle(color: Colors.black, fontSize: 18)),
                Text('Student ID: $studentId', style: TextStyle(color: Colors.black, fontSize: 18)),
                Text('Email: $email', style: TextStyle(color: Colors.black, fontSize: 18)),
                Text('Course: $course', style: TextStyle(color: Colors.black, fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}