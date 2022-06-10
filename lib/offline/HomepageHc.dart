import 'dart:io';

import 'package:flutter/material.dart';

import 'package:testgoogle/Widgts/input_field.dart';
import 'package:testgoogle/offline/Add_tasks_offline.dart';
import 'package:testgoogle/offline/AlanAssistant.dart';
import 'package:testgoogle/offline/DetailTaskHc.dart';
import 'package:testgoogle/offline/RechercheTask.dart';
//import 'package:testgoogle/hors-connexion/showAlltask.dart';
import 'package:testgoogle/offline/sql_helper.dart';
import 'package:get/get.dart';
import 'package:testgoogle/main.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class HomepageHc extends StatefulWidget {
  HomepageHc({Key key}) : super(key: key);

  @override
  State<HomepageHc> createState() => _HomepageHcState();
}

class _HomepageHcState extends State<HomepageHc> with WidgetsBindingObserver {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  static final List<String> items = <String>["Lesson", "Homework", "Exam"];
  String value = items.first;
  var title, description, typetask, titlenotification, descriptionotification;
  int jour,
      mois,
      year,
      hour,
      minute,
      journotification,
      moisnotification,
      yearnotification,
      hournotification,
      minutenotification;
  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime selectedDate = DateTime.now();
  var number;
  @override
  void initState() {
    // TODO: implement initState
    refreshtask();

    super.initState();
    WidgetsBinding.instance.addObserver(this);
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    var androidInitialize = new AndroidInitializationSettings('todolist');
    var iOsInitialize = new IOSInitializationSettings();
    var iNitializonSetting = new InitializationSettings(
        android: androidInitialize, iOS: iOsInitialize);

    flutterLocalNotificationsPlugin.initialize(iNitializonSetting,
        onSelectNotification: selectNotifcation);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;
    final background = state == AppLifecycleState.paused;
    if (background) {
      //_showNotification("title1", "description1");

      //listview();
    }
  }

  Future selectNotifcation(String payload) async {
    print(titlenotification);
    print(descriptionotification);
    print("${journotification}");
    print("${moisnotification}");
    print("${yearnotification}");
    print("${hournotification}");
    print("${minutenotification}");
    Get.to(DetailTaskHC(), arguments: [
      titlenotification,
      descriptionotification,
      journotification,
      moisnotification,
      yearnotification,
      hournotification,
      minutenotification
    ]);
  }

  Future _showNotification(String title1, String description1) async {
    var androidDetails = new AndroidNotificationDetails(
        "channelId", "channelName",
        importance: Importance.max);
    var iOsDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOsDetails);
    /*var scheduledTime = DateTime.now().add(Duration(minutes: 1));
    await flutterLocalNotificationsPlugin.schedule(1, "you crated a task",
        "fdgfd", scheduledTime, generalNotificationDetails);*/

