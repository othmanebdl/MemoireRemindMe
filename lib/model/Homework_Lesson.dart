import 'package:flutter/material.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:date_time/date_time.dart';

class Homework_Lesson {
  var homework_lessonuserId, title, typetask;
  late int jour;
  late int mois;
  late int year;
  late int hour;
  late int minute;

  //String dateTime = DateTime.tryParse(date) as String;
  //TimeOfDay time = TimeOfDay.now().toString() as TimeOfDay;
  Homework_Lesson(
      {required this.homework_lessonuserId,
      required this.title,
      required this.jour,
      required this.mois,
      required this.year,
      required this.hour,
      required this.minute,
      required this.typetask});
  Homework_Lesson.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    homework_lessonuserId = map['homework_lessonuserId'];
    title = map['title'];
    jour = map['jour'];
    mois = map['mois'];
    year = map['year'];
    hour = map['hour'];
    minute = map['minute'];
    typetask = map["typetask"];
  }
  toJson() {
    return {
      'homework_lessonuserId': homework_lessonuserId,
      'title': title,
      'jour': jour,
      'mois': mois,
      'year': year,
      'hour': hour,
      'minute': minute,
      'typetask':typetask
    };
  }
}
