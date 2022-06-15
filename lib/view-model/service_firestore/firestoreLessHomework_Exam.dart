//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:testgoogle/model/Homework_Lesson_Exam.dart';



class FirestoreLessondevoir extends GetxController {


  ValueNotifier<bool> get loading => _loading;
  
  ValueNotifier<bool> _loading = ValueNotifier(false);
  //Creer une collection de nom "Homework_lessonUser" dans firestoreDatabase Firebase 
  CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection("Homework_lessonUser");
  //Creer une collection de nom "EtudiantUser" dans firestoreDatabase Firebase 
  CollectionReference _userCollectionRef1 =
      FirebaseFirestore.instance.collection("EtudiantUser");

  List<Homework_Lesson> get homework_lesson => _homework_lesson;
  List<Homework_Lesson> _homework_lesson = [];

  

  Future<void> addLesson_Homework_ExamToFireStore(Homework_Lesson courhomeworkinfo) async {
  
    return await _userCollectionRef
        .add(courhomeworkinfo.toJson())
        .then((value) {
     
    });
  }

  

}
