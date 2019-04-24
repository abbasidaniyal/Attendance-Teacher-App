import 'subject_model.dart';

class Teacher {
  String teacherName;
  int teacherID;
  List<Subject> subjects;

  Teacher({this.subjects, this.teacherID, this.teacherName});
}
