import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testgoogle/screens/Add_tasks.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/screens/RemindMe-page2.dart';

class Snapchot extends StatefulWidget {
  Snapchot({Key? key}) : super(key: key);

  @override
  State<Snapchot> createState() => _SnapchotState();
}

class _SnapchotState extends State<Snapchot> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Snapchot"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Homework_lessonUser")
            .where("homework_lessonuserId",
                isEqualTo: "pAVzILrf61bgtLYwT3wCukuzmPH3")
            .snapshots(),
        builder: (context, AsyncSnapshot snapchot) {
          if (!snapchot.hasData) {
            return Text("loading data ");
          }
          return ListView.builder(
              itemCount: snapchot.data.docs.length,
              itemBuilder: (context, i) {
                return Container(
                  width: 20,
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 20,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Center(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, top: 20),
                            child: Column(
                              children: [
                                Text(
                                  "${snapchot.data.docs[i].data()['title']}",
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.red),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Date :  ${snapchot.data.docs[i].data()['jour']}/${snapchot.data.docs[i].data()['mois']}/ ${snapchot.data.docs[i].data()['year']}",
                                  style: TextStyle(fontSize: 17),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Time :  ${snapchot.data.docs[i].data()['hour']}: ${snapchot.data.docs[i].data()['minute']}",
                                  style: TextStyle(fontSize: 17),
                                ),
                                RaisedButton(
                                  onPressed: () {
                                    Get.offAll(RemindMe1());
                                  },
                                  child: Text("routeur"),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ); // Column(
                // children: [
                // Text("${snapchot.data.docs[i].data()['title']}"),
                // FlatButton(
                // onPressed: () {
                //  Get.offAll(RemindMe1());
                //  },
                //child: Text("roteur"))
                // ]//,
                // );
              });
        },
      ),
    );
  }
}
