// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable, prefer_final_fields, unused_field, avoid_print

import 'package:date_time/date_time.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/Widgts/input_field.dart';
import 'package:testgoogle/offline/HomepageHc.dart';
import 'package:testgoogle/offline/sql_helper.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/SearchTask.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import '../view-model/auth_view_model.dart';


Authviewmodel controller = Authviewmodel();
FirestoreLessondevoir controlelessondevoir = FirestoreLessondevoir();

class Add_Task_offline extends StatefulWidget {
  const Add_Task_offline({Key key}) : super(key: key);

  @override
  State<Add_Task_offline> createState() => _Add_Task_offlineState();
}

class _Add_Task_offlineState extends State<Add_Task_offline> {
  int i = 0;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  DateTime checkDate = DateTime.now();

  Widget iconlist = Icon(Icons.book);
  var title, description, typetask;
  int jour, mois, year, hour, minute;
  static final List<String> items = <String>["Lesson", "Homework", "Exam"];
  String value = items.first;
  List<String> keytitle = [];
  int _cuurentindexNvaivgationBar = 0;

  @override
  void initState() {
    // TODO: implement initState
    refreshtask();
    /*jour = selectedDate.day;
    mois = selectedDate.month;
    year = selectedDate.year;
    hour = selectedTime.hour;
    minute = selectedTime.minute;*/

    super.initState();
  }

  Future<void> tambTask() async {
    await SQLHelper.insert(
        title, description, typetask, jour, mois, year, hour, minute);
    refreshtask();
  }

  List<Map<String, dynamic>> listtask = [];
  void refreshtask() async {
    final data = await SQLHelper.getDatatask();
    setState(() {
      listtask = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    //jour = selectedDate.day;
    typetask = value;
    //mois = selectedDate.month;
    //year = selectedDate.year;
    //hour = selectedTime.hour;
    //minute = selectedTime.minute;
    //controller.keytitle.clear();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(

                /*appBar: AppBar(
                 shape: RoundedRectangleBorder(
                 
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30))),
                  backgroundColor:Color(0xfff0f0f0) ,
                  leading: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 25,
                        color:Color(0xff274472) ,
                      ),
                      onPressed: () {
                        Get.to(RemindMe1());
                      })),*/
                body: Container(
                    padding: EdgeInsets.only(top: 45, left: 20, right: 20),
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
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: Color(0xff3a5ba0),
                                  ))
                            ],
                          ),
                          SizedBox(height: 12),
                          Center(
                            child: Container(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                  icon: iconlist,
                                  /*value == "Lesson"
                                    ? Icon(Icons.book)
                                    : Icon(Icons.home_work),*/
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
                                                  fontWeight: FontWeight.normal,
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
                                        iconlist = Icon(Icons.app_registration);
                                      }
                                      this.value = value.toString();
                                      typetask = value;
                                      print(typetask);
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
                                title = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: "Title"),
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
                                description = value;
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Description"),
                            ),
                          ),
                          SizedBox(height: 40),
                          //InputField(title: "description", hint: "the descrition"),
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

                                setState(() {
                                  jour = pickerDate.day;
                                  mois = pickerDate.month;
                                  year = pickerDate.year;
                                });
                              },
                            ),
                          ),
                          InputField(
                            title:
                                "Time : ${selectedTime.hour + 1}:${selectedTime.minute}",
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
                                  hour = pickerTime.hour;
                                  minute = pickerTime.minute;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 60),
                          Container(
                              // margin: EdgeInsets.only(top: 20),
                              child: Center(
                            child: ElevatedButton(
                                onPressed: () async {
                                  print(checkDate);
                                  if (title == "" || title == null) {
                                    snackBarAll("Title");
                                  } else if (description == "" ||
                                      description == null) {
                                    snackBarAll("Description");
                                  } else if (jour == null ||
                                      mois == null ||
                                      year == null) {
                                    snackBarAll("Date");
                                  } else if (hour == null || minute == null) {
                                    snackBarAll("Time");
                                  } else if (hour < TimeOfDay.now().hour ||
                                      minute < TimeOfDay.now().minute) {
                                    snackBarWrongTime();
                                  } else {
                                    await tambTask();
                                    Get.to(HomepageHc());
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
                                  primary: Color(0xff274472),
                                  elevation: 5,
                                  padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                )),
                          )),
                          SizedBox(height: 30),
                        ],
                      ),
                    ))),
          );
        }));
  }

  void snackBarAll(String type) {
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
}
