import 'subject_model.dart';

class Teacher {
  String teacherName;
  String teacherID;
  List<Subject> subjects;

  Teacher(this.subjects, this.teacherID, this.teacherName);
}
