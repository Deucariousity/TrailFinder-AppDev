import 'package:flutter/material.dart';
import 'add_schedule_screen.dart';
import 'view_alerts_screen.dart';

class ViewSchedulesScreen extends StatefulWidget {
  final List<String> schedules;
  final Function(List<String>) onScheduleUpdated;

  ViewSchedulesScreen({required this.schedules, required this.onScheduleUpdated});

  @override
  _ViewSchedulesScreenState createState() => _ViewSchedulesScreenState();
}

class _ViewSchedulesScreenState extends State<ViewSchedulesScreen> {
  List<String> alerts = [];

  void _updateAlerts(String schedule, bool isAdding) {
    if (isAdding) {
      alerts.add("Upcoming: $schedule");
    } else {
      alerts.remove("Upcoming: $schedule");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Schedules'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors:  [
                Color(0xFFFF971A),
                Color(0xFFFFFF67),
              ],
                  transform: GradientRotation(24)
              )
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddScheduleScreen(
                    onScheduleAdded: (newSchedule) {
                      widget.schedules.add(newSchedule);
                      _updateAlerts(newSchedule, true); // Add alert
                      widget.onScheduleUpdated(widget.schedules);
                    },
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ViewAlertsScreen(alerts: alerts),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/intro-background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: widget.schedules.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(widget.schedules[index], style: TextStyle(color: Colors.black)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddScheduleScreen(
                            onScheduleAdded: (updatedSchedule) {
                              _updateAlerts(widget.schedules[index], false); // Remove old alert
                              widget.schedules[index] = updatedSchedule;
                              _updateAlerts(updatedSchedule, true); // Add new alert
                              widget.onScheduleUpdated(widget.schedules);
                            },
                            existingSchedule: widget.schedules[index],
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _updateAlerts(widget.schedules[index], false); // Remove alert
                      widget.schedules.removeAt(index);
                      widget.onScheduleUpdated(widget.schedules);
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}