// import 'package:flutter/material.dart';
//
// class CampusColleges extends StatelessWidget {
//   const CampusColleges({Key? key}) : super(key: key);
//
//   final List<Map<String, String>> colleges = const [
//     {'name': 'College of Engineering', 'description': 'Focuses on engineering programs like Civil, Electrical, and Mechanical Engineering.'},
//     {'name': 'College of Computer Studies', 'description': 'Offers programs like BS Computer Science, BS Information Technology, etc.'},
//     {'name': 'College of Business', 'description': 'Covers business-related programs such as Marketing, Management, and Finance.'},
//     {'name': 'College of Education', 'description': 'Trains future teachers and educators in various specializations.'},
//     {'name': 'College of Arts and Sciences', 'description': 'Offers a wide range of programs in the arts, humanities, and sciences.'},
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Campus Colleges'),
//       ),
//       body: ListView.builder(
//         itemCount: colleges.length,
//         itemBuilder: (context, index) {
//           final college = colleges[index];
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: ListTile(
//               title: Text(college['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
//               subtitle: Text(college['description']!),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
