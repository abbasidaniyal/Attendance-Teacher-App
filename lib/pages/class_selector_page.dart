import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_model/teacher.dart';
import '../models/subject_model.dart';
import './attendance_control_page.dart';

class ClassSelector extends StatefulWidget {
  @override
  _ClassSelectorState createState() => _ClassSelectorState();
}

class _ClassSelectorState extends State<ClassSelector> {
  String selectedSubject;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Class Selector"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.all(100.0),
              child: ScopedModelDescendant<TeacherModel>(
                builder:
                    (BuildContext context, Widget child, TeacherModel model) {
                  return DropdownButton(
                    hint: Text("Select Subject"),
                    value: selectedSubject,
                    isExpanded: true,
                    items: model.loggedInTeacher.subjects.map((f) {
                      return DropdownMenuItem(
                        value: f.subjectName,
                        child: Text(f.subjectName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selectedSubject = value;
                      });
                    },
                  );
                },
              )),
          RaisedButton(
            child: Text("Make Attendance Live"),
            onPressed: () {
              if (selectedSubject != null) {
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text("Are you sure?"),
                      title: Text("Make Attendance Live"),
                      actions: <Widget>[
                        FlatButton(
                          child: Text("Yes"),
                          onPressed: () {
                            TeacherModel model = ScopedModel.of(context);
                            model
                                .startAttendance(selectedSubject)
                                .then((responseBool) {
                              if (responseBool) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return AttendanceControlPage();
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
              } else {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Please select a subject"),
                      );
                    });
              }
            },
          )
        ],
      ),
    );
  }
}
