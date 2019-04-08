import 'package:flutter/material.dart';

class ClassSelector extends StatelessWidget {
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
              child: DropdownButton(
                hint: Text("HINT"),
                isExpanded: true,

                items: [
                  DropdownMenuItem(child: Text("CEN 201")),
                  DropdownMenuItem(child: Text("CEN 202")),
                  DropdownMenuItem(child: Text("CEN 301")),
                  DropdownMenuItem(child: Text("CEN 302"))
                ],
                // value: "Select Class",
                onChanged: (value) {
                  print(value);
                },
              ),
            ),
            RaisedButton(
              child: Text("Make Attendance Live"),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        content: Text("Are you sure?"),
                        title: Text("Make Attendance Live"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text("Yes"),
                            onPressed: () {
                              Navigator.pop(context);
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
                    });
              },
            )
          ],
        ));
  }
}
