// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/artifactregistry/v1.dart';
//import 'package:memoire/Widgts/LIstView.dart';
//import 'package:memoire/screens/Add_tasks.dart';

import 'package:testgoogle/screens/Add_tasks_online.dart';
//import 'package:memoire/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/Controlle-scrollviewAll.dart';
import 'package:testgoogle/screens/controlle_scroll_viewToday.dart';
import 'package:testgoogle/screens/controlle_scroll_viexExam.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/screens/controlle_scroll_viewHomework.dart';
import 'package:testgoogle/screens/controlle_scroll_viewlesson.dart';

CollectionReference userCollectionRef =
    FirebaseFirestore.instance.collection("Homework_lessonUser");

class RemindMe2 extends StatefulWidget {
  const RemindMe2({Key key}) : super(key: key);

  @override
  State<RemindMe2> createState() => _RemindMe2State();
}

class _RemindMe2State extends State<RemindMe2> {
  var typetask = Get.arguments;
  var routeur = Get.arguments;
  ScrollController _scrollController = new ScrollController();
  bool backtoTop = false;
  bool isLastIndex = false;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        backtoTop = _scrollController.offset > 400 ? true : false;
        isLastIndex = _scrollController.offset >
                _scrollController.position.maxScrollExtent
            ? true
            : false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
       Color(0xff274472),
       Color(0xff274472)
          ], begin: Alignment.topLeft, end: Alignment.centerRight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 60.0),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.arrow_back_ios,
                                size: 27, color: Colors.white),
                            onPressed: () {
                              Get.to(RemindMe1());
                            }),
                        SizedBox(width: 15),
                        if (typetask == 1) ...[
                          Text('All tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway')),
                        ] else if (typetask == 2) ...[
                          Text('Today tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway')),
                        ] else if (typetask == 3) ...[
                          Text('Home Work tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway')),
                        ] else if(typetask==4)...[
                          Text('Lessons tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway')),
                        ]
                        else ...{
                          Text('Exam tasks',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Raleway')),
                        }
                      ],
                    ),
                  ),
                 
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              flex: 5,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                ),
                child: Stack(
                  children: [
                    if (typetask == 1 || routeur == 1) ...[
                      buildListViewAll(_scrollController),
                      buildBTTAll(_scrollController, backtoTop),
                      buildTextAll(isLastIndex),
                    ] else if (typetask == 2 || routeur == 2) ...[
                      buildListViewToday(_scrollController),
                      buildBTTToday(_scrollController, backtoTop),
                      buildTextToday(isLastIndex),
                    ] else if (typetask == 3 || routeur == 3) ...[
                      buildListViewHomework(_scrollController),
                      buildBTTHomework(_scrollController, backtoTop),
                      buildTextHomework(isLastIndex),
                    ] else if(typetask==4 || routeur == 4)...[
                      buildListViewLesson(_scrollController),
                      buildBTTLesson(_scrollController, backtoTop),
                      buildTextLesson(isLastIndex),
                    ]
                    else ...[
                      buildListViewExam(_scrollController),
                      buildBTTExam(_scrollController, backtoTop),
                      buildTextExam(isLastIndex),
                 
                    ]
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
