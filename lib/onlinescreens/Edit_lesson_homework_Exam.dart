// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page1.dart';


class EditLessonHomework extends StatefulWidget {
  EditLessonHomework({
    Key key,
  }) : super(key: key);

  @override
  State<EditLessonHomework> createState() => _EditLessonHomeworkState();
}

class _EditLessonHomeworkState extends State<EditLessonHomework> {
  //le id de document qui contient les information de la tache
  var docsid = Get.arguments;
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  var title;
  var description;
  var jour;
  var mois;
  var year;
  var hour;
  var minute;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              body: SingleChildScrollView(
                child: Container(
                  constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height,
                      maxWidth: MediaQuery.of(context).size.width),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.white, Colors.white],
                        begin: Alignment.topLeft,
                        end: Alignment.centerRight),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 36, horizontal: 24),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                      onTap: () {
                                        Get.to(RemindMe1());
                                      },
                                      child: Icon(
                                        Icons.arrow_back,
                                        color: Color(0xff274472),
                                        size: 30,
                                      )),
                                ),
                                Text(
                                  "Edit Task",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 46),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 5,
                        child: Container(
                          margin: EdgeInsets.only(top: 28),
                          decoration: BoxDecoration(
                            color: Color(0xff274472),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                          ),
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(40, 10, 40, 0),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    title = value;
                                  },
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter the new title",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 35,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                padding: EdgeInsets.symmetric(
                                    vertical: 2, horizontal: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.white,
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    description = value;
                                  },
                                  textAlign: TextAlign.center,
                                  cursorColor: Colors.grey,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter the new Description",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Column(
                                children: [
                                  ElevatedButton(
                                      child: Text(
                                        '${date.day}/${date.month}/${date.year}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18),
                                      ),
                                      onPressed: () async {
                                        DateTime newDate = await showDatePicker(
                                            context: context,
                                            initialDate: date,
                                            firstDate: date,
                                            lastDate: DateTime(2023));
                                        if (newDate == null) return;
                                        setState(() {
                                          date = newDate;
                                          jour = date.day;
                                          mois = date.month;
                                          year = date.year;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        elevation: 5,
                                        padding:
                                            EdgeInsets.fromLTRB(60, 20, 60, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      child: Text(
                                        '${time.hour}:${time.minute}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            color: Colors.black),
                                      ),
                                      onPressed: () async {
                                        TimeOfDay newTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: time);

                                        if (newTime == null) return;
                                        setState(() {
                                          time = newTime;
                                          hour = time.hour;
                                          print(hour);
                                          minute = time.minute;
                                          print(minute);
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        elevation: 5,
                                        padding:
                                            EdgeInsets.fromLTRB(90, 20, 90, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      )),
                                  SizedBox(
                                    height: 50,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        if (title == "" || title == null) {
                                          snackBar("Title");
                                        } else if (description == "" ||
                                            description == null) {
                                          snackBar("Description");
                                        } else if (jour == null ||
                                            mois == null ||
                                            year == null) {
                                          snackBar("Date");
                                        } else if (hour == null ||
                                            minute == null) {
                                          snackBar("Time");
                                        } else if (hour <
                                                TimeOfDay.now().hour ||
                                            minute < TimeOfDay.now().minute) {
                                          snackBarWrongTime();
                                        } else {
                                          await FirebaseFirestore.instance
                                              .collection("Homework_lessonUser")
                                              .doc("${docsid[0]}")
                                              .update({
                                            'homework_lessonuserId':
                                                _auth.currentUser?.uid,
                                            'description': description,
                                            'hour': time.hour,
                                            'jour': date.day,
                                            'minute': time.minute,
                                            'mois': date.month,
                                            'title': title,
                                            'year': date.year,
                                          }).then((value) {
                                            Get.offAll(RemindMe1());
                                          });
                                        }
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 18,
                                            fontFamily: 'Raleway',
                                            color: Colors.black),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        elevation: 5,
                                        padding:
                                            EdgeInsets.fromLTRB(76, 20, 76, 20),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  void snackBar(String type) {
    Get.snackbar("Errore Add Task", "$type Empty",
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
  }
}

void snackBarWrongTime() {
  Get.snackbar("Errore Add Task", "Please select Time after Time now",
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
}
