import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/teacher.dart';
import './class_selector_page.dart';

class AttendanceControlPage extends StatefulWidget {
  @override
  _AttendanceControlPageState createState() => _AttendanceControlPageState();
}

class _AttendanceControlPageState extends State<AttendanceControlPage> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TeacherModel>(
        builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Attendance Control Page"),
        ),
        body: Container(
          margin: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Attendance is live for ${model.liveAttendanceSubject.subjectName}",
                  textScaleFactor: 2.0,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                
                child: Text("Stop Attendance"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Are you sure?"),
                        title: Text("Stop Attendance"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: () {
                              TeacherModel model = ScopedModel.of(context);
                              model.stopAttendance().then((responseBool) {
                                if (responseBool) {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return ClassSelector();
                                      },
                                    ),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text("Error"),
                                        );
                                      });
                                }
                              });
                            },
                          ),
                          FlatButton(
                            child: Text("No"),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
