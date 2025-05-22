import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:TrailFinder/custom_page_route.dart';
import 'otp_verification_screen.dart';

class EmailVerificationScreen extends StatefulWidget {
  final String studentID;
  final Map<String, dynamic> studentData;

  EmailVerificationScreen({required this.studentID, required this.studentData});

  @override
  _EmailVerificationScreenState createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _emailController = TextEditingController();

  bool isLoading = false;
  String? _generatedOTP;

  Future<void> _sendOTP() async {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      _showMessage("Please enter a valid email.");
      return;
    }

    print("➡️ Send OTP button clicked");
    setState(() => isLoading = true);

    final stopwatch = Stopwatch()..start();
    _generatedOTP = (100000 + Random().nextInt(900000)).toString();
    print("🔢 Generated OTP: $_generatedOTP");

    try {
      // Save OTP to Firestore
      await _firestore.collection('students').doc(widget.studentID).set({
        'otp': _generatedOTP,
        'otpCreatedAt': Timestamp.now(),
        'email': email,
      }, SetOptions(merge: true));
      print("✅ Firestore write complete in ${stopwatch.elapsedMilliseconds}ms");

      stopwatch.reset();

      // Send email
      await _sendEmail(email, _generatedOTP!);
      print("✅ Email sent in ${stopwatch.elapsedMilliseconds}ms");

      _showMessage("OTP has been sent to $email");

      // Navigate to OTP verification screen
      Navigator.pushReplacement(
        context,
        CustomPageRoute(
          page: OTPVerificationScreen(
            studentID: widget.studentID,
            studentData: widget.studentData,
            studentEmail: email,
          ),
        ),
      );
    } catch (e) {
      print("❌ Error sending OTP: $e");
      _showMessage("Error sending OTP. Please try again.");
    }

    setState(() => isLoading = false);
  }

  Future<void> _sendEmail(String email, String otp) async {
    final String username = 'trailfinder.appdev2d@gmail.com';
    final String password = 'bcutzzohplzpqcgm'; // Gmail App Password

    final smtpServer = SmtpServer(
      'smtp.gmail.com',
      port: 587,
      username: username,
      password: password,
      ssl: false,
    );

    final message = Message()
      ..from = Address(username, 'TrailFinder OTP')
      ..recipients.add(email)
      ..subject = 'Your OTP Code'
      ..text = 'Your OTP code is: $otp. It will expire in 2 minutes.';

    try {
      final sendReport = await send(message, smtpServer);
      print("📤 SMTP report: $sendReport");
    } catch (e) {
      print("❌ Email error: $e");
      rethrow;
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
                'Please input your email to verify your account',
                style: TextStyle(fontSize: 18, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
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
                    : Text('Send OTP', style: TextStyle(fontSize: 13, color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
