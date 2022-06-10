import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:testgoogle/src/controller/video_controller.dart';
import 'package:testgoogle/src/controller/youtube_detail_controller.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetail extends GetView<YoutubeDetailController> {
  YoutubeDetail({Key key}) : super(key: key);
  static DateTime publishTime;
  static String title;
  static String description;
  //static String url;

  Widget titleZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          Text(
           
           DateFormat('yyyy-MM-dd – kk:mm').format(publishTime),
           style: TextStyle(
             fontSize: 13,
             color: Colors.black.withOpacity(0.5),
           ),
              )
        ],
      ),
    );
  }

  Widget descriptionZone() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Text(
        description,
        style: TextStyle(
          fontSize: 14,
        ),
      ),
    );
  }

  

  /* Widget _buttonLike() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buttonOne("like", controller.statistics.value.likeCount.toString()),
      ],
    );
  }*/

  Widget line() {
   return Container(
      height: 1,
      color: Colors.black.withOpacity(0.1),
    );
  }

  /*Widget _ownerZone() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          /* CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey.withOpacity(0.5),
           backgroundImage: 
                 Image.network("$url").image,
                    
          ),*/
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }*/

  Widget _description() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          titleZone(),
          line(),
          descriptionZone(),
          //  _buttonLike(),
          SizedBox(height: 20),
          line(),
        // _ownerZone()
          
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff274472),
      ),
      body: Column(
        children: [
          YoutubePlayer(
            controller: controller.playController,
            showVideoProgressIndicator: true,
            progressIndicatorColor: Colors.black,
            topActions: <Widget>[
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  controller.playController.metadata.title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
          Expanded(
            child: _description(),
          )
        ],
      ),
    );
  }
}
