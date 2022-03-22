// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/artifactregistry/v1.dart';
//import 'package:memoire/Widgts/LIstView.dart';
import 'package:testgoogle/Widgts/LIstView.dart';
//import 'package:memoire/screens/Add_tasks.dart';
import 'package:testgoogle/screens/Add_tasks.dart';
//import 'package:memoire/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/Controlle-scrollviewAll.dart';
import 'package:testgoogle/screens/controlle_scroll_viewToday.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/screens/controlle_scroll_viewHomework.dart';
import 'package:testgoogle/screens/controlle_scroll_viewlesson.dart';

CollectionReference userCollectionRef =
    FirebaseFirestore.instance.collection("Homework_lessonUser");

class RemindMe2 extends StatefulWidget {
  const RemindMe2({Key? key}) : super(key: key);

  @override
  State<RemindMe2> createState() => _RemindMe2State();
}

class _RemindMe2State extends State<RemindMe2> {
  var typetask = Get.arguments;
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: 95,
        height: 95,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 8),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                context: context, builder: (context) => AddTask());
          },
          backgroundColor: Colors.red,
          child: Icon(Icons.add, color: Colors.white, size: 45),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 80),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 60.0),
                  child: Row(
                    children: [
                      Icon(Icons.playlist_add_check,
                          color: Colors.red, size: 40),
                      SizedBox(width: 10),
                      Text('RemindMe',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway')),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0, top: 55),
                  child: IconButton(
                    icon: const Icon(Icons.close, size: 40, color: Colors.red),
                    onPressed: () {
                      // Navigator.of(context).pushReplacement(
                      //  MaterialPageRoute(builder: (_) => RemindMe1()));
                      Get.offAll(RemindMe1() /*arguments: length*/);
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 40,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.red[200],
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Stack(
                  children: [
                    if(typetask ==1)...[
                      buildListViewAll(_scrollController),
                      buildBTTAll(_scrollController, backtoTop),
                      buildTextAll(isLastIndex),
      
    ]else if(typetask==2)...[
      buildListViewToday(_scrollController),
      buildBTTToday(_scrollController, backtoTop),
      buildTextToday(isLastIndex),


      
    ]
    else if(typetask==3)...[
      buildListViewHomework(_scrollController),
      buildBTTHomework(_scrollController, backtoTop),
      buildTextHomework(isLastIndex),


      
    ]
    else ...[
       buildListViewLesson(_scrollController),
      buildBTTLesson(_scrollController, backtoTop),
      buildTextLesson(isLastIndex),

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
 