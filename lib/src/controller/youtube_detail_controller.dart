import 'package:get/get.dart';
import 'package:testgoogle/src/controller/video_controller.dart';
import 'package:testgoogle/src/models/statistics.dart';
import 'package:testgoogle/src/models/video.dart';
import 'package:testgoogle/src/models/youtuber.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeDetailController extends GetxController {
  Rx<Video> video = Video().obs;
  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;
  YoutubePlayerController playController;
   static String videoid;

  @override
  void onInit() {
    VideoController videoController = Get.find(tag: Get.parameters["videoid"]);
    video(videoController.video);
    statistics(videoController.statistics.value);
    youtuber(videoController.youtuber.value);
    videoShow();
    super.onInit();
  }

  void videoShow() {
    playController = YoutubePlayerController(
      initialVideoId: videoid,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
      ),
    );
  }
}
