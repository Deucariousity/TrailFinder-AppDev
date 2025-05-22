import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class College5Screen extends StatefulWidget {
  @override
  _College5ScreenState createState() => _College5ScreenState();
}

class _College5ScreenState extends State<College5Screen> {
  final PhotoViewController _photoViewController = PhotoViewController();

  final List<String> buildings = [
    'Building 4',
    'Building 5',
    'Building 18',
    'Building 19',
    'Building 20',
    'Building 42',
    'Building 43',
  ];

  final Map<String, List<String>> roomData = {
    'Building 4': ['Room 4-101 - Lecture Room'],
    'Building 5': [
      'Room 5-101 - Lecture Room',
      'Room 5-102 - Lecture Room',
      'Room 5-103 - Lecture Room',
      'Room 5-104 - Lecture Room',
      'Room 5-105 - Lecture Room',
      'Room 5-106 - Lecture Room',
      'Room 5-107 - Lecture Room',
      'Room 5-108 - Lecture Room',
      'Room 5-109 - Lecture Room',
    ],
    'Building 18': [
      'Room 18-101 - Culinary Lab',
      'Room 18-102 - Culinary Lab',
      'Room 18-103 - Culinary Lab',
    ],
    'Building 19': [
      'Room 19-101 - ROTC Office',
      'Room 19-102 - NSTP Office',
      'Room 19-103 - ROTC Armory',
    ],
    'Building 20': ['Cafeteria'],
    'Building 42': [
      'First Floor',
      'Room 42-101 - Research Director Office',
      'Room 42-102 - IGIS Office',
      'Second Floor',
      'Room 42-201 - Mechanical Eng. Lab',
      'Room 42-202 - Power Electronics Lab',
      'Room 42-203 - Microelectronics Lab',
      'Room 42-204 - Electrical Eng. Lab',
      'Third Floor',
      'Room 42-301 - Lecture Room',
      'Room 42-302 - Lecture Room',
      'Room 42-303 - Lecture Room',
      'Room 42-304 - Lecture Room',
      'Fourth Floor',
      'Room 42-401 - SMART Classroom',
      'Room 42-402 - Testing Center',
      'Room 42-403 - Multimedia Lab',
      'Room 42-404 - DTL, DSPED, DEPA Office',
      'Fifth Floor',
      'Room 42-501 - CSTE Dean\'s Office',
      'Room 42-502 - Science Education Dept.',
      'Room 42-503 - Math Education Dept.',
      'Room 42-504 - TLE and Teacher Technician Education Dept.',
      'Sixth Floor',
      'Room 42-601 - PAT AVR',
    ],
    'Building 43': [
      'First Floor',
      'Room 43-101 - CEA Dean\'s Office',
      'Room 43-102 - Accreditation Office',
      'Room 43-103 - Civil Eng. Dept',
      'Second Floor',
      'Room 43-201 - ECRD Office',
      'Room 43-202 - CEA Library',
      'Third Floor',
      'Room 43-301 - Electronics Eng. Dept',
      'Room 43-302 - Computer Eng. Dept',
      'Room 43-303 - Electrical Eng. Dept',
      'Fourth Floor',
      'Room 43-401 - USTP Villanueva Campus Sub Office',
      'Room 43-402 - Printing Press',
      'Room 43-403 - Lecture Room',
      'Fifth Floor',
      'Room 43-501 - Chancellors Office',
      'Room 43-502 - Conference Room',
      'Sixth Floor',
      'Room 43-601 - Drawing Room',
      'Room 43-602 - Drawing Room',
      'Seventh Floor',
      'Room 43-701 - Architecture Dept.',
      'Room 43-702 - CADD Lab',
      'Room 43-703 - MatLab Lab',
      'Eighth Floor',
      'Room 43-801 - Mechanical Eng. Dept',
      'Room 43-802 - Studio Room',
      'Room 43-803 - Studio Room',
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
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.red[700])), // Red accent
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
                  labelColor: Colors.red[700], // Red accent for selected tab
                  unselectedLabelColor: Colors.grey[600],
                  indicatorColor: Colors.red[700], // Red accent for indicator
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
                                leading: Icon(Icons.meeting_room, color: Colors.red.withOpacity(0.7)), // Red accent icon
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
              child: Text('Close', style: TextStyle(fontFamily: 'Montserrat', color: Colors.red[700])), // Red accent
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
          'CEA',
          style: TextStyle(fontFamily: 'Montserrat', fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: Colors.red,
        elevation: 2, // Slight shadow for depth
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black), // Red accent for back icon
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
                  controller: _photoViewController,
                  imageProvider: AssetImage('assets/college5.png'),
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
                    leading: Icon(Icons.apartment, color: Colors.red[700]), // Red accent icon
                    title: Text(
                      building,
                      style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Colors.red.withOpacity(0.7)), // Red accent icon
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