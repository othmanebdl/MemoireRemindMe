import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/videoYoutube/models/youtube_video_result.dart';
import 'package:testgoogle/videoYoutube/repository/youtube_repository.dart';


class TaskVedController extends GetxController {
  static TaskVedController get to => Get.find();
  

  ScrollController scrollController = ScrollController();

  Rx<YoutubeVideoResult> youtubeResult = YoutubeVideoResult(items: []).obs;

  @override
  void onInit() {
    videoLoadTask();
    event();
    super.onInit();
  }

  void event() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent &&
          youtubeResult.value.nextPagetoken != "") {
        videoLoadTask();
      }
    });
  }

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
