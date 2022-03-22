// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/screens/RemindMe-page2.dart';

//import 'package:memoire/screens/profil.dart';
import 'package:testgoogle/screens/profil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:get/get.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = new GoogleSignIn();
var username = Get.arguments;

class RemindMe1 extends StatefulWidget {
  const RemindMe1({Key? key}) : super(key: key);

  @override
  State<RemindMe1> createState() => _RemindMe1State();
}

class _RemindMe1State extends State<RemindMe1> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  var typtask;
  DateTime date = DateTime.now();
  String dataTaskLessonDevoir = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: Colors.red[400],
          automaticallyImplyLeading: false,
          title: Text(
            'RemindMe',
            style: TextStyle(
              fontSize: 25,
              fontFamily: 'Raleway',
              color: Colors.white,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout, size: 25),
              onPressed: () async {
                await _auth.signOut();
                await googleSignIn.signOut();
                //Navigator.of(context).push(
                //MaterialPageRoute(builder: (context) => Memoirereminder()));
                Get.offAll(Homepage());
              },
            ),
          ]),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 60),
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xffdee8ec),
              // border: Border.all(color: Color(0xff4B5563),),
            ),
            child: TextField(
              onTap: () {
                //_buttomsheetlogin(context);
              },
              onChanged: (val) {
                dataTaskLessonDevoir = val;
              },
              cursorColor: Colors.grey,
              decoration: InputDecoration(
                icon: Icon(
                  Icons.search,
                  color: Colors.red,
                ),
                hintText: "Search",
                border: InputBorder.none,
              ),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection("Homework_lessonUser")
                        .where("homework_lessonuserId",
                            isEqualTo: "${_auth.currentUser!.uid}")
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null)
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            height: 140,
                            child: FlatButton(
                              onPressed: () {
                                typtask = 1;
                                //  Navigator.of(context).pushReplacement(
                                //    MaterialPageRoute(builder: (_) => RemindMe2()));
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
                                      Icon(Icons.all_inbox,
                                          size: 40, color: Color(0xff455d7a)),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text('All',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff455d7a),
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
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          height: 140,
                          child: FlatButton(
                            onPressed: () {
                              typtask = 1;
                              //  Navigator.of(context).pushReplacement(
                              //    MaterialPageRoute(builder: (_) => RemindMe2()));
                              Get.offAll(RemindMe2(), arguments: typtask);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.all_inbox,
                                        size: 40, color: Color(0xff455d7a)),
                                    Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('All',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff455d7a),
                                                fontWeight: FontWeight.w400))),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${snapshot.data!.docs!.length}",
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
                            isEqualTo: "${_auth.currentUser!.uid}")
                        .where("jour", isEqualTo: date.day)
                        .where("mois", isEqualTo: date.month)
                        .where("year", isEqualTo: date.year)
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null)
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            height: 140,
                            child: FlatButton(
                              onPressed: () {
                                typtask = 2;
                                //  Navigator.of(context).pushReplacement(
                                //    MaterialPageRoute(builder: (_) => RemindMe2()));
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
                                      Icon(Icons.today,
                                          size: 40, color: Color(0xff455d7a)),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text('Today',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff455d7a),
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
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          height: 140,
                          child: FlatButton(
                            onPressed: () {
                              typtask = 2;
                              //  Navigator.of(context).pushReplacement(
                              //    MaterialPageRoute(builder: (_) => RemindMe2()));
                              Get.offAll(RemindMe2(), arguments: typtask);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.today,
                                        size: 40, color: Color(0xff455d7a)),
                                    Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Today',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff455d7a),
                                                fontWeight: FontWeight.w400))),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${snapshot.data!.docs!.length}",
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
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: StreamBuilder<Object>(
                    stream: FirebaseFirestore.instance
                        .collection("Homework_lessonUser")
                        .where("homework_lessonuserId",
                            isEqualTo: "${_auth.currentUser!.uid}")
                        .where("typetask", isEqualTo: "devoir")
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null)
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            height: 140,
                            child: FlatButton(
                              onPressed: () {
                                typtask = 3;
                                //  Navigator.of(context).pushReplacement(
                                //    MaterialPageRoute(builder: (_) => RemindMe2()));
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
                                      Icon(Icons.home_work,
                                          size: 40, color: Color(0xff455d7a)),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text('HomeWork',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff455d7a),
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
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          height: 140,
                          child: FlatButton(
                            onPressed: () {
                              typtask = 3;
                              //  Navigator.of(context).pushReplacement(
                              //    MaterialPageRoute(builder: (_) => RemindMe2()));
                              Get.offAll(RemindMe2(), arguments: typtask);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.home_work,
                                        size: 40, color: Color(0xff455d7a)),
                                    Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('HomeWork',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff455d7a),
                                                fontWeight: FontWeight.w400))),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${snapshot.data!.docs!.length}",
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
                            isEqualTo: "${_auth.currentUser!.uid}")
                        .where("typetask", isEqualTo: "cour")
                        .snapshots(),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.data == null)
                        return Container(
                            decoration: BoxDecoration(
                              color: Colors.red[300],
                              borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                            height: 140,
                            child: FlatButton(
                              onPressed: () {
                                typtask = 4;
                                //  Navigator.of(context).pushReplacement(
                                //    MaterialPageRoute(builder: (_) => RemindMe2()));
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
                                      Icon(Icons.book,
                                          size: 40, color: Color(0xff455d7a)),
                                      Container(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Text('Lessons',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xff455d7a),
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
                      return Container(
                          decoration: BoxDecoration(
                            color: Colors.red[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          height: 140,
                          child: FlatButton(
                            onPressed: () {
                              typtask = 4;
                              //  Navigator.of(context).pushReplacement(
                              //    MaterialPageRoute(builder: (_) => RemindMe2()));
                              Get.offAll(RemindMe2(), arguments: typtask);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Icon(Icons.book,
                                        size: 40, color: Color(0xff455d7a)),
                                    Container(
                                        padding: EdgeInsets.only(left: 10),
                                        child: Text('Lessons',
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xff455d7a),
                                                fontWeight: FontWeight.w400))),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "${snapshot.data!.docs!.length}",
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
        ],
      ),
    );
  }

/*  void _buttomsheetlogin(context) {
    showModalBottomSheet(
        enableDrag: true,
        context: context,
        builder: (context) {
          return StreamBuilder(
              stream:
                  (dataTaskLessonDevoir != "" && dataTaskLessonDevoir != null)
                      ? FirebaseFirestore.instance
                          .collection("Homework_lessonUser")
                          .where("homework_lessonuserId",
                              isEqualTo: "${_auth.currentUser!.uid}")
                          .where("title", arrayContains: dataTaskLessonDevoir)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection("Homework_lessonUser")
                          .where("homework_lessonuserId",
                              isEqualTo: "${_auth.currentUser!.uid}")
                          .snapshots(),
              builder: (contexte, AsyncSnapshot snapchot) {
                if (!snapchot.hasData)
                  return Center(child: CircularProgressIndicator());

                return ListView.builder(
                    itemCount: snapchot.data!.docs.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(top: 8),
                        child: Column(children: [
                          Text("${snapchot.data.docs[index].data()['title']}")
                        ]),
                      );
                      
                    });
              });
        });
  }*/
}
