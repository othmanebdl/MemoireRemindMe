import 'package:get/get.dart';
import 'package:testgoogle/src/models/statistics.dart';
import 'package:testgoogle/src/models/video.dart';
import 'package:testgoogle/src/models/youtuber.dart';
import 'package:testgoogle/src/repository/youtube_repository.dart';

class VideoController extends GetxController {
  Video video;
  VideoController({this.video});
  Rx<Statistics> statistics = Statistics().obs;
  Rx<Youtuber> youtuber = Youtuber().obs;
  static String videoid;
  @override
  void onInit() async {
    Statistics loadStatistics =
        await YoutubeRepository.to.getVideoInfoById(video.id.videoId);
    statistics(loadStatistics);
    Youtuber loadYoutuber =
        await YoutubeRepository.to.getYoutuberInfoById(video.snippet.channelId);
    youtuber(loadYoutuber);
    super.onInit();
  }

  String get viewCountString => "Views ${statistics.value.viewCount ?? '-'}";
  String get youtuberThumbnailUrl {
    if (youtuber.value.snippet == null)
      return "Empty";
    return youtuber.value.snippet.thumbnails.medium.url;
  }
}
