import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:student_nav_system/custom_page_route.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String studentId;
  final String studentEmail;

  EmailVerificationScreen({required this.studentId, required this.studentEmail});

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _generatedOTP;
  bool isLoading = false;

  Future<void> _sendOTP() async {
    setState(() {
      isLoading = true;
    });

    try {
      _generatedOTP = (100000 + Random().nextInt(900000)).toString();
      await _firestore.collection('students').doc(widget.studentId).set({
        'otp': _generatedOTP,
        'otpCreatedAt': Timestamp.now(),
      }, SetOptions(merge: true));
      await _sendEmail(widget.studentEmail, _generatedOTP!);
      _showMessage("OTP has been sent to ${widget.studentEmail}");

      Navigator.push(
        context,
        CustomPageRoute(
          page: OTPVerificationScreen(
            studentId: widget.studentId,
            studentEmail: widget.studentEmail,
          ),
        ),
      );
    } catch (e) {
      print("Error sending OTP: $e");
      _showMessage("Error sending OTP. Please try again.");
    }

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _sendEmail(String email, String otp) async {
    String username = "trailfinder.appdev2d@gmail.com";
    String password = "vjrgsfvgowrxaqqu";

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Student Nav System')
      ..recipients.add(email)
      ..subject = "Your OTP Verification Code"
      ..text = "Your OTP code is: $otp. Do not share this code with anyone.";

    try {
      await send(message, smtpServer);
      print("✅ OTP sent successfully!");
    } catch (e) {
      print("❌ Email send failed: $e");
      _showMessage("Failed to send OTP. Check your email settings.");
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Please enter your email to verify your account',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                readOnly: true,
                controller: TextEditingController(text: widget.studentEmail),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(fontSize: 15, color: Colors.black),
                cursorColor: Colors.black,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: isLoading ? null : _sendOTP,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: isLoading
                    ? CircularProgressIndicator(color: Colors.black)
                    : Text(
                  'Send OTP',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


