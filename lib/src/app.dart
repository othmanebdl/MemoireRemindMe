import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:testgoogle/src/controller/app_controller.dart';
import 'package:testgoogle/src/pages/VideoTask.dart';

import 'package:testgoogle/src/pages/home.dart';

class App extends GetView<AppController> {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return TaskVd();
      }),
    );
  }
}
