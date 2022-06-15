import 'package:testgoogle/videoYoutube/models/statistics.dart';
import 'package:testgoogle/videoYoutube/models/video.dart';


class Youtuber {
  Youtuber({
    this.snippet,
    this.statistics,
  });

  Snippet snippet;
  Statistics statistics;

  factory Youtuber.fromJson(Map<String, dynamic> json) => Youtuber(
        snippet: Snippet.fromJson(json["snippet"]),
        statistics: Statistics.fromJson(json["statistics"]),
      );
}
