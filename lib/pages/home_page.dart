import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

import './class_selector_page.dart';

import '../scoped_model/teacher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String teacherID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teacher Attendance App"),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(50.0),
            child: TextField(
              decoration: InputDecoration(labelText: "Enter Teacher ID"),
              onChanged: (String value) {
                setState(() {
                  teacherID = value;
                });
              },
            ),
          ),
          Builder(
            builder: (context) {
              return RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  print(teacherID);

                  TeacherModel model = ScopedModel.of(context);
                  model.teacherLogin(teacherID).then((bool response) {
                    if (true) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) {
                            return ClassSelector();
                          },
                        ),
                      );
                    } else {
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Sorry. Please Check your Teacher ID or check internet connection"),
                        ),
                      );
                    }
                  });
                },
              );
            },
          )
        ],
      ),
    );
  }
}
