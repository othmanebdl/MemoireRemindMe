import 'package:flutter/material.dart';
import 'package:googleapis/cloudsearch/v1.dart';
import 'package:date_time/date_time.dart';

class Homework_Lesson {
  var homework_lessonuserId, title, typetask, description;
   int jour;
   int mois;
   int year;
   int hour;
   int minute;
  List<String> keywordTitle = [];

  //String dateTime = DateTime.tryParse(date) as String;
  //TimeOfDay time = TimeOfDay.now().toString() as TimeOfDay;
  Homework_Lesson(
      { this.homework_lessonuserId,
       this.description,
       this.keywordTitle,
       this.title,
       this.jour,
       this.mois,
       this.year,
       this.hour,
       this.minute,
     this.typetask});
  Homework_Lesson.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    description = map['description'];
    homework_lessonuserId = map['homework_lessonuserId'];
    title = map['title'];
    jour = map['jour'];
    mois = map['mois'];
    year = map['year'];
    hour = map['hour'];
    minute = map['minute'];
    typetask = map["typetask"];
    keywordTitle = map["keywordTitle"];
  }
  toJson() {
    return {
      'homework_lessonuserId': homework_lessonuserId,
      'title': title,
      'description': description,
      'jour': jour,
      'mois': mois,
      'year': year,
      'hour': hour,
      'minute': minute,
      'typetask': typetask,
      'keywordTitle':keywordTitle
    };
  }
}
