import 'package:scoped_model/scoped_model.dart';
import '../models/teacher_model.dart';
import '../models/subject_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TeacherModel extends Model {
  Teacher loggedInTeacher;
  bool isTeacherLoaded = false;
  Subject liveAttendanceSubject;
  bool isAttendanceLive = false;

  Future<bool> teacherLogin(String teacherID) async {
    await http
        .get(
            "http://13.232.66.83:8000/students/which-teacher/${int.parse(teacherID)}")
        .then((http.Response res) async {
      int response = res.statusCode;
      print(response);
      response = 200;
      if (response == 200) {
        var a = json.decode(res.body);
        print(a);
        int teacherId = a["teacher_id"];
        print(teacherId);
        await http
            .get("http://13.232.66.83:8000/students/subject-teacher/$teacherId")
            .then((http.Response resSub) {
          print(resSub.body);
          if (resSub.statusCode == 200) {
            var b = json.decode(resSub.body);
            List<Subject> v = [];
            for (var item in b) {
              Subject d = Subject(
                sID: item["subject_id"],
                subjectName: item["subject_name"],
                isLive: item["is_live"],
              );
              v.add(d);
            }

            loggedInTeacher = Teacher(
                teacherID: a["teacher_id"],
                teacherName: a["first_name"] + a["last_name"],
                subjects: v);

            print(loggedInTeacher);
            isTeacherLoaded = true;
            notifyListeners();
          } else {
            isTeacherLoaded = false;
          }
        }).catchError((onError) {
          print(onError);
        }).timeout(Duration(seconds: 30));
      } else {
        isTeacherLoaded = false;
      }
    }).catchError((onError) {
      print(onError.toString());
    }).timeout(Duration(seconds: 30));

    return isTeacherLoaded;
  }

  Future<bool> startAttendance(String subject) async {
    liveAttendanceSubject = loggedInTeacher.subjects.firstWhere((Subject sub) {
      return sub.subjectName.contains(subject);
    });

    await http.patch(
        "http://13.232.66.83:8000/students/attendace-status/${liveAttendanceSubject.sID}",
        body: {"is_live": "L"}).then((http.Response res) {
      int response = res.statusCode;
      response = 200;
      if (response == 200) {
        isAttendanceLive = true;
      }
    }).catchError((onError){

    }).timeout(Duration(seconds: 30));

    return isAttendanceLive;
  }

  Future<bool> stopAttendance() async {
    await http.patch(
        "http://13.232.66.83:8000/students/attendace-status/${liveAttendanceSubject.sID}",
        body: {"is_live": "NL"}).then((http.Response res) {
      int response = res.statusCode;
      response = 200;
      if (response == 200) {
        isAttendanceLive = false;
      }
    }).catchError((onError){

    }).timeout(Duration(seconds: 30));

    return !isAttendanceLive;
  }
}