    await flutterLocalNotificationsPlugin.show(
        0, title1, description1, generalNotificationDetails,
        payload: "send message");
    /* await flutterLocalNotificationsPlugin.zonedSchedule(1, "dfsds", "task",
        tz.TZDateTime.from(scheduledTime, tz.local), generalNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);*/
    /*await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);*/
  }

  Future _showScheduledNotification(
      int id1, String title1, String description1) async {
    var androidDetails = new AndroidNotificationDetails(
      "channelId",
      "channelName",
      importance: Importance.max,
      priority: Priority.high,
      fullScreenIntent: true,
      playSound: true,
      color: Color(0xff334973),
      enableLights: true,
      enableVibration: true,
      styleInformation:
          MediaStyleInformation(htmlFormatContent: true, htmlFormatTitle: true),
    );
    var iOsDetails = new IOSNotificationDetails();
    var generalNotificationDetails =
        new NotificationDetails(android: androidDetails, iOS: iOsDetails);
    var scheduledTime = DateTime.now().add(Duration(seconds: 0));
    await flutterLocalNotificationsPlugin.schedule(
        id1, title1, description1, scheduledTime, generalNotificationDetails,
        androidAllowWhileIdle: true);

    /* await flutterLocalNotificationsPlugin.zonedSchedule(1, "dfsds", "task",
        tz.TZDateTime.from(scheduledTime, tz.local), generalNotificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);*/
    /*await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);*/
  }

  static List<Map<String, dynamic>> listtask = [];

  void refreshtask() async {
    final data = await SQLHelper.getDatatask();
    setState(() {
      listtask = data;
    });
  }

  Widget listview() {
    return ListView.builder(
        itemCount: listtask.length,
        itemBuilder: ((context, index) {
          if (listtask[index]["hour"] == TimeOfDay.now().hour &&
              listtask[index]["minute"] == TimeOfDay.now().minute) {
            titlenotification = listtask[index]["title"];
            descriptionotification = listtask[index]["description"];
            journotification = listtask[index]['jour'];
            moisnotification = listtask[index]['mois'];
            yearnotification = listtask[index]["year"];
            hournotification = listtask[index]["hour"];
            minutenotification = listtask[index]["minute"];
            /*  _showNotification(listtask[index]["title"],
                                      listtask[index]["description"]);*/
            _showScheduledNotification(listtask[index]["id"],
                listtask[index]["title"], listtask[index]["description"]);
            sleep(Duration(seconds: 60));
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    typetask = value;
    number = listtask.length;
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
          length: 5,
          child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey[300],
                elevation: 10,
                shadowColor: Color(0xffDFE7F4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
                title: IconButton(
                  icon: Icon(Icons.search, color: Color(0xff3a5ba0)),
                  onPressed: () {
                    Get.to(RechercheTask());
                  },
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.logout_outlined,
                      color: Color(0xff3a5ba0),
                    ),
                    onPressed: () {
                      //  _showNotification();
                      Get.to(Homepage());
                      //  _showScheduledNotification();
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                backgroundColor: Color(0xff1f4690),
                onPressed: () {
                  //modalForm(null);
                  Get.to(Add_Task_offline());
                  //Get.to(Alan());
                },
                child: Icon(Icons.add),
              ),
              body: Padding(
                padding: EdgeInsets.only(top: 25, left: 8, right: 8),
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(25)),
                      child: TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.black,
                          indicator: BoxDecoration(
                            color: Color(0xff1f4690),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          tabs: [
                            Tab(text: "All"),
                            Tab(text: "Lesson"),
                            Tab(
                              text: "HomeWork",
                              iconMargin: EdgeInsets.only(right: 10),
                            ),
                            Tab(text: "Today"),
                            Tab(text: "Exam"),
                          ]),
                    ),
                    Expanded(
                        child: TabBarView(
                      children: [
                        ListView.builder(
                            itemCount: listtask.length,
                            itemBuilder: ((context, index) {
                              if (listtask[index]["hour"] ==
                                      TimeOfDay.now().hour &&
                                  listtask[index]["minute"] ==
                                      TimeOfDay.now().minute) {
                                titlenotification = listtask[index]["title"];
                                descriptionotification =
                                    listtask[index]["description"];
                                journotification = listtask[index]['jour'];
                                moisnotification = listtask[index]['mois'];
                                yearnotification = listtask[index]["year"];
                                hournotification = listtask[index]["hour"];
                                minutenotification = listtask[index]["minute"];
                                /*  _showNotification(listtask[index]["title"],
                                      listtask[index]["description"]);*/
                                if (DateTime.now().second == 0) {
                                  _showScheduledNotification(
                                      listtask[index]["id"],
                                      listtask[index]["title"],
                                      listtask[index]["description"]);
                                }
                                //sleep(Duration(seconds: 60));
                              }
                              /* if (listtask[index]['minute'] == DateTime.now().minute) {
                    _showNotification(
                        listtask[index]['title'], listtask[index]['description']);
                  }*/
                              refreshtask();
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: Container(
                                  margin: EdgeInsets.only(top: 20),
                                  width: 20,
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.to(
                                          DetailTaskHC(),
                                          arguments: [
                                            listtask[index]['title'],
                                            listtask[index]['description'],
                                            listtask[index]['jour'],
                                            listtask[index]['mois'],
                                            listtask[index]['year'],
                                            listtask[index]['hour'],
                                            listtask[index]['minute'],
                                            listtask[index]['description']
                                          ],
                                        );
                                      },
                                      child: Container(
                                        width: 20,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: Color(0xff1f4690)),
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    listtask[index]['title'],
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Date : ${listtask[index]['jour']}/${listtask[index]['mois']}/${listtask[index]['year']} ",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                  Text(
                                                    "Time : ${listtask[index]['hour']}:${listtask[index]['minute']} ",
                                                    style: TextStyle(
                                                        fontSize: 17,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                  icon: Icon(Icons.update),
                                                  color: Colors.white,
                                                  iconSize: 40,
                                                  onPressed: () {
                                                    /* modalForm(
                                                        listtask[index]['id']);*/
                                                    Get.to(Alan());
                                                  }),
                                              IconButton(
                                                  icon: Icon(Icons.delete),
                                                  color: Colors.white,
                                                  iconSize: 40,
                                                  onPressed: () async {
                                                    await deleteData(
                                                        listtask[index]['id']);
                                                  }),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            })),
                        ListView.builder(
                            itemCount: listtask.length,
                            itemBuilder: ((context, index) {
                              if (listtask[index]["hour"] ==
                                      TimeOfDay.now().hour &&
                                  listtask[index]["minute"] ==
                                      TimeOfDay.now().minute) {
                                titlenotification = listtask[index]["title"];
                                descriptionotification =
                                    listtask[index]["description"];
                                journotification = listtask[index]['jour'];
                                moisnotification = listtask[index]['mois'];
                                yearnotification = listtask[index]["year"];
                                hournotification = listtask[index]["hour"];
                                minutenotification = listtask[index]["minute"];
                                /*  _showNotification(listtask[index]["title"],
                                      listtask[index]["description"]);*/
                                if (DateTime.now().second == 0) {
                                  _showScheduledNotification(
                                      listtask[index]["id"],
                                      listtask[index]["title"],
                                      listtask[index]["description"]);
                                }
                              }
                              /* if (listtask[index]['minute'] == DateTime.now().minute) {
                    _showNotification(
                        listtask[index]['title'], listtask[index]['description']);*/
                              refreshtask();
                              if (listtask[index]["typetask"] == "Lesson") {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 20,
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            DetailTaskHC(),
                                            arguments: [
                                              listtask[index]['title'],
                                              listtask[index]['description'],
                                              listtask[index]['jour'],
                                              listtask[index]['mois'],
                                              listtask[index]['year'],
                                              listtask[index]['hour'],
                                              listtask[index]['minute'],
                                              listtask[index]['description']
                                            ],
                                          );
                                        },
                                        child: Container(
                                          width: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xff1f4690)),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      listtask[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Date : ${listtask[index]['jour']}/${listtask[index]['mois']}/${listtask[index]['year']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Time : ${listtask[index]['hour']}:${listtask[index]['minute']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    icon: Icon(Icons.update),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () {
                                                      modalForm(listtask[index]
                                                          ['id']);
                                                    }),
                                                IconButton(
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () async {
                                                      await deleteData(
                                                          listtask[index]
                                                              ['id']);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })),
                        ListView.builder(
                            itemCount: listtask.length,
                            itemBuilder: ((context, index) {
                              if (listtask[index]["hour"] ==
                                      TimeOfDay.now().hour &&
                                  listtask[index]["minute"] ==
                                      TimeOfDay.now().minute) {
                                titlenotification = listtask[index]["title"];
                                descriptionotification =
                                    listtask[index]["description"];
                                journotification = listtask[index]['jour'];
                                moisnotification = listtask[index]['mois'];
                                yearnotification = listtask[index]["year"];
                                hournotification = listtask[index]["hour"];
                                minutenotification = listtask[index]["minute"];
                                /*  _showNotification(listtask[index]["title"],
                                      listtask[index]["description"]);*/
                                if (DateTime.now().second == 0) {
                                  _showScheduledNotification(
                                      listtask[index]["id"],
                                      listtask[index]["title"],
                                      listtask[index]["description"]);
                                }
                              }
                              refreshtask();
                              if (listtask[index]["typetask"] == "Homework") {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 20,
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            DetailTaskHC(),
                                            arguments: [
                                              listtask[index]['title'],
                                              listtask[index]['description'],
                                              listtask[index]['jour'],
                                              listtask[index]['mois'],
                                              listtask[index]['year'],
                                              listtask[index]['hour'],
                                              listtask[index]['minute'],
                                              listtask[index]['description']
                                            ],
                                          );
                                        },
                                        child: Container(
                                          width: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xff1f4690)),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      listtask[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Date : ${listtask[index]['jour']}/${listtask[index]['mois']}/${listtask[index]['year']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Time : ${listtask[index]['hour']}:${listtask[index]['minute']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    icon: Icon(Icons.update),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () {
                                                      modalForm(listtask[index]
                                                          ['id']);
                                                    }),
                                                IconButton(
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () async {
                                                      await deleteData(
                                                          listtask[index]
                                                              ['id']);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })),
                        ListView.builder(
                            itemCount: listtask.length,
                            itemBuilder: ((context, index) {
                              if (listtask[index]["hour"] ==
                                      TimeOfDay.now().hour &&
                                  listtask[index]["minute"] ==
                                      TimeOfDay.now().minute) {
                                titlenotification = listtask[index]["title"];
                                descriptionotification =
                                    listtask[index]["description"];
                                journotification = listtask[index]['jour'];
                                moisnotification = listtask[index]['mois'];
                                yearnotification = listtask[index]["year"];
                                hournotification = listtask[index]["hour"];
                                minutenotification = listtask[index]["minute"];
                                /*  _showNotification(listtask[index]["title"],
                                      listtask[index]["description"]);*/
                                if (DateTime.now().second == 0) {
                                  _showScheduledNotification(
                                      listtask[index]["id"],
                                      listtask[index]["title"],
                                      listtask[index]["description"]);
                                }
                              }
                              refreshtask();
                              if (listtask[index]["jour"] ==
                                      DateTime.now().day &&
                                  listtask[index]["mois"] ==
                                      DateTime.now().month &&
                                  listtask[index]["year"] ==
                                      DateTime.now().year) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 20,
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            DetailTaskHC(),
                                            arguments: [
                                              listtask[index]['title'],
                                              listtask[index]['description'],
                                              listtask[index]['jour'],
                                              listtask[index]['mois'],
                                              listtask[index]['year'],
                                              listtask[index]['hour'],
                                              listtask[index]['minute'],
                                              listtask[index]['description']
                                            ],
                                          );
                                        },
                                        child: Container(
                                          width: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xff1f4690)),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      listtask[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Date : ${listtask[index]['jour']}/${listtask[index]['mois']}/${listtask[index]['year']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Time : ${listtask[index]['hour']}:${listtask[index]['minute']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    icon: Icon(Icons.update),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () {
                                                      modalForm(listtask[index]
                                                          ['id']);
                                                    }),
                                                IconButton(
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () async {
                                                      await deleteData(
                                                          listtask[index]
                                                              ['id']);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })),
                        ListView.builder(
                            itemCount: listtask.length,
                            itemBuilder: ((context, index) {
                              if (listtask[index]["hour"] ==
                                      TimeOfDay.now().hour &&
                                  listtask[index]["minute"] ==
                                      TimeOfDay.now().minute) {
                                titlenotification = listtask[index]["title"];
                                descriptionotification =
                                    listtask[index]["description"];
                                journotification = listtask[index]['jour'];
                                moisnotification = listtask[index]['mois'];
                                yearnotification = listtask[index]["year"];
                                hournotification = listtask[index]["hour"];
                                minutenotification = listtask[index]["minute"];
                                /*  _showNotification(listtask[index]["title"],
                                      listtask[index]["description"]);*/
                                if (DateTime.now().second == 0) {
                                  _showScheduledNotification(
                                      listtask[index]["id"],
                                      listtask[index]["title"],
                                      listtask[index]["description"]);
                                }
                              }
                              refreshtask();
                              if (listtask[index]["typetask"] == "Exam") {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: Container(
                                    margin: EdgeInsets.only(top: 20),
                                    width: 20,
                                    height: 200,
                                    child: Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            DetailTaskHC(),
                                            arguments: [
                                              listtask[index]['title'],
                                              listtask[index]['description'],
                                              listtask[index]['jour'],
                                              listtask[index]['mois'],
                                              listtask[index]['year'],
                                              listtask[index]['hour'],
                                              listtask[index]['minute'],
                                              listtask[index]['description']
                                            ],
                                          );
                                        },
                                        child: Container(
                                          width: 20,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xff1f4690)),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      listtask[index]['title'],
                                                      style: TextStyle(
                                                          fontSize: 30,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Date : ${listtask[index]['jour']}/${listtask[index]['mois']}/${listtask[index]['year']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Time : ${listtask[index]['hour']}:${listtask[index]['minute']} ",
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                IconButton(
                                                    icon: Icon(Icons.update),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () {
                                                      modalForm(listtask[index]
                                                          ['id']);
                                                    }),
                                                IconButton(
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.white,
                                                    iconSize: 40,
                                                    onPressed: () async {
                                                      await deleteData(
                                                          listtask[index]
                                                              ['id']);
                                                    }),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }
                            })),
                      ],
                    ))
                  ],
                ),
              )),
        ));
  }

  Future<void> tambTask() async {
    await SQLHelper.insert(
        title, description, typetask, jour, mois, year, hour, minute);
    refreshtask();
  }

  Future<void> updateData(int id) async {
    await SQLHelper.updateData(
        id, title, description, typetask, jour, mois, year, hour, minute);
    refreshtask();
  }

  Future<void> deleteData(int id) async {
    await SQLHelper.deleteTask(id);

    refreshtask();
  }

  void modalForm(int id) {
    TimeOfDay selectedTime1 = TimeOfDay.now();
    DateTime selectedDate1 = DateTime.now();
    jour = selectedDate1.day;
    mois = selectedDate1.month;
    year = selectedDate1.year;
    hour = selectedTime1.hour;
    minute = selectedTime1.minute;
    value = items.first;
    typetask = items.first;
    if (id != null) {
      final dataTask = listtask.firstWhere((element) => element['id'] == id);
    }
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(22))),
        builder: (_) => SingleChildScrollView(
              child: Container(
                height: 2000,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    height: 2000,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(22),
                        topRight: Radius.circular(22),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Type of Task",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 12),

                        Center(
                          child: Container(
                            child: SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                  decoration: InputDecoration(
                                    fillColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        borderSide:
                                            BorderSide(color: Colors.grey)),
                                  ),
                                  isExpanded: true,
                                  icon: value == "cour"
                                      ? Icon(Icons.book)
                                      : Icon(Icons.home_work),
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
                                      this.value = value.toString();
                                      typetask = value;
                                    });
                                  }),
                            ),
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
                            // minLines: 2,

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
                                  context: context, initialTime: selectedTime);

                              if (pickerTime == null) return;
                              setState(() {
                                hour = pickerTime.hour;
                                minute = pickerTime.minute;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 40),

                        Container(
                            // margin: EdgeInsets.only(top: 20),
                            child: Center(
                          child: ElevatedButton(
                              onPressed: () async {
                                if (id == null) {
                                  await tambTask();
                                } else {
                                  await updateData(id);
                                }

                                Get.back();
                              },
                              child: Text(
                                id == null ? 'Add' : 'Update',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 20,
                                    fontFamily: 'Raleway'),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff334973),
                                elevation: 5,
                                padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              )),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
