import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:testgoogle/screens/RemindMe-page1.dart';
import 'package:testgoogle/src/pages/downloadvideo.dart';

import 'package:testgoogle/src/repository/youtube_repository.dart';



YoutubeRepository controller = YoutubeRepository();

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key key}) : super(key: key);



 /* Widget actions() {
    return Row(
      children: [
      
        GestureDetector(
          onTap: () {
            Get.to(
                        YoutubeSearch(),
                        binding: BindingsBuilder(
                          () => Get.lazyPut<YoutubeSearchController>(
                              () => YoutubeSearchController()),
                        ),
              
                      );
          },
          child: Container(
            width: 30,
            height: 30,
            child: SvgPicture.asset("assets/svg/icons/search.svg"),
          ),
        ),
     
      ],
    );
  }*/
Widget downloadvideo(){
   return IconButton(
                icon: const Icon(
                  Icons.download,
                  size: 25,
                  color:Color(0xff274472) ,
                ),
                onPressed: () {
                  Get.to(Downloadvideo());
                });

}
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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
          
         //   actions(),
            downloadvideo(),
            backButton(),
          ],
        ));
  }
}
