import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class College2Screen extends StatefulWidget {
  @override
  _College2ScreenState createState() => _College2ScreenState();
}

class _College2ScreenState extends State<College2Screen> {
  final List<String> buildings = ['Building 27', 'Building 28', 'Building 41'];

  final Map<String, List<String>> roomData = {
    'Building 27': [
      'First Floor',
      'Clinic',
      'University Health Center',
      'College of Medicine Dept.',
      'Second Floor',
      'OSA Office',
    ],
    'Building 28': [
      'Room 28-101 - Lecture Room',
      'Room 28-102 - Lecture Room',
      'Room 28-103 - Lecture Room',
      'Room 28-104 - Lecture Room',
      'Room 28-105 - Lecture Room',
      'Room 28-106 - Lecture Room',
      'Room 28-107 - Lecture Room',
      'Room 28-108 - Lecture Room',
      'Room 28-109 - Lecture Room',
      'Room 28-110 - Lecture Room',
      'Room 28-111 - Laboratory Management Office',
    ],
    'Building 41': [
      'First Floor',
      'Room 41-101 - Guidance Service Office',
      'Room 41-102 - Admission and Scholarship Office',
      'Room 41-103 - Inorganic and Industrial Chem Lab',
      'Room 41-104 - Social Science Office',
      'Room 41-105 - CSM Library',
      'Room 41-106 - USTP Alubijid Sub Office',
      'Room 41-107 - Office of Vice Chancellor for Academic Affairs',
      'Second Floor',
      'Room 41-201 - Instruments Lab 1',
      'Room 41-202 - Instruments Lab 2',
      'Room 41-203 - Heating and Related Facilities Lab',
      'Room 41-204 - Center for Research and Adv. Sciences',
      'Room 41-205 - Instruments Lab 3',
      'Room 41-206 - Chem. Research Lab',
      'Room 41-207A - Testing Lab',
      'Room 41-207B - Chemistry Dept.',
      'Third Floor',
      'Room 41-301 - Physics Lab',
      'Room 41-302 - Instrument Room',
      'Room 41-303 - Physics Lab',
      'Room 41-304 - Physics Lab/FST Research Lab',
      'Room 41-305 - FST Stockroom',
      'Room 41-306 - FST research lab',
      'Room 41-307A - Physics Dept.',
      'Room 41-307B - Applied Physics Dept.',
      'Fourth Floor',
      'Room 41-401 - Applied Math Dept.',
      'Room 41-402 - EST Lab',
      'Room 41-403 - Envi Microbiology and Thesis Lab',
      'Room 41-404 - ES Lab',
      'Room 41-405 - Food Prep. Lab',
      'Room 41-406 - Physics Lab',
      'Room 41-407 - EST and FST Dept.',
      'Fifth Floor',
      'Room 41-501 - Chem Lab',
      'Room 41-502 - Chem Prep Room',
      'Room 41-503 - Stock Room',
      'Room 41-504 - Chem Lab',
      'Room 41-505 - Chem Lab',
      'Room 41-506 - Biochem and Organic Lab',
      'Room 41-507 - CSM Dean\'s Office',
    ],
  };

  void _showRooms(String buildingName) {
    final rooms = roomData[buildingName];

    if (rooms == null || rooms.isEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(buildingName, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black87)),
          content: Text('No room data available for this building.', style: TextStyle(fontFamily: 'Montserrat', color: Colors.black87)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.green[700])), // Green accent
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
        ),
      );
      return;
    }

    final Map<String, List<String>> floorMap = {};
    String currentFloor = 'Rooms'; // Default for rooms without a specific floor header

    for (String entry in rooms) {
      final isFloorHeader = RegExp(
        r'^(First|Second|Third|Fourth|Fifth|Sixth|Seventh|Eighth|Ground) Floor$',
        caseSensitive: false,
      ).hasMatch(entry) || entry.toLowerCase().contains('floor');

      if (isFloorHeader) {
        currentFloor = entry;
        floorMap[currentFloor] = [];
      } else {
        floorMap.putIfAbsent(currentFloor, () => []).add(entry);
      }
    }

    showDialog(
      context: context,
      builder: (_) => DefaultTabController(
        length: floorMap.length,
        child: AlertDialog(
          title: Text(
            buildingName,
            style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          content: SizedBox(
            width: double.maxFinite,
            height: 400,
            child: Column(
              children: [
                TabBar(
                  isScrollable: true,
                  labelColor: Colors.green[700], // Green accent for selected tab
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Colors.green[700], // Green accent for indicator
                  labelStyle: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                  unselectedLabelStyle: TextStyle(fontFamily: 'Montserrat'),
                  tabs: floorMap.keys.map((floor) => Tab(text: floor)).toList(),
                ),
                Expanded(
                  child: TabBarView(
                    children: floorMap.values.map((roomList) {
                      return ListView.builder(
                        itemCount: roomList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
                            child: Card(
                              elevation: 2,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                leading: Icon(Icons.meeting_room, color: Colors.green.withOpacity(0.7)), // Green accent icon
                                title: Text(roomList[index], style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, color: Colors.black87)),
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.green[700])), // Green accent
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light grey background for a cleaner look
      appBar: AppBar(
        title: Text(
          'CSM',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.green,
        elevation: 2, // Slight shadow for depth
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Green accent for back icon
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background for the map
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)), // Rounded bottom corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
                child: PhotoView(
                  imageProvider: AssetImage('assets/college2.png'),
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: PhotoViewComputedScale.covered * 2,
                  backgroundDecoration: BoxDecoration(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select a Building to View Rooms',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: ListView.builder(
              itemCount: buildings.length,
              itemBuilder: (context, index) {
                final building = buildings[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    leading: Icon(Icons.apartment, color: Colors.green[700]), // Green accent icon
                    title: Text(
                      building,
                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.green.withOpacity(0.7)),
                    onTap: () => _showRooms(building),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}