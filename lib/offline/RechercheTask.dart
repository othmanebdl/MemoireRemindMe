import 'package:flutter/material.dart';
import 'package:testgoogle/offline/DetailTaskHc.dart';
import 'package:testgoogle/offline/sql_helper.dart';
import 'package:get/get.dart';

class RechercheTask extends StatefulWidget {
  RechercheTask({Key key}) : super(key: key);

  @override
  State<RechercheTask> createState() => _RechercheTaskState();
}

class _RechercheTaskState extends State<RechercheTask> {
  List<Map<String, dynamic>> listtask = [];
  String valuesearch = "";
  @override
  void initState() {
    // TODO: implement initState
    refreshtask();
    super.initState();
  }

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
                onTap: () {
                  //_buttomsheetlogin(context);
                },
                onChanged: (value) {
                  setState(() {
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
                                          onPressed: () async {}),
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
}
