import 'package:alan_voice/alan_voice.dart';
import 'package:flutter/material.dart';
import 'package:testgoogle/main.dart';
import 'package:testgoogle/offline/Add_tasks_offline.dart';
import 'package:testgoogle/offline/DetailTaskHc.dart';
import 'package:testgoogle/offline/HomepageHc.dart';
import 'package:testgoogle/offline/sql_helper.dart';
import 'package:get/get.dart';
import 'package:testgoogle/onlinescreens/Add_tasks_online.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page1.dart';
import 'package:testgoogle/onlinescreens/SearchTask.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

class RechercheTask extends StatefulWidget {
  RechercheTask({Key key}) : super(key: key);

  @override
  State<RechercheTask> createState() => _RechercheTaskState();
}

class _RechercheTaskState extends State<RechercheTask> {
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
    }
  }

  void signinaccount() async {
    //await _auth.signOut();
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
  List<Map<String, dynamic>> listtask = [];
  //la value de recherche entrer par l'utilisateur
  String valuesearch = "";
  @override
  void initState() {
    // TODO: implement initState
    refreshtask();
    super.initState();
  }

//la methode qui recupirer les tache de valeur dr recherche
  void refreshtask() async {
    final data = await SQLHelper.getDataWithsearch(valuesearch);
    setState(() {
      listtask = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xff1f4690),
            shadowColor: Color(0xffDFE7F4),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            title: Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.grey[300],
              ),
              child: TextField(
                onTap: () {},
                onChanged: (value) {
                  setState(() {
                    //on affecter la valeur entrer par l'utilisateur dans la variable value search
                    valuesearch = value;
                    refreshtask();
                  });
                },
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Color(0xff3a5ba0),
                  ),
                  hintText: "Search",
                  border: InputBorder.none,
                ),
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.arrow_back_ios))
            ],
          ),
          body: listtask.length == 0
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "images/calendar.png",
                      width: 60,
                      height: 60,
                    ),
                    Text("Enter Title Task for Search"),
                  ],
                ))
              : ListView.builder(
                  itemCount: listtask.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Container(
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
                                    borderRadius: BorderRadius.circular(20),
                                    color: Color(0xff334973)),
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
                                            MainAxisAlignment.spaceAround,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text(
                                            listtask[index]['title'],
                                            style: TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Date : ${listtask[index]['jour']}/${listtask[index]['mois']}/${listtask[index]['year']} ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Time : ${listtask[index]['hour']}:${listtask[index]['minute']} ",
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w300,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                          icon: Icon(Icons.update),
                                          color: Colors.white,
                                          iconSize: 40,
                                          onPressed: () {}),
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
                      ))),
        ));
  }

  Future<void> deleteData(int id) async {
    await SQLHelper.deleteTask(id);

    refreshtask();
  }

 
}
