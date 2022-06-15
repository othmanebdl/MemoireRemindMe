import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/videoYoutube/controller/app_controller.dart';
import 'package:testgoogle/videoYoutube/pages/VideoTask.dart';


class Homepagevideo extends GetView<AppController> {
  const Homepagevideo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return TaskVd();
      }),
    );
  }
}
