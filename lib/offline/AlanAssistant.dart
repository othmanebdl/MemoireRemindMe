import 'package:alan_voice/alan_voice.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testgoogle/Sign_Up.dart';
import 'package:testgoogle/Sign_inPage.dart';
import 'package:testgoogle/offline/Add_tasks_offline.dart';
import 'package:testgoogle/offline/HomepageHc.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/onlinescreens/Add_tasks_online.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page1.dart';
import 'package:testgoogle/onlinescreens/SearchTask.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

final GoogleSignIn googleSignIn = new GoogleSignIn();
FirebaseAuth _auth = FirebaseAuth.instance;

class Alan extends StatefulWidget {
  Alan({Key key}) : super(key: key);

  @override
  State<Alan> createState() => _AlanState();
}

class _AlanState extends State<Alan> {
  void _etudierCommand(Map<String, dynamic> command) {
    switch (command['command']) {
      case 'offline home page':
        {
          Get.to(HomepageHc());
          break;
        }
      case 'offline add task':
        {
          Get.to(Add_Task_offline());
          break;
        }
      case 'online home page':
        {
          Get.find<Authviewmodel>().user != null
              ? Get.to(RemindMe1())
              : Get.to(Homepage());

          break;
        }
      case 'online add task':
        {
          Get.find<Authviewmodel>().user != null
              ? Get.to(AddTask_online())
              : Get.to(Homepage());

          break;
        }
      case 'online search task':
        {
          Get.find<Authviewmodel>().user != null
              ? Get.to(SearchTask())
              : Get.to(Homepage());

          break;
        }
      case 'sign out':
        {
          Get.find<Authviewmodel>().user != null
              ? signinaccount()
              : Get.to(HomepageHc());

          break;
        }
      case 'sign in':
        {
          Get.to(Sign_In());
          break;
        }
      case 'sign up':
        {
          Get.to(Sign_up());
          break;
        }
    }
  }

  void signinaccount() async {
    await _auth.signOut();
    await googleSignIn.signOut();
    Get.to(Homepage());
  }

  _AlanState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "19d677c90d4609f685cbd88da87bcb5b2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      _etudierCommand(command.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
                backgroundColor: Colors.grey[300],
                elevation: 10,
                shadowColor: Color(0xffDFE7F4),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30))),
              
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff3a5ba0),
                    ),
                    onPressed: () {
                  
                      Get.back();
                    
                    },
                  ),
                ],
              ),
        body: Center(
          child: Column(
            children: [
              Container(
                height: 390,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xff1f4690),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: EdgeInsets.only(top: 55, right: 20, left: 20),
                padding: EdgeInsets.all(20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    
                      Text(
                          "Click on the button at the bottom left of the page to use Alan voice",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
