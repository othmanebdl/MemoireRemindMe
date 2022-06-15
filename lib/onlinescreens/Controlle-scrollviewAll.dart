import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/onlinescreens/DetailTask.dart';
import 'package:testgoogle/onlinescreens/Edit_lesson_homework_Exam.dart';
import 'package:testgoogle/videoYoutube/Homepagevideo.dart';
import 'package:testgoogle/videoYoutube/repository/youtube_repository.dart';


//var length;
var pagerouteur = 1;
final FirebaseAuth _auth = FirebaseAuth.instance;
Widget buildListViewAll(ScrollController _scrollController) => StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection("Homework_lessonUser")
        .where("homework_lessonuserId", isEqualTo: "${_auth.currentUser.uid}")
        .snapshots(),
    builder: (BuildContext contexte, AsyncSnapshot snapchot) {
      if (!snapchot.hasData) {
        return Center(child: CircularProgressIndicator());
      } else if (snapchot.data.docs.length == 0) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/books.png",
              width: 60,
              height: 60,
            ),
            Text("All Empty"),
          ],
        ));
      } else {
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
                      colorText: Color.fromARGB(255, 255, 255, 255),
                      backgroundColor: Color(0xffffa500),
                      snackPosition: SnackPosition.TOP,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      isDismissible: true,
                      borderRadius: 20,
                      icon: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ));
                });
              }),
              child: Container(
                width: 20,
                height: 200,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(DetailTask(), arguments: [
                        snapchot.data.docs[index].id,
                        snapchot.data.docs[index].data()['title'],
                        snapchot.data.docs[index].data()['description'],
                        snapchot.data.docs[index].data()['jour'],
                        snapchot.data.docs[index].data()['mois'],
                        snapchot.data.docs[index].data()['year'],
                        snapchot.data.docs[index].data()['hour'],
                        snapchot.data.docs[index].data()['minute'],
                        1
                      ]);
                    },
                    child: Container(
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xff274472),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${snapchot.data.docs[index].data()['title']}",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Date :  ${snapchot.data.docs[index].data()['jour']}/${snapchot.data.docs[index].data()['mois']}/ ${snapchot.data.docs[index].data()['year']}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                                Text(
                                  "Time :  ${snapchot.data.docs[index].data()['hour']}: ${snapchot.data.docs[index].data()['minute']}",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                            IconButton(
                                icon: Icon(Icons.update),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  Get.offAll(EditLessonHomework(), arguments: [
                                    snapchot.data.docs[index].id,
                                    snapchot.data.docs[index].data()['title'],
                                    snapchot.data.docs[index]
                                        .data()['description'],
                                    snapchot.data.docs[index].data()['jour'],
                                    snapchot.data.docs[index].data()['mois'],
                                    snapchot.data.docs[index].data()['year'],
                                    snapchot.data.docs[index].data()['hour'],
                                    snapchot.data.docs[index].data()['minute']
                                  ]);
                                }),
                            IconButton(
                                icon: Icon(Icons.video_camera_back_outlined),
                                color: Colors.white,
                                iconSize: 40,
                                onPressed: () {
                                  YoutubeRepository.querysearch = snapchot
                                      .data.docs[index]
                                      .data()['title']
                                      .toString();
                                  //ouvrir la page des video de tache
                                  Get.to(Homepagevideo());
                                }),
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
      }
    });

Widget buildBTTAll(ScrollController _scrollController, bool backtoTop) =>
    backtoTop
        ? Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton.extended(
                splashColor: Color(0xff3a5ba0),
                backgroundColor: Color(0xff3a5ba0),
                onPressed: () {
                  _scrollController.animateTo(0,
                      duration: Duration(seconds: 1), curve: Curves.linear);
                },
                label: Text(
                  "Back to Top",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        : SizedBox();
Widget buildTextAll(bool isLastIndex) => isLastIndex
    ? Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          "All caught up ",
          style: TextStyle(
              color: Color(0xffffa500),
              fontWeight: FontWeight.bold,
              fontSize: 20.00),
        ),
      )
    : SizedBox();
