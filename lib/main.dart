import 'package:flutter/material.dart';
import './pages/home_page.dart';
import 'package:scoped_model/scoped_model.dart';

import './scoped_model/teacher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScopedModel<TeacherModel>(
      model: TeacherModel(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: HomePage(),
      ),
    );
  }
}
