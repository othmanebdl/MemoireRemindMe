import 'package:get/get.dart';
import 'package:get/get_connect/connect.dart';
import 'package:testgoogle/src/models/statistics.dart';
import 'package:testgoogle/src/models/youtube_video_result.dart';
import 'package:testgoogle/src/models/youtuber.dart';

class YoutubeRepository extends GetConnect {
  static String querysearch;
  static YoutubeRepository get to => Get.find();

  @override
  void onInit() {
    httpClient.baseUrl = "https://www.googleapis.com";
  }

 /* Future<YoutubeVideoResult> loadVideos(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&q=$querysearch&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA&pageToken=$nextPageToken";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }*/

  Future<YoutubeVideoResult> loadTaskVed(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&q=$querysearch&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA&pageToken=$nextPageToken";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }

  /*Future<YoutubeVideoResult> loadCleanCode(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&q=cleancode&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA&pageToken=$nextPageToken";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }*/

  /*Future<YoutubeVideoResult> loadDart(String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&q=dart&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }*/

 /* Future<YoutubeVideoResult> search(
      String searchKeyword, String nextPageToken) async {
    String url =
        "/youtube/v3/search?part=snippet&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA&pageToken=$nextPageToken&q=$searchKeyword";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        return YoutubeVideoResult.fromJson(response.body);
      }
    }
  }*/

  Future<Statistics> getVideoInfoById(String videoId) async {
    String url =
        "/youtube/v3/videos?part=statistics&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA&id=$videoId";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Statistics.fromJson(data["statistics"]);
      }
    }
  }

  Future<Youtuber> getYoutuberInfoById(String channelId) async {
    String url =
        "/youtube/v3/channels?part=statistics,snippet&key=AIzaSyChYQRoJ_iebK4GdIYpEZGhEuCnAG8a9fA&id=$channelId";
    final response = await get(url);
    if (response.status.hasError) {
      return Future.error(response.statusText);
    } else {
      if (response.body["items"] != null && response.body["items"].length > 0) {
        Map<String, dynamic> data = response.body["items"][0];
        return Youtuber.fromJson(data);
      }
    }
  }
}
