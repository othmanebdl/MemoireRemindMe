import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/offline/Add_tasks_offline.dart';
import 'package:testgoogle/offline/HomepageHc.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

class Alan extends StatefulWidget {
  Alan({Key key}) : super(key: key);

  @override
  State<Alan> createState() => _AlanState();
}

class _AlanState extends State<Alan> {
  void _handleCommand(Map<String, dynamic> command) {
    switch (command['command']) {
      case 'offline':
        {
          Get.to(HomepageHc());
          break;
        }
      case 'offline add task':
        {
          Get.to(Add_Task_offline());
          break;
        }
      case 'online':
        {
          Get.find<Authviewmodel>().user != null
              ? Get.to(RemindMe1())
              : Get.to(Homepage());

          break;
        }
    }
  }

  _AlanState() {
    /// Init Alan Button with project key from Alan Studio
    AlanVoice.addButton(
        "19d677c90d4609f685cbd88da87bcb5b2e956eca572e1d8b807a3e2338fdd0dc/stage",
        buttonAlign: AlanVoice.BUTTON_ALIGN_LEFT);

    /// Handle commands from Alan Studio
    AlanVoice.onCommand.add((command) {
      _handleCommand(command.data);
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          RaisedButton(onPressed: () {
            Get.back();
          })
        ],
      )),
    );
  }
}
