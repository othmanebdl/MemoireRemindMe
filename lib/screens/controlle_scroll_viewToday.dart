import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/screens/Add_tasks.dart';
import 'package:testgoogle/screens/Edit_lesson_homework.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

//var length;
DateTime date = DateTime.now();

final FirebaseAuth _auth = FirebaseAuth.instance;
Widget buildListViewToday(ScrollController _scrollController) => StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("Homework_lessonUser")
        .where("homework_lessonuserId", isEqualTo: "${_auth.currentUser!.uid}")
        .where("jour", isEqualTo: date.day)
        .where("mois", isEqualTo: date.month)
        .where("year", isEqualTo:date.year )
        .snapshots(),
    builder: (BuildContext contexte, AsyncSnapshot snapchot) {
      //length = snapchot.data.docs.length;

      if (!snapchot.hasData) {
        return Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        controller: _scrollController,
        physics: BouncingScrollPhysics(),
        itemCount: snapchot.data.docs.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            onDismissed: ((direction) async {
              await FirebaseFirestore.instance
                  .collection("Homework_lessonUser")
                  .doc("${snapchot.data.docs[index].id}")
                  .delete()
                  .then((value) {
                Get.snackbar("Succusful", "Task deleted",
                    colorText: Color.fromARGB(255, 87, 78, 78),
                    snackPosition: SnackPosition.TOP);
              });
            }),
            child: Container(
              width: 20,
              height: 190,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Container(
                  width: 20,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, top: 18),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: [
                          Text(
                            "${snapchot.data.docs[index].data()['title']}",
                            style: TextStyle(fontSize: 27, color: Colors.red),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Date :  ${snapchot.data.docs[index].data()['jour']}/${snapchot.data.docs[index].data()['mois']}/ ${snapchot.data.docs[index].data()['year']}",
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(
                              icon: Icon(Icons.update),
                              color: Colors.green,
                              onPressed: () {
                                Get.offAll(EditLessonHomework(), arguments: [
                                  snapchot.data.docs[index].id,
                                  snapchot.data.docs[index].data()['title'],
                                  snapchot.data.docs[index].data()['jour'],
                                  snapchot.data.docs[index].data()['mois'],
                                  snapchot.data.docs[index].data()['year'],
                                  snapchot.data.docs[index].data()['hour'],
                                  snapchot.data.docs[index].data()['minute']
                                ]);
                              }),
                          Text(
                            "Time :  ${snapchot.data.docs[index].data()['hour']}: ${snapchot.data.docs[index].data()['minute']}",
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    });

Widget buildBTTToday(ScrollController _scrollController, bool backtoTop) =>
    backtoTop
        ? Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                splashColor: Colors.red,
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(seconds: 2), curve: Curves.linear);
                },
                label: Text(
                  "Back to Top",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        : SizedBox();

Widget buildTextToday(bool isLastIndex) => isLastIndex
    ? Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "All caught up 🎉",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20.00),
        ),
      )
    : SizedBox();
