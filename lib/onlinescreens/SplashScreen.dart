

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/view-model/check_auth.dart';


class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    // attendez 5 second pour ouvrir l'autre page
    Timer(Duration(seconds: 5), () {
      Get.to(ControlleAuth());
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor:Color(0xff1f4690) ,
          body: Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset('images/calendar_1.png', height: 300),
              SizedBox(height: 40),
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            ]),
          )),
    );
  }
}
