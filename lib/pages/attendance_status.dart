import 'package:flutter/material.dart';
import './attendance_control_page.dart';

class AttendanceStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            InkWell(
              child: Text("Home",textScaleFactor: 1.5,),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AttendanceControlPage();
                }));
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            InkWell(
              child: Text("Attendance Status",textScaleFactor: 1.5,),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return AttendanceStatus();
                }));
              },
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(),
      ),
    );
  }
}
