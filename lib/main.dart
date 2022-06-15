import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:testgoogle/Sign_Up.dart';
import 'package:testgoogle/Sign_inPage.dart';
import 'package:get/get.dart';
import 'package:testgoogle/help/Biding.dart';
import 'package:testgoogle/offline/AlanAssistant.dart';
import 'package:testgoogle/offline/HomepageHc.dart';
import 'package:testgoogle/videoYoutube/controller/video_controller.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page1.dart';
import 'package:testgoogle/onlinescreens/SplashScreen.dart';
import 'package:testgoogle/view-model/check_auth.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Binding().dependencies();
  Get.put(VideoController(), permanent: true);

  runApp(Splash());
}

class Memoirereminder extends StatefulWidget {
  const Memoirereminder({Key key}) : super(key: key);

  @override
  State<Memoirereminder> createState() => _MemoirereminderState();
}

class _MemoirereminderState extends State<Memoirereminder> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: GetMaterialApp(
        //Initialiser les class Controller
        initialBinding: Binding(),

        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,

              body:
                  ControlleAuth(), //ControlLeAuth for check if user Connected or no.
            ),
          );
        }),
      ),
    );
  }
}

class Homepage extends StatefulWidget {
  Homepage({Key key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
  }

  Authviewmodel controller =
      Authviewmodel(); //Create instance Class Authviewmodel  to access his variable and Methode
  final FirebaseAuth _auth = FirebaseAuth
      .instance; //Create instance Class FirebaseAuth  to access his variable and Methode

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Column(children: [
                      Image.asset(
                        "images/to-do-list.png",
                        width: 250,
                        height: 250,
                      ),
                      Text(
                        "Welcome",
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontSize: 28,
                            fontFamily: 'Raleway'),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Before enjoying Reminder Students Service , Please register first",
                        style: TextStyle(
                          color: Color(0xff4B5563),
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Raleway',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff1f4690),
                                  elevation: 5,
                                  padding: EdgeInsets.fromLTRB(45, 20, 45, 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                ),
                                onPressed: () {
                                  Get.offAll(Sign_up());
                                  //Get.to(Page2());
                                },
                                child: Text("create Account")),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  Get.to(Sign_In());
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff1f4690),
                                elevation: 5,
                                padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Text(
                                " Login",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 140,
                                  child: Divider(
                                    height: 20,
                                    color: Color(0xff3a5ba0),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Or",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Raleway',
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  width: 136,
                                  child: Divider(
                                    height: 20,
                                    color: Color(0xff3a5ba0),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  Get.to(HomepageHc());
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xff1f4690),
                                elevation: 5,
                                padding: EdgeInsets.fromLTRB(80, 20, 80, 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              child: Text(
                                "offline",
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height:40
                  ),
                
                  Container(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(Icons.keyboard_voice_outlined),
                    
                      color: Color(0xff1f4690),
                      onPressed: () {
                        Get.to(Alan());
                      },
                    ),
                  )
                ]),
          ),
        )));
  }
}
