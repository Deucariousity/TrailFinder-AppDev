import 'package:flutter/material.dart';
import 'package:TrailFinder/custom_page_route.dart';
import 'login_screen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _skipToLogin() {
    Navigator.pushReplacement(
      context,
      CustomPageRoute(page: LoginScreen()),
    );
  }

  void _proceedToLogin() {
    Navigator.pushReplacement(
      context,
      CustomPageRoute(page: LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/intro-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            _buildPage(
              title: "Navigate Your Campus Like a Pro!",
              description: "Find buildings, lecture halls, and student services in just a few taps.",
              showSkipButton: true,
            ),
            _buildPage(
              title: "Find Your Campus, Effortlessly!",
              description: "Navigate your university with ease and confidence.",
              showSkipButton: true,
            ),
            _buildPage(
              title: "Your Academic Journey, Simplified!",
              description: "Explore classrooms, libraries, and facilities with precision and convenience.",
              showSkipButton: false,
              isLastPage: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({required String title, required String description, bool showSkipButton = false, bool isLastPage = false}) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center( // Center the content both horizontally and vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the content vertically
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 36, fontFamily: 'Montserrat Bold', color: Colors.black),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(fontSize: 12, fontFamily: 'Poppins', color: Colors.black),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 40), // Add space between text and buttons
            if (showSkipButton)
              TextButton(
                onPressed: _skipToLogin,
                child: Text("Skip", style: TextStyle(fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.bold, color: Color(0xFF0C4B77)),
                ),
              ),
            if (isLastPage)
              ElevatedButton(
                onPressed: _proceedToLogin,
                child: Text("Proceed to Login", style: TextStyle(fontSize: 15, fontFamily: 'Poppins', color: Colors.black)),
              ),
          ],
        ),
      ),
    );
  }
}