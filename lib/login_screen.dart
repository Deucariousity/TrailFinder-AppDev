import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:TrailFinder/custom_page_route.dart';
import 'guest_home_screen.dart';
import 'email_verification_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool _isPasswordHidden = true;

  /// 🔹 **Handles Student Login**
  Future<void> _login() async {
    setState(() => _isLoading = true);

    String studentId = _idController.text.trim();
    String password = _passwordController.text.trim();

    if (studentId.isEmpty || password.isEmpty) {
      _showMessage("Please enter your Student ID and Password.");
      setState(() => _isLoading = false);
      return;
    }

    try {
      // 🔍 Fetch Student Data from Firestore
      DocumentSnapshot studentDoc =
      await _firestore.collection('students').doc(studentId).get();

      if (!studentDoc.exists) {
        _showMessage("Student ID not found. Contact admin.");
        setState(() => _isLoading = false);
        return;
      }

      // ✅ Retrieve Firestore fields safely
      final data = studentDoc.data() as Map<String, dynamic>;
      data['id'] = studentId; // ✅ Insert studentId into map for later screens

      String storedPassword = data['password'].toString();
      String studentEmail = data['email'] ?? "";

      // 🔐 Validate password
      if (password == storedPassword) {
        Navigator.pushReplacement(
          context,
          CustomPageRoute(
            page: EmailVerificationScreen(
              studentID: studentId,
              studentData: data, // ✅ Now includes 'id', 'phone', etc.
            ),
          ),
        );
      } else {
        _showMessage("Incorrect Password.");
      }
    } catch (e) {
      print("❌ Firestore Error: $e");
      _showMessage("An error occurred. Please try again.");
    }

    setState(() => _isLoading = false);
  }


  /// 🎭 **Login as Guest**
  void _loginAsGuest() {
    Navigator.push(
      context,
      CustomPageRoute(
        page: GuestHomeScreen(),
      ),
    );
  }

  /// ⚡ **Show SnackBar Message**
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
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TrailFinder',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Lobster',
                  color: Color(0xFF1C1654),
                ),
              ),
              Text(
                'A navigation app for the University of',
                style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: Colors.black),
              ),
              Text(
                'Science and Technology of Southern Philippines',
                style: TextStyle(fontSize: 12, fontFamily: 'Montserrat', color: Colors.black),
              ),
              SizedBox(height: 25),

              // 📌 Student ID Input
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                  labelText: 'Enter Student ID',
                  labelStyle: TextStyle(fontSize: 15, fontFamily: 'Poppins', color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 10,
                style: TextStyle(fontSize: 15, color: Colors.black),
                cursorColor: Colors.black,
              ),
              SizedBox(height: 10),

              // 🔐 Password Input with Toggle and Custom Styling
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(fontSize: 15, fontFamily: 'Poppins', color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordHidden ? Icons.visibility_off : Icons.visibility,
                      color: Colors.black54,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordHidden = !_isPasswordHidden;
                      });
                    },
                  ),
                ),
                keyboardType: TextInputType.number,
                maxLength: 10,
                obscureText: _isPasswordHidden,
                style: TextStyle(fontSize: 15, color: Colors.black),
                cursorColor: Colors.black,
              ),

              SizedBox(height: 10),

              Text('If not Student, Continue as Guest', style: TextStyle(fontSize: 13, fontFamily: 'Poppins', color: Colors.black)),
              SizedBox(height: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _isLoading
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: _login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1877F2),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: Text(
                      'Login as Student',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: _loginAsGuest,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Keeping original color
                      foregroundColor: Colors.black, // Text color black
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Matching rounded corners
                      ),
                      elevation: 4, // Adding shadow effect
                      shadowColor: Colors.black.withOpacity(1), // Light shadow color
                    ),
                    child: Text(
                      'Continue as Guest',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }
}