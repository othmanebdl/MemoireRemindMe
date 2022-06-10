import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/screens/SplashScreen.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/main.dart';

class ControlleAuth extends GetWidget<Authviewmodel> {
  const ControlleAuth({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<Authviewmodel>().user != null)
          ? RemindMe1()
          : Homepage();
    });
  }
}
