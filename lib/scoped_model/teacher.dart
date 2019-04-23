import 'package:scoped_model/scoped_model.dart';
import '../models/teacher_model.dart';
import '../models/subject_model.dart';
import 'package:http/http.dart' as http;

class TeacherModel extends Model {
  Teacher loggedInTeacher;
  bool isTeacherLoaded = false;
  Subject liveAttendanceSubject;
  bool isAttendanceLive = false;

  Future<bool> teacherLogin(String teacherID) async {
    await http.post("http://www.google.com").then((http.Response res) {
      int response = res.statusCode;
      print(response);
      response = 200;
      if (response == 200) {
        loggedInTeacher = Teacher([
          Subject("SUB001", "DBMS"),
          Subject("SUB002", "SS"),
          Subject("SUB003", "OS"),
        ], "TEACHER001", "Tanvir ");

        isTeacherLoaded = true;
        notifyListeners();
      } else {
        isTeacherLoaded = false;
      }
    });
    return isTeacherLoaded;
  }

  Future<bool> startAttendance(String subject) async {
    liveAttendanceSubject = loggedInTeacher.subjects.firstWhere((Subject sub) {
      return sub.subjectName.contains(subject);
    });

    await http.post("http://www.google.com").then((http.Response res) {
      int response = res.statusCode;
      response = 200;
      if (response == 200) {
        isAttendanceLive = true;
      }
    });

    return isAttendanceLive;
  }

  Future<bool> stopAttendance() async {
    return isAttendanceLive;
  }
}
