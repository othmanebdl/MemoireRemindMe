import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/bigquery/v2.dart';
import 'package:get/get.dart';
import 'package:testgoogle/screens/RemindMe-page2.dart';

class EditLessonHomework extends StatefulWidget {
  EditLessonHomework({
    Key? key,
  }) : super(key: key);

  @override
  State<EditLessonHomework> createState() => _EditLessonHomeworkState();
}

class _EditLessonHomeworkState extends State<EditLessonHomework> {
  var docsid = Get.arguments;
  TimeOfDay time = TimeOfDay.now();
  DateTime date = DateTime.now();

  var title;
  var jour;
  var mois;
  var year;
  var hour;
  var minute;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          RaisedButton(
            onPressed: () {
              Get.offAll(RemindMe2());
            },
            child: Text("ROUTEUR"),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0, bottom: 0),
            child: Text('Add task',
                style: TextStyle(
                    color: Colors.red[300],
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Raleway')),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Color(0xffdee8ec),
              border: Border.all(
                color: Color(0xffdee8ec),
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
                hintText: "${docsid[1]}",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.0),
            child: Text('Select the date and time of your task !',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Raleway')),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      child: Text(
                        '${date.day}/${date.month}/${date.year}',
                        style: TextStyle(
                            fontWeight: FontWeight.w300, fontSize: 25),
                      ),
                      onPressed: () async {
                        DateTime? newDate = await showDatePicker(
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
                        primary: Colors.red[400],
                        elevation: 5,
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      )),
                  ElevatedButton(
                      child: Text(
                        '${time.hour}:${time.minute}',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 25,
                        ),
                      ),
                      onPressed: () async {
                        TimeOfDay? newTime = await showTimePicker(
                            context: context, initialTime: time);

                        if (newTime == null) return;
                        setState(() {
                          time = newTime;
                          hour =date.hour;
                          minute = date.minute;
                          //controller.time = newTime.toString() as TimeOfDay;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                        elevation: 5,
                        padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      )),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(top: 40),
              child: ElevatedButton(
                  onPressed: () async {
                    if (title == null) {
                       Get.snackbar("Entre the title", "title empty",
          colorText: Color.fromARGB(255, 87, 78, 78),
          snackPosition: SnackPosition.BOTTOM);

                    } else {
                      await FirebaseFirestore.instance
                          .collection("Homework_lessonUser")
                          .doc("${docsid[0]}")
                          .update({
                        'homework_lessonuserId': _auth.currentUser?.uid,
                        'hour': time.hour,
                        'jour': date.day,
                        'minute': time.minute,
                        'mois': date.month,
                        'title': title,
                        'year': date.year,
                      }).then((value) {
                        print("updated");
                      });
                    }
                  },
                  child: Text(
                    'Edit task',
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 25,
                        fontFamily: 'Raleway'),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[400],
                    elevation: 5,
                    padding: EdgeInsets.fromLTRB(40, 20, 40, 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ))),
          Text("$docsid"),
        ],
      ),
    );
  }
}
