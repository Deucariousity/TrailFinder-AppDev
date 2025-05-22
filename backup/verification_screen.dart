// import 'dart:math';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:mailer/mailer.dart';
// import 'package:mailer/smtp_server/gmail.dart';
// import 'student_home_screen.dart';
// import 'custom_page_route.dart';
//
// class VerificationScreen extends StatefulWidget {
//   final String studentId;
//   final String studentEmail;
//
//   VerificationScreen({required this.studentId, required this.studentEmail});
//
//   @override
//   _VerificationScreenState createState() => _VerificationScreenState();
// }
//
// class _VerificationScreenState extends State<VerificationScreen> {
//   final TextEditingController _otpController = TextEditingController();
//   String? _generatedOTP;
//   bool _isOTPSent = false;
//   bool _isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _sendOTP();
//   }
//
//   String _generateOtp() {
//     final Random random = Random();
//     return (100000 + random.nextInt(900000)).toString();
//   }
//
//   Future<void> _sendOTP() async {
//     setState(() => _isLoading = true);
//
//     _generatedOTP = _generateOtp();
//     print("Generated OTP: $_generatedOTP");
//
//     String username = "your-email@gmail.com";
//     String password = "your-app-password";
//
//     final smtpServer = gmail(username, password);
//     final message = Message()
//       ..from = Address(username, "TrailFinder Support")
//       ..recipients.add(widget.studentEmail)
//       ..subject = "Your TrailFinder OTP Verification Code"
//       ..text = "Your OTP code is: $_generatedOTP \n\nDo not share this with anyone.";
//
//     try {
//       await send(message, smtpServer);
//       setState(() {
//         _isOTPSent = true;
//         _isLoading = false;
//       });
//       _showMessage("OTP sent to ${widget.studentEmail}");
//     } catch (e) {
//       setState(() => _isLoading = false);
//       _showMessage("Failed to send OTP. Check your email settings.");
//     }
//   }
//
//   void _verifyOTP() async {
//     if (_otpController.text.trim() == _generatedOTP) {
//       _showMessage("Verification successful!");
//
//       final docRef = FirebaseFirestore.instance.collection('students').doc(widget.studentId);
//       final snapshot = await docRef.get();
//
//       if (!snapshot.exists) {
//         _showMessage("Student record not found.");
//         return;
//       }
//
//       final studentData = snapshot.data();
//
//       await docRef.update({'emailVerified': true});
//
//       Navigator.pushReplacement(
//         context,
//         CustomPageRoute(
//           page: StudentHomeScreen(studentData: {
//             ...?studentData,
//             'id': widget.studentId,
//           }),
//         ),
//       );
//     } else {
//       _showMessage("Invalid OTP. Please try again.");
//     }
//   }
//
//   void _showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Email OTP Verification")),
//       body: Center(
//         child: _isLoading
//             ? CircularProgressIndicator()
//             : Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Enter the OTP sent to ${widget.studentEmail}"),
//             SizedBox(height: 20),
//             TextField(
//               controller: _otpController,
//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                 labelText: "Enter OTP",
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(color: Colors.black),
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _verifyOTP,
//               child: Text("Verify OTP"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
