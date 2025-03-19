import 'package:flutter/material.dart';
import 'intro_screen.dart';

class TitleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/title-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              SizedBox(height: 10), // Space between title and description
              Text('"The Guide to your Trailblazing',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              Text('Journey at USTP"',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50), // Space between description and button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroScreen()),
                  );
                },
                child: Text('Get Started', style: TextStyle(fontSize: 15, fontFamily: 'Montserrat', color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  textStyle: TextStyle(fontSize: 20, color: Colors.white),
                  backgroundColor: Color(0xFF0C4B77), // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}