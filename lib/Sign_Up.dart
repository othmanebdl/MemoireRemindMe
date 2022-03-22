import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
//import 'package:googleapis/adsense/v2.dart';
//import 'package:googleapis/content/v2_1.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:testgoogle/view-model/service_firestore/FirestoreUser.dart';

import 'model/User_information.dart';

Authviewmodel controller = Authviewmodel();
String? username;

class Sign_up extends StatefulWidget {
  const Sign_up({Key? key}) : super(key: key);

  @override
  State<Sign_up> createState() => _Sign_upState();
}

class _Sign_upState extends State<Sign_up> {
  late String nameuser;
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.offAll(Homepage());
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Sign up to Continue",
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "User Name",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  controller.nameuser = value;
                  username = value;
                },
                decoration: InputDecoration(
                    hintText: "othmane",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  controller.email = value;
                },
                decoration: InputDecoration(
                    hintText: "othmanedev@gmail.com",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Password",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade900,
                  ),
                ),
              ),
              TextFormField(
                onChanged: (value) {
                  controller.password = value;
                },
                decoration: InputDecoration(
                    hintText: "***********",
                    hintStyle: TextStyle(color: Colors.grey),
                    fillColor: Colors.white),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    controller.Create_Account_WithEmailandPassword();
                  
                  },
                  child: Text("SIGN  UP")),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: ElevatedButton(
                  onPressed: () async {
                    // _buttomsheetcreateaccount(context);
                    // UserCredential cred = await signInWithGoogle();
                    //Navigator.of(context).push(
                    //MaterialPageRoute(builder: (context) => RemindMe1()),
                    // );
                    // Get.to(RemindMe1());
                    // controller.SignIngoogle();
                    UserCredential usercred = await signInWithGoogle();
                    Get.offAll(RemindMe1());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(FontAwesomeIcons.google, color: Colors.white),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        "Sign With Google",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Raleway'),
                      ),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    elevation: 5,
                    padding: EdgeInsets.fromLTRB(20, 13, 40, 13),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
