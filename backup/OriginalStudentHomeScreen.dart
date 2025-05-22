// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import 'package:TrailFinder/custom_page_route.dart';
// import 'ClassSchedules.dart';
// import 'Help.dart';
// import 'Profile.dart';
// import 'FacultyHours.dart';
// import 'EmergencyContacts.dart';
// import 'login_screen.dart';
// import 'CampusMap.dart';
//
// class StudentHomeScreen extends StatefulWidget {
//   final Map<String, dynamic> studentData;
//
//   const StudentHomeScreen({required this.studentData, super.key});
//
//   @override
//   _StudentHomeScreenState createState() => _StudentHomeScreenState();
// }
//
// class _StudentHomeScreenState extends State<StudentHomeScreen> {
//   List<String> schedules = [];
//
//   void _confirmLogout() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text('Log Out'),
//           content: Text('Log out from account?'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 FirebaseAuth.instance.signOut();
//                 Navigator.pushReplacement(
//                   context,
//                   CustomPageRoute(page: LoginScreen()),
//                 );
//               },
//               child: Text('Yes'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('No'),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final String studentName = widget.studentData['name'] ?? 'Student';
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Welcome, $studentName',
//           style: TextStyle(
//             fontSize: 17,
//             fontFamily: 'Montserrat',
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: _confirmLogout,
//           ),
//         ],
//         centerTitle: true,
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         flexibleSpace: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xFFFF971A), Color(0xFFFFFF67)],
//               transform: GradientRotation(24),
//             ),
//           ),
//         ),
//         automaticallyImplyLeading: false,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage('assets/intro-background.png'),
//             fit: BoxFit.cover,
//           ),
//         ),
//         child: GridView.count(
//           crossAxisCount: 2,
//           padding: EdgeInsets.all(16.0),
//           children: [
//             _buildGridButton(
//               context,
//               'View Schedules',
//               Icons.schedule,
//               ViewSchedulesScreen(
//                 schedules: schedules,
//                 onScheduleUpdated: (updatedSchedules) {
//                   setState(() {
//                     schedules = updatedSchedules;
//                   });
//                 },
//               ),
//             ),
//             _buildGridButton(context, 'Help', Icons.help, ViewHelpScreen()),
//             _buildGridButton(context, 'Profile', Icons.person, null),
//             _buildGridButton(context, 'Faculty Hours', Icons.access_time, ViewFacultyHoursScreen()),
//             _buildGridButton(context, 'Emergency Contacts', Icons.security, ViewEmergencyContactsScreen()),
//             _buildGridButton(context, 'Campus Map', Icons.map, CampusMapScreen()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGridButton(BuildContext context, String title, IconData icon, Widget? navigateTo) {
//     return GestureDetector(
//       onTap: () async {
//         if (title == 'Profile') {
//           try {
//             final data = widget.studentData;
//
//             Navigator.push(
//               context,
//               CustomPageRoute(
//                 page: ViewProfileScreen(
//                   studentName: widget.studentData['name'],
//                   studentID: widget.studentData['id'], // <- correct field
//                   email: widget.studentData['email'],
//                   course: widget.studentData['program'],
//                   section: widget.studentData['section'],
//                   yearLevel: widget.studentData['year level'],
//                   gender: widget.studentData['gender'],
//                   phone: widget.studentData['phone'].toString(),
//                   profilePhoto: 'assets/sample-user.png',
//                 ),
//               ),
//             );
//
//           } catch (e) {
//             print('Error loading profile: $e');
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text('Error loading profile.')),
//             );
//           }
//         } else if (navigateTo != null) {
//           Navigator.push(context, CustomPageRoute(page: navigateTo));
//         }
//       },
//       child: Container(
//         margin: EdgeInsets.all(8.0),
//         decoration: BoxDecoration(
//           color: Color(0xFF0C4B77),
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(icon, size: 40, color: Colors.white),
//             SizedBox(height: 10),
//             Text(
//               title,
//               style: TextStyle(
//                 fontFamily: 'Montserrat',
//                 color: Colors.white,
//                 fontSize: 12,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
