// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/view-model/check_auth.dart';
import '../main.dart';

class Splash extends StatefulWidget {
  Splash({Key key}) : super(key: key);
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
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
