// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
//
// class MeetingTime {
//   List<String> days = [];
//   TimeOfDay startTime = TimeOfDay(hour: 12, minute: 0);
//   TimeOfDay endTime = TimeOfDay(hour: 12, minute: 0);
//   String location = '';
// }
//
// class AddScheduleScreen extends StatefulWidget {
//   final Function(List<String>) onScheduleAdded;
//   final String? prefillDay;
//
//   AddScheduleScreen({required this.onScheduleAdded, this.prefillDay});
//
//   @override
//   _AddScheduleScreenState createState() => _AddScheduleScreenState();
// }
//
// class _AddScheduleScreenState extends State<AddScheduleScreen> {
//   final TextEditingController _courseController = TextEditingController();
//   final List<MeetingTime> _meetingTimes = [MeetingTime()];
//
//   final List<String> days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.prefillDay != null) {
//       _meetingTimes.first.days.add(widget.prefillDay!);
//     }
//   }
//
//   Future<void> _selectTime(BuildContext context, TimeOfDay initialTime, Function(TimeOfDay) onSelected) async {
//     final picked = await showTimePicker(context: context, initialTime: initialTime);
//     if (picked != null) onSelected(picked);
//   }
//
//   Widget _buildMeetingCard(MeetingTime mt) {
//     return Card(
//       margin: EdgeInsets.symmetric(vertical: 8),
//       elevation: 2,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Wrap(
//               spacing: 6.0,
//               children: days.map((day) {
//                 return FilterChip(
//                   label: Text(day),
//                   selected: mt.days.contains(day),
//                   onSelected: (selected) {
//                     setState(() {
//                       selected ? mt.days.add(day) : mt.days.remove(day);
//                     });
//                   },
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 10),
//             Wrap(
//               spacing: 10,
//               runSpacing: 8,
//               children: [
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text("Start Time: "),
//                     TextButton(
//                       onPressed: () => _selectTime(context, mt.startTime, (time) {
//                         setState(() => mt.startTime = time);
//                       }),
//                       child: Text(mt.startTime.format(context)),
//                     ),
//                   ],
//                 ),
//                 Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text("End Time: "),
//                     TextButton(
//                       onPressed: () => _selectTime(context, mt.endTime, (time) {
//                         setState(() => mt.endTime = time);
//                       }),
//                       child: Text(mt.endTime.format(context)),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             TextField(
//               decoration: InputDecoration(labelText: 'Location'),
//               onChanged: (val) => mt.location = val,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void _submitCourse() {
//     if (_courseController.text.trim().isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Course title is required")));
//       return;
//     }
//
//     List<String> schedules = [];
//
//     for (var mt in _meetingTimes) {
//       for (var day in mt.days) {
//         schedules.add(
//             "$day - ${_courseController.text.trim()} - ${mt.startTime.format(context)} - ${mt.endTime.format(context)} - ${mt.location.trim()}"
//         );
//       }
//     }
//
//     widget.onScheduleAdded(schedules);
//     Navigator.pop(context);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Course', style: TextStyle(fontSize: 20, fontFamily: 'Montserrat', color: Colors.black)),
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
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: _courseController,
//               decoration: InputDecoration(labelText: 'Course Title (required)'),
//             ),
//             SizedBox(height: 12),
//             ..._meetingTimes.map((mt) => _buildMeetingCard(mt)).toList(),
//             TextButton(
//               onPressed: () {
//                 setState(() => _meetingTimes.add(MeetingTime()));
//               },
//               child: Text("Add Another Meeting Time"),
//             ),
//             SizedBox(height: 16),
//             Center(
//               child: ElevatedButton(
//                 onPressed: _submitCourse,
//                 child: Text('Add Course'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }