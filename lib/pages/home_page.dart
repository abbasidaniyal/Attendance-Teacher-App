import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './class_selector_page.dart';

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
          RaisedButton(
            child: Text("Submmit"),
            onPressed: () {
              print(teacherID);

              //SEND AND CHECK WITH DB
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
                    content: Text("Sorry. Please Check your Teacher ID"),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
