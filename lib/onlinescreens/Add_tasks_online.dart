// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, prefer_final_fields, unused_field, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/Widgts/input_field.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page1.dart';
import 'package:testgoogle/onlinescreens/SearchTask.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework_Exam.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../view-model/auth_view_model.dart';


Authviewmodel controller = Authviewmodel();
FirestoreLessondevoir controlelessondevoir = FirestoreLessondevoir();

class AddTask_online extends StatefulWidget {
  const AddTask_online({Key key}) : super(key: key);

  @override
  State<AddTask_online> createState() => _AddTask_onlineState();
}

class _AddTask_onlineState extends State<AddTask_online> {
  int i = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime checkDate = DateTime.now();

  Widget iconlist = Icon(Icons.book);
  var title, description;
  static final List<String> items = <String>["Lesson", "Homework", "Exam"];
  String value = items
      .first; /* on initialiser value par le premier valeur de list items qui
                                   est Lesson */
  List<String> keytitle = [];//list contient tous les mot clé de titre tahce
  int _cuurentindexNvaivgationBar = 0;
  int jour, mois, year, hour, minute;
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
    controller.jour = selectedDate.day;
    controller.mois = selectedDate.month;
    controller.year = selectedDate.year;
    controller.hour = selectedTime.hour;
    controller.minute = selectedTime.minute;

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return GestureDetector(
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
                      initialActiveIndex: 1,
                      onTap: _changeItem,
                      backgroundColor: Color(0xfff0f0f0),
                      activeColor: Colors.white),
                  body: Container(
                      padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add task",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            Center(
                              child: Container(
                                width: double.infinity,
                                child: DropdownButtonFormField(
                                    icon: iconlist,
                                    decoration: InputDecoration(
                                      fillColor: Colors.grey,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    isExpanded: true,
                                    value: value,
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
                                              child: Text(
                                                item,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 17,
                                                    color: Colors.grey),
                                              ),
                                              value: item,
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        if (value == "Homework") {
                                          iconlist = Icon(Icons.home_work);
                                        } else if (value == "Lesson") {
                                          iconlist = Icon(Icons.book);
                                        } else {
                                          iconlist =
                                              Icon(Icons.app_registration);
                                        }
                                        this.value = value.toString();
                                      });
                                    }),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Title",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.only(left: 16),
                              height: 52,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextField(
                                onChanged: (value) {
                                  setState(() {
                                    if (value == "") {
                                      controller.keytitle.clear();
                                    }
                                    if (i == 0) {
                                      controller.keytitle.clear();
                                    }
                                    controller.keytitle.add(value);

                                    i++;
                                  });
                                  /* affecter la valeur entrer par l'utilisateur dans variable
                                  title
                                  */
                                  controller.title = value;
                                  title = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Title"),
                              ),
                            ),
                            SizedBox(height: 12),
                            Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8),
                              padding: EdgeInsets.only(left: 16),
                              height: 50,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(12)),
                              child: TextField(
                                onChanged: (value) {
                                  /* affecter la valeur entrer par l'utilisateur dans variable
                                  description
                                  */
                                  controller.desciption = value;
                                  description = value;
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Description"),
                              ),
                            ),
                            SizedBox(height: 40),
                            InputField(
                              title:
                                  "Date : ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}",
                              hint: "Select the date",
                              widget: IconButton(
                                icon: const Icon(
                                  Icons.calendar_today_outlined,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                onPressed: () async {
                                  DateTime pickerDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime(2023));
                                  if (pickerDate == null) return;

                                  checkDate = pickerDate as DateTime;

                                  setState(() {
                                    selectedDate = pickerDate;
                                    jour = pickerDate.day;
                                    mois = pickerDate.month;
                                    year = pickerDate.year;
                                    controller.jour = selectedDate.day;
                                    controller.mois = selectedDate.month;
                                    controller.year = selectedDate.year;
                                  });
                                },
                              ),
                            ),
                            InputField(
                              title:
                                  "Time : ${selectedTime.hour}:${selectedTime.minute}",
                              hint: "Select the time",
                              widget: IconButton(
                                icon: const Icon(
                                  Icons.access_time,
                                  size: 25,
                                  color: Colors.grey,
                                ),
                                onPressed: () async {
                                  TimeOfDay pickerTime = await showTimePicker(
                                      context: context,
                                      initialTime: selectedTime);

                                  if (pickerTime == null) return;
                                  setState(() {
                                    selectedTime = pickerTime;
                                    hour = pickerTime.hour;
                                    minute = pickerTime.minute;
                                    controller.hour = pickerTime.hour;
                                    controller.minute = pickerTime.minute;
                                  });
                                },
                              ),
                            ),
                            SizedBox(height: 40),
                            Container(
                                child: Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    if (title == "" || title == null) {
                                      snackBar("Title");
                                    } else if (description == "" ||
                                        description == null) {
                                      snackBar("Description");
                                    } else if (jour == null ||
                                        mois == null ||
                                        year == null) {
                                      snackBar("Date");
                                    } else if (hour == null || minute == null) {
                                      snackBar("Time");
                                    }
                                    else if (hour < TimeOfDay.now().hour ||
                                      minute < TimeOfDay.now().minute) {
                                    snackBarWrongTime();
                                  }
                                    else {
                                      //on appele la methode qui ajouter la tache dans la base de donnés
                                      controller.AddLesson_HomeWork_Exam(value);
                                      Get.to(RemindMe1());
                                    }
                                  },
                                  child: Text(
                                    'add',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w300,
                                        fontSize: 20,
                                        fontFamily: 'Raleway'),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Color(0xff1f4690),
                                    elevation: 5,
                                    padding:
                                        EdgeInsets.fromLTRB(80, 20, 80, 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                  )),
                            )),
                            SizedBox(height: 30),
                          ],
                        ),
                      ))));
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
