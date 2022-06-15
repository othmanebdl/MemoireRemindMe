import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:testgoogle/onlinescreens/RemindMe-page1.dart';


import 'package:testgoogle/videoYoutube/repository/youtube_repository.dart';



YoutubeRepository controller = YoutubeRepository();

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);




  Widget backButton() {
    return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color:Color(0xff274472) ,
                ),
                onPressed: () {
                  Get.to(RemindMe1());
                });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
  
            
            backButton(),
          ],
        ));
  }
}
