//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:testgoogle/model/Homework_Lesson.dart';

import '../auth_view_model.dart';

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
 // DateTime dateTime = DateTime.now();
  FirestoreLessondevoir() {
   // getData();
  }

  Future<void> addLesson_Homework_ExamToFireStore(Homework_Lesson courhomeworkinfo) async {
    // return await _userCollectionRef
    //   .doc(courhomeworkinfo.title)
    // .set(courhomeworkinfo.toJson());
    /*return await _userCollectionRef1
        .doc(id)
        .collection("Homework_lessonUser")
        .add(courhomeworkinfo.toJson())
        .then(((value) {
           print("user add");

        }
        )
        );*/
    return await _userCollectionRef
        .add(courhomeworkinfo.toJson())
        .then((value) {
     
    });
  }

  /*Future<void> filter() async {
    await _userCollectionRef
        .where("jour", isEqualTo: dateTime.day)
        .where("mois", isEqualTo: dateTime.month)
        .where("year", isEqualTo: dateTime.year)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        // print(element.data());

        print("-----------------------");
      });
    });
  }*/

 /* getData() async {
    loading.value = true;

    await _userCollectionRef
        //.where("homework_lessonuserId",isEqualTo:"pAVzILrf61bgtLYwT3wCukuzmPH3" )
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        _homework_lesson.add(Homework_Lesson.fromJson(
            value.docs[i].data() as Map<String, dynamic>));
        // print(_homework_lesson.length);
        _loading.value = false;
      }
      update();
    });
  }*/
}
