import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/screens/Add_tasks_online.dart';
import 'package:testgoogle/screens/DetailTask.dart';
import 'package:testgoogle/screens/Edit_lesson_homework.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/RemindMe-page2.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SearchTask extends StatefulWidget {
  SearchTask({Key key}) : super(key: key);

  @override
  State<SearchTask> createState() => _SearchTaskState();
}

class _SearchTaskState extends State<SearchTask> {
  var pagerouteur;

  String dataTaskLessonDevoir = "";
  int _cuurentindexNvaivgationBar = 0;
  void _changeItem(int value) {
    setState(() {
      _cuurentindexNvaivgationBar = value;
    });
    switch (value) {
      case 0:
        {
          Get.to(RemindMe1(), transition: Transition.fade);
          break;
        }
      case 1:
        {
          Get.to(AddTask_online(), transition: Transition.fade);
          break;
        }
      case 2:
        {
          Get.to(SearchTask(), transition: Transition.fade);
          break;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) {
            return    GestureDetector(
                 onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
          child: Scaffold(
     
            bottomNavigationBar: ConvexAppBar(
                items: [
                  TabItem(
                      icon: Icon(Icons.home, color: Color(0xff274472)),
                      title: "Home"),
                  TabItem(
                      icon: Icon(Icons.add, color: Color(0xff274472)),
                      title: "Add"),
                  TabItem(
                      icon: Icon(Icons.search, color: Color(0xff274472)),
                      title: "Search"),
                ],
                initialActiveIndex: 2,
                onTap: _changeItem,
                backgroundColor: Color(0xfff0f0f0),
                activeColor: Colors.white),
            resizeToAvoidBottomInset: false,
            body: Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height,
                  maxWidth: MediaQuery.of(context).size.width),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff1f4690),Color(0xff1f4690)],
                    begin: Alignment.topLeft,
                    end: Alignment.centerRight),
              ),
              child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  margin: EdgeInsets.only(top: 80, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    // border: Border.all(color: Color(0xff4B5563),),
                  ),
                  child: TextField(
                    onTap: () {
                      //_buttomsheetlogin(context);
                    },
                    onChanged: (val) {
                      setState(() {
                        dataTaskLessonDevoir = val;
                      });
                    },
                    cursorColor: Colors.grey,
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Color(0xff274472)),
                      hintText: "Search",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 22),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("Homework_lessonUser")
                            .where("homework_lessonuserId",
                                isEqualTo: "${_auth.currentUser.uid}")
                            .where("keywordTitle",
                                arrayContains: dataTaskLessonDevoir)
                            .snapshots(),
                        builder: (context, AsyncSnapshot snapchot) {
                      
                          if (!snapchot.hasData) {
        return Center(child: CircularProgressIndicator());
      } else if (snapchot.data.docs.length == 0) {
        return Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/calendar.png",
              width: 60,
              height: 60,
            ),
            Text("Enter Title Task for Search"),
          ],
        ));
      }
                          /*if (snapchot.data.docs.length==0) {
                             return Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "images/calendar.png",
                                  width: 60,
                                  height: 60,
                                ),
                                Text("Enter Title Task for Search"),
                              ],
                            ));
                          }*/ else {
                            return Container(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              height: 380,
                              child: ListView.builder(
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
                                            colorText:
                                                Color.fromARGB(255, 87, 78, 78),
                                            snackPosition: SnackPosition.TOP);
                                      });
                                    }),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(DetailTask(), arguments: [
                                          snapchot.data.docs[index].id,
                                          snapchot.data.docs[index].data()['title'],
                                          snapchot.data.docs[index]
                                              .data()['description'],
                                          snapchot.data.docs[index].data()['jour'],
                                          snapchot.data.docs[index].data()['mois'],
                                          snapchot.data.docs[index].data()['year'],
                                          snapchot.data.docs[index].data()['hour'],
                                          snapchot.data.docs[index]
                                              .data()['minute'],
                                          pagerouteur
                                        ]);
                                      },
                                      child: Container(
                                        width: 20,
                                        height: 190,
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Container(
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xff274472),
                                            ),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${snapchot.data.docs[index].data()['title']}",
                                                        style: TextStyle(
                                                            fontSize: 30,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white),
                                                      ),
                                                      Text(
                                                        "Date :  ${snapchot.data.docs[index].data()['jour']}/${snapchot.data.docs[index].data()['mois']}/ ${snapchot.data.docs[index].data()['year']}",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white),
                                                      ),
                                                      Text(
                                                        "Time :  ${snapchot.data.docs[index].data()['hour']}: ${snapchot.data.docs[index].data()['minute']}",
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  IconButton(
                                                      icon: Icon(Icons.update),
                                                      color: Colors.white,
                                                      iconSize: 40,
                                                      onPressed: () {
                                                        Get.offAll(
                                                            EditLessonHomework(),
                                                            arguments: [
                                                              snapchot.data
                                                                  .docs[index].id,
                                                              snapchot
                                                                  .data.docs[index]
                                                                  .data()['title'],
                                                              snapchot
                                                                  .data.docs[index]
                                                                  .data()['jour'],
                                                              snapchot
                                                                  .data.docs[index]
                                                                  .data()['mois'],
                                                              snapchot
                                                                  .data.docs[index]
                                                                  .data()['year'],
                                                              snapchot
                                                                  .data.docs[index]
                                                                  .data()['hour'],
                                                              snapchot
                                                                  .data.docs[index]
                                                                  .data()['minute']
                                                            ]);
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
                              ),
                            );
                          }
                        }),
                  ),
                ),
              ]),
            ),
          ));
        }
      ),
    );
  }
}

       