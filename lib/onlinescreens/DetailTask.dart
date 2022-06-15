import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/onlinescreens/RemindMe-page2.dart';
import 'package:testgoogle/onlinescreens/SearchTask.dart';

class DetailTask extends StatefulWidget {
  DetailTask({Key key}) : super(key: key);

  @override
  State<DetailTask> createState() => _DetailTaskState();
}

class _DetailTaskState extends State<DetailTask> {
  var routeurRemindMe2 = 1;
  @override
  Widget build(BuildContext context) {
    //pour récupirer tous les information de la tache
    var taskInfo = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

   shape: RoundedRectangleBorder(
           
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40))),
        
        backgroundColor:Color(0xfff0f0f0),
        title: IconButton(onPressed: (){
           if (taskInfo[8] == 1 ||
                  taskInfo[8] == 2 ||
                  taskInfo[8] == 3 ||
                  taskInfo[8] == 4 ||
                   taskInfo[8]==5      ) {
               
                routeurRemindMe2 = taskInfo[8];
                Get.to(RemindMe2(), arguments: routeurRemindMe2);
              } else {
                Get.to(SearchTask());
              }

        }, icon: Icon(Icons.arrow_back_ios,color: Color(0xff274472),)),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
      
              Container(
                
                height: 390,
                alignment: Alignment.center,
                 decoration: BoxDecoration(
                                        color:  Color(0xff274472),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                margin: EdgeInsets.only(top: 55,right: 20,left: 20),
                padding: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.text_rotation_none_rounded,color:Colors.white,size: 35,),
                        SizedBox(
                          width:30,
                        ),
                         Text("Title",style: TextStyle(color: Colors.white,fontSize: 22),)
                      ],
      
                    ),
                     SizedBox(
                          height:15,
                        ),
      
                       Container(alignment: Alignment.topLeft,child: Text(" ${taskInfo[1]}",style: TextStyle(color: Colors.white,fontSize: 20),)),
                         SizedBox(
                          height:10,
                        ),
                       Row(
                      children: [
                        Icon(Icons.text_snippet,color:Colors.white,size: 35,),
                        SizedBox(
                          width:30,
                        ),
                         Text("Description",style: TextStyle(color: Colors.white,fontSize: 22),)
                      ],
      
                    ),
                     SizedBox(
                          height:15,
                        ),
              Container(alignment: Alignment.topLeft,child: Text("${taskInfo[2]}",style: TextStyle(color: Colors.white,fontSize: 20))),
                             SizedBox(
                          height:10,
                        ),
                  Row(
                      children: [
                        Icon(Icons.calendar_today_outlined,color:Colors.white,size: 35,),
                        SizedBox(
                          width:30,
                        ),
                         Text("Date",style: TextStyle(color: Colors.white,fontSize: 22),)
                      ],
      
                    ),
                     SizedBox(
                          height:15,
                        ),
              Container(alignment: Alignment.topLeft,child: Text(" ${taskInfo[3]}/${taskInfo[4]}/${taskInfo[5]}",style: TextStyle(color: Colors.white,fontSize: 20))),
                          SizedBox(
                          height:10,
                        ),
                Row(
                      children: [
                        Icon(Icons.lock_clock,color:Colors.white,size: 35,),
                        SizedBox(
                          width:30,
                        ),
                         Text("Time",style: TextStyle(color: Colors.white,fontSize: 22),)
                      ],
      
                    ),
                     SizedBox(
                          height:15,
                        ),
                                    SizedBox(
                          height:10,
                        ),
              Container(alignment: Alignment.topLeft,child: Text(" ${taskInfo[6]}:${taskInfo[7]}",style: TextStyle(color: Colors.white,fontSize: 20))),
      
            
                  ],
                ),
              )
           
            ],
          ),
        ),
      ),
    );
  }
}
