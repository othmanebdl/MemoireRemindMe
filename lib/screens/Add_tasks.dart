// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_local_variable

import 'package:flutter/material.dart';
import 'package:googleapis/cloudasset/v1.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';

Authviewmodel controller = Authviewmodel();
FirestoreLessondevoir controlelessondevoir = FirestoreLessondevoir();

class AddTask extends StatefulWidget {
  const AddTask({Key? key}) : super(key: key);

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  static final List<String> items = <String>["cour", "devoir"];
  String value = items.first;

  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  DateTime datechoisir = DateTime.now();

  // TimeOfDay timechoisir = TimeOfDay.now();
  @override
  void initState() {
    setState(() {});
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.jour = date.day;
    controller.mois = date.month;
    controller.year = date.year;
    controller.hour = time.hour;
    controller.minute = time.minute;
    return Container(
      color: Color(0xff737373),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
          color: Colors.grey[100],
        ),
        child: Center(
          child: Column(
            children: [
              DropdownButtonFormField(
                  value: value,
                  items: items
                      .map((item) => DropdownMenuItem<String>(
                            child: Text(
                              item,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            value: item,
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      this.value = value.toString();
                    });
                  }),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 0),
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
                    controller.title = value;
                  },
                  textAlign: TextAlign.center,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text('Select the date and time of your task !',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Raleway')),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 35.0),
                child: Container(
                  child: Row(
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
                                firstDate: DateTime(2022),
                                lastDate: DateTime(2023));
                            if (newDate == null) return;
                            setState(() {
                              date = newDate;
                              print(date.day);
                              print(date.month);
                              print(date.year);

                              // controller.dateTime = newDate.toString() as DateTime;
                              controller.jour = date.day;
                              controller.mois = date.month;
                              controller.year = date.year;
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
                            '${time.hour+1}:${time.minute}',
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
                              //controller.time = newTime.toString() as TimeOfDay;
                              controller.hour = time.hour;
                              controller.minute = time.minute;
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
                      onPressed: () {
                        controller.AddCour_Lesson(value);
                      },
                      child: Text(
                        'add',
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
                      )))
            ],
          ),
        ),
      ),
    );
  }
}
