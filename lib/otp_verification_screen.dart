import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:TrailFinder/custom_page_route.dart';
import 'student_home_screen.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String studentID;
  final String studentEmail;
  final Map<String, dynamic> studentData;

  OTPVerificationScreen({
    required this.studentID,
    required this.studentEmail,
    required this.studentData,
  });

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  String otpCode = "";
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isLoadingConfirm = false;
  bool isLoadingResend = false;

  Future<void> _verifyOTP() async {
    if (otpCode.length < 6) {
      _showMessage("Please enter the full OTP");
      return;
    }

    setState(() => isLoadingConfirm = true);

    try {
      DocumentSnapshot studentDoc =
      await _firestore.collection('students').doc(widget.studentID).get();

      if (studentDoc.exists) {
        String storedOTP = studentDoc['otp'];
        Timestamp createdAt = studentDoc['otpCreatedAt'];
        DateTime expiryTime = createdAt.toDate().add(Duration(minutes: 2));

        if (DateTime.now().isAfter(expiryTime)) {
          _showMessage("OTP has expired. Please request a new one.");
          return;
        }

        if (otpCode == storedOTP) {
          await _firestore.collection('students').doc(widget.studentID).update({
            'verified': true,
          });

          // 🔁 Re-fetch updated student data
          DocumentSnapshot updatedStudentDoc =
          await _firestore.collection('students').doc(widget.studentID).get();
          Map<String, dynamic> updatedStudentData =
          updatedStudentDoc.data() as Map<String, dynamic>;

          final updatedDoc = await _firestore.collection('students').doc(widget.studentID).get();

          if (updatedDoc.exists) {
            final updatedDoc = await _firestore.collection('students').doc(widget.studentID).get();

            if (updatedDoc.exists) {
              final updatedData = updatedDoc.data()!;
              updatedData['id'] = updatedDoc.id; // <-- add document ID manually
              Navigator.pushReplacement(
                context,
                CustomPageRoute(
                  page: StudentHomeScreen(studentData: updatedData),
                ),
              );
            } else {
              _showMessage("Failed to load student data after verification.");
            }

          } else {
            _showMessage("Failed to load student data after verification.");
          }

        } else {
          _showMessage("Invalid OTP. Please try again.");
        }
      } else {
        _showMessage("Error: Student record not found.");
      }
    } catch (e) {
      print("Error verifying OTP: $e");
      _showMessage("Error verifying OTP. Please try again.");
    } finally {
      setState(() => isLoadingConfirm = false);
    }
  }


  Future<void> _resendOTP() async {
    setState(() => isLoadingResend = true);

    try {
      String newOTP = (100000 + DateTime.now().millisecondsSinceEpoch % 900000).toString();

      await _firestore.collection('students').doc(widget.studentID).update({
        'otp': newOTP,
        'otpCreatedAt': Timestamp.now(),
      });

      bool emailSent = await _sendOTPByEmail(newOTP);

      if (emailSent) {
        _showMessage("OTP Resent Successfully!");
      } else {
        _showMessage("Failed to send OTP via email. Please try again.");
      }
    } catch (e) {
      print("Error updating OTP: $e");
      _showMessage("Failed to resend OTP. Please try again.");
    } finally {
      setState(() => isLoadingResend = false);
    }
  }

  Future<bool> _sendOTPByEmail(String otp) async {
    try {
      print("Sending OTP $otp to ${widget.studentEmail}");

      final HttpsCallable callable =
      FirebaseFunctions.instance.httpsCallable('sendOTPEmail');

      final response = await callable.call({
        'email': widget.studentEmail,
        'otp': otp,
      });

      print("Firebase Function Response: ${response.data}");

      if (response.data != null && response.data['success'] == true) {
        print("✅ OTP email sent successfully");
        return true;
      } else {
        print("❌ Failed to send OTP email: ${response.data['message']}");
        return false;
      }
    } catch (e) {
      print("🔥 Error sending OTP email: $e");
      return false;
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
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF971A), Color(0xFFFFFF67)],
                transform: GradientRotation(14),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.verified_outlined, size: 50, color: Colors.green),
                SizedBox(height: 20),
                Text(
                  "Verification Code",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "Enter the 6-digit code sent to ${widget.studentEmail}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(height: 20),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Colors.black,
                  focusedBorderColor: Colors.black,
                  showFieldAsBox: true,
                  onCodeChanged: (String code) {},
                  onSubmit: (String verificationCode) {
                    setState(() => otpCode = verificationCode);
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: isLoadingConfirm ? null : _verifyOTP,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding:
                    EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: isLoadingConfirm
                      ? CircularProgressIndicator(color: Colors.black)
                      : Text(
                    "Confirm Code",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: isLoadingResend ? null : _resendOTP,
                  child: isLoadingResend
                      ? CircularProgressIndicator(color: Color(0xFF0C4B77))
                      : Text(
                    "Resend Code",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                      color: Color(0xFF0C4B77),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
