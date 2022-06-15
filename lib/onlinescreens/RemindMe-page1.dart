// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/onlinescreens/Add_tasks_online.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page2.dart';
import 'package:testgoogle/onlinescreens/SearchTask.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

String dataTaskLessonDevoir = "";

// pour verfier si lautilisateur connecter pa google ou non
final GoogleSignIn googleSignIn = new GoogleSignIn();

class RemindMe1 extends StatefulWidget {
  const RemindMe1({Key key}) : super(key: key);

  @override
  State<RemindMe1> createState() => _RemindMe1State();
}

class _RemindMe1State extends State<RemindMe1> {
  FirebaseAuth _auth = FirebaseAuth.instance;

 // var numbercheck = 0;
  var typtask;
  DateTime date = DateTime.now();
  int _cuurentindexNvaivgationBar = 0;
  @override
  Widget build(BuildContext context) {
    //var username = Get.arguments;
    return Scaffold(
      bottomNavigationBar: ConvexAppBar(
          items: [
            TabItem(
                icon: Icon(Icons.home, color: Color(0xff1f4690)),
                title: "Home"),
            TabItem(
                icon: Icon(Icons.add, color: Color(0xff1f4690)), title: "Add"),
            TabItem(
                icon: Icon(Icons.search, color: Color(0xff1f4690)),
                title: "Search"),
          ],
          initialActiveIndex: _cuurentindexNvaivgationBar,
          onTap: _changeItem,
          backgroundColor: Color(0xfff0f0f0),
          activeColor: Colors.white),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40))),
          backgroundColor: Color(0xfff0f0f0),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              (_auth.currentUser.photoURL == null)
                  ? Container(
                      height: 45,
                      width: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset("images/user.png"),
                      ),
                    )
                  : Container(
                      height: 45,
                      width: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network("${_auth.currentUser.photoURL}"),
                      ),
                    ),
              SizedBox(width: 10),
              (_auth.currentUser.displayName!=null)
                  ? Text(
                      "Hello ${_auth.currentUser.displayName}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                         
                    )
                  : Text("Hello ${Authviewmodel.nameuser}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ))
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon:
                  const Icon(Icons.logout, size: 30, color: Color(0xff274472)),
              onPressed: () async {
                //pour déconecter
                await _auth.signOut();
                await googleSignIn.signOut();
               //
                Get.to(Homepage());
              },
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    DateFormat.yMMMMd().format(DateTime.now()),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.all(15),
                child: Text(
                  "Student Tasks",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff455d7a)),
                ),
              ),
              SizedBox(
                height: 54,
              ),
              Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection("Homework_lessonUser")
                                  .where("homework_lessonuserId",
                                      isEqualTo: "${_auth.currentUser.uid}")
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff1f4690),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      height: 140,
                                      child: FlatButton(
                                        onPressed: () {
                                          typtask = 1;
                                          Get.offAll(RemindMe2(),
                                              arguments: typtask);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                //    Color(0xff455d7a)
                                                Icon(Icons.all_inbox,
                                                    size: 40,
                                                    color: Colors.white),
                                                Container(
                                                    padding:
                                                        EdgeInsets.only(left: 10),
                                                    child: Text('All',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .w400))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ));
                                }
                                return Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff1f4690),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    height: 140,
                                    child: FlatButton(
                                      onPressed: () {
                                        typtask = 1;
                                        Get.offAll(RemindMe2(),
                                            arguments: typtask);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(Icons.all_inbox,
                                                  size: 40, color: Colors.white),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('All',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${snapshot.data.docs.length}",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                        Expanded(
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("Homework_lessonUser")
                                  .where("homework_lessonuserId",
                                      isEqualTo: "${_auth.currentUser.uid}")
                                  .where("jour", isEqualTo: date.day)
                                  .where("mois", isEqualTo: date.month)
                                  .where("year", isEqualTo: date.year)
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff1f4690),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      height: 140,
                                      child: FlatButton(
                                        onPressed: () {
                                          typtask = 2;
      
                                          Get.offAll(RemindMe2(),
                                              arguments: typtask);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.today,
                                                    size: 40,
                                                    color: Colors.white),
                                                Container(
                                                    padding:
                                                        EdgeInsets.only(left: 10),
                                                    child: Text('Today',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .w400))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ));
                                }
                                return Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff1f4690),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    height: 140,
                                    child: FlatButton(
                                      onPressed: () {
                                        typtask = 2;
                                        Get.offAll(RemindMe2(),
                                            arguments: typtask);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(Icons.today,
                                                  size: 40, color: Colors.white),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('Today',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${snapshot.data.docs.length}",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection("Homework_lessonUser")
                                  .where("homework_lessonuserId",
                                      isEqualTo: "${_auth.currentUser.uid}")
                                  .where("typetask", isEqualTo: "Homework")
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff1f4690),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      height: 140,
                                      child: FlatButton(
                                        onPressed: () {
                                          typtask = 3;
      
                                          Get.offAll(RemindMe2(),
                                              arguments: typtask);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.home_work,
                                                    size: 40,
                                                    color: Colors.white),
                                                Container(
                                                    padding:
                                                        EdgeInsets.only(left: 5),
                                                    child: Text('HomeWork',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .w400))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ));
                                }
                                return Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff1f4690),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    height: 140,
                                    child: FlatButton(
                                      onPressed: () {
                                        typtask = 3;
      
                                        Get.offAll(RemindMe2(),
                                            arguments: typtask);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(Icons.home_work,
                                                  size: 40, color: Colors.white),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 5),
                                                  child: Text('HomeWork',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${snapshot.data.docs.length}",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                        Expanded(
                          child: StreamBuilder<Object>(
                              stream: FirebaseFirestore.instance
                                  .collection("Homework_lessonUser")
                                  .where("homework_lessonuserId",
                                      isEqualTo: "${_auth.currentUser.uid}")
                                  .where("typetask", isEqualTo: "Lesson")
                                  .snapshots(),
                              builder: (context, AsyncSnapshot snapshot) {
                                if (snapshot.data == null) {
                                  return Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xff1f4690),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                      height: 140,
                                      child: FlatButton(
                                        onPressed: () {
                                          typtask = 4;
      
                                          Get.offAll(RemindMe2(),
                                              arguments: typtask);
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.book,
                                                    size: 40,
                                                    color: Colors.white),
                                                Container(
                                                    padding:
                                                        EdgeInsets.only(left: 10),
                                                    child: Text('Lessons',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.white,
                                                            fontWeight: FontWeight
                                                                .w400))),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 40,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ));
                                }
                                return Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff1f4690),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    height: 140,
                                    child: FlatButton(
                                      onPressed: () {
                                        typtask = 4;
      
                                        Get.offAll(RemindMe2(),
                                            arguments: typtask);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(Icons.book,
                                                  size: 40, color: Colors.white),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('Lessons',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "${snapshot.data.docs.length}",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ));
                              }),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StreamBuilder<Object>(
                            stream: FirebaseFirestore.instance
                                .collection("Homework_lessonUser")
                                .where("homework_lessonuserId",
                                    isEqualTo: "${_auth.currentUser.uid}")
                                .where("typetask", isEqualTo: "Exam")
                                .snapshots(),
                            builder: (context, AsyncSnapshot snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                    width: 170,
                                    decoration: BoxDecoration(
                                      color: Color(0xff1f4690),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                    height: 140,
                                    child: FlatButton(
                                      onPressed: () {
                                        typtask = 5;
      
                                        Get.offAll(RemindMe2(),
                                            arguments: typtask);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              //    Color(0xff455d7a)
                                              Icon(Icons.app_registration,
                                                  size: 40, color: Colors.white),
                                              Container(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: Text('Exam',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400))),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Text(
                                            "0",
                                            style: TextStyle(
                                                fontSize: 40,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ));
                              }
                              return Container(
                                  width: 170,
                                  decoration: BoxDecoration(
                                    color: Color(0xff1f4690),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                                  height: 140,
                                  child: FlatButton(
                                    onPressed: () {
                                      typtask = 5;
      
                                      Get.offAll(RemindMe2(), arguments: typtask);
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Icon(Icons.app_registration,
                                                size: 40, color: Colors.white),
                                            Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text('Exam',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w400))),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          "${snapshot.data.docs.length}",
                                          style: TextStyle(
                                              fontSize: 40,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ));
                            }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
}
