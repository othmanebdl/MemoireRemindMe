import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/src/models/youtube_video_result.dart';
import 'package:testgoogle/src/repository/youtube_repository.dart';


class HomeController extends GetxController {
  static HomeController get to => Get.find();
  //If you need to use your controller in many other places, and outside of GetBuilder, just create a get in your controller and have it easily. (or use Get.find<Controller>() ) نصيحه يعني

  ScrollController scrollController = ScrollController();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;

  @override
  void onInit() {
  //  videoLoad();
    videoLoadTask();
    _event();
    super.onInit();
  }

  void _event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPagetoken != "") {
      //  videoLoad();
      }
    });
  }

  /*void videoLoad() async {
    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadVideos(youtubeResult.value.nextPagetoken ?? "");

 

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((youtube) {
        youtube.nextPagetoken = youtubeVideoResult.nextPagetoken;
        youtube.items.addAll(youtubeVideoResult.items);
      });
    }
  }*/

  void videoLoadTask() async {
    YoutubeVideoResult youtubeVideoResult = await YoutubeRepository.to
        .loadTaskVed(youtubeResult.value.nextPagetoken ?? "");

   

    if (youtubeVideoResult != null &&
        youtubeVideoResult.items != null &&
        youtubeVideoResult.items.length > 0) {
      youtubeResult.update((youtube) {
        youtube.nextPagetoken = youtubeVideoResult.nextPagetoken;
        youtube.items.addAll(youtubeVideoResult.items);
      });
    }
  }
}
