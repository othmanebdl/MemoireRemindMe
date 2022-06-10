import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailTaskHC extends StatefulWidget {
  DetailTaskHC({Key key}) : super(key: key);

  @override
  State<DetailTaskHC> createState() => _DetailTaskHCState();
}

class _DetailTaskHCState extends State<DetailTaskHC> {
  var valuetask = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            backgroundColor:Color(0xfff0f0f0),
          shape: RoundedRectangleBorder(
           
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
          title: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Color(0xff274472),
              )),
        ),
        resizeToAvoidBottomInset: false,
        body: Container(
          height: 390,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xff274472),
            borderRadius: BorderRadius.circular(20),
          ),
          margin: EdgeInsets.only(top: 55, right: 20, left: 20),
          padding: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.text_rotation_none_rounded,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Title",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      " ${valuetask[0]}",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    )),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.text_snippet,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Description",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text("${valuetask[1]}",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Date",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                        " ${valuetask[2]}/${valuetask[3]}/${valuetask[4]}",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.lock_clock,
                      color: Colors.white,
                      size: 35,
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Text(
                      "Time",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    alignment: Alignment.topLeft,
                    child: Text(" ${valuetask[5]}:${valuetask[6]}",
                        style: TextStyle(color: Colors.white, fontSize: 20))),
              ]),
        ),
      ),
    );
  }
}
