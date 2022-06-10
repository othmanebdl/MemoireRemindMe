import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:youtube_explode_dart/youtube_explode_dart.dart';
import 'package:permission_handler/permission_handler.dart';

class Downloadvideo extends StatefulWidget {
  Downloadvideo({Key key}) : super(key: key);

  @override
  State<Downloadvideo> createState() => _DownloadvideoState();
}

class _DownloadvideoState extends State<Downloadvideo> {
  final TextEditingController _urlTextFieldController = TextEditingController();
  String videoTitle = '';
  String videoPublishDate = '';
  String videoID = '';
  bool _downloading = false;
  double progress = 0;
  static String videoId1;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Builder(builder: (context) {
          return GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Scaffold(
                body: SingleChildScrollView(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 80, left: 40, right: 40),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(""),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _urlTextFieldController,
                              onChanged: (val) {
                                getVideoInfo(val);
                              },
                              decoration: const InputDecoration(
                                  label: Text('Paste youtube video url here')),
                            ),
                          ),
                          SizedBox(
                            height: 250,
                            child: Image.network(videoID != ''
                                ? 'https://img.youtube.com/vi/$videoID/0.jpg'
                                : 'https://play-lh.googleusercontent.com/vA4tG0v4aasE7oIvRIvTkOYTwom07DfqHdUPr6k7jmrDwy_qA_SonqZkw6KX0OXKAdk'),
                          ),
                          Text(videoTitle),
                          Text(videoPublishDate),
                          TextButton.icon(
                              onPressed: () {
                                downloadVideo(_urlTextFieldController.text);
                              },
                              icon: const Icon(Icons.download),
                              label: const Text('Start download')),
                          _downloading
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: LinearProgressIndicator(
                                    value: progress,
                                    backgroundColor: Colors.blueAccent,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                            Colors.greenAccent),
                                  ),
                                )
                              : Container(),
                        ]),
                  ),
                ),
              ));
        }));
  }

  Future<void> getVideoInfo(url) async {
    var youtubeInfo = YoutubeExplode();
    var video = await youtubeInfo.videos.get(url);
    setState(() {
      videoTitle = video.title;
      videoPublishDate = video.publishDate.toString();
      videoID = video.id.toString();
    });
  }

  Future<void> downloadVideo(id) async {
    var permisson = await Permission.storage.request();
    if (permisson.isGranted) {
      //download video
      if (_urlTextFieldController.text != '') {
        setState(() => _downloading = true);

        //download video
        setState(() => progress = 0);
        var _youtubeExplode = YoutubeExplode();
        //get video metadata
        var video = await _youtubeExplode.videos.get(id);
        var manifest =
            await _youtubeExplode.videos.streamsClient.getManifest(id);
        var streams = manifest.muxed.withHighestBitrate();
        var audio = streams;
        var audioStream = _youtubeExplode.videos.streamsClient.get(audio);
        //create a directory
        Directory appDocDir = await getApplicationDocumentsDirectory();
        String appDocPath = appDocDir.path;
        print(appDocPath);
        var file = File('$appDocPath/${video.id}');
        //delete file if exists
        if (file.existsSync()) {
          file.deleteSync();
        }
        var output = file.openWrite(mode: FileMode.writeOnlyAppend);
        var size = audio.size.totalBytes;
        var count = 0;

        await for (final data in audioStream) {
          // Keep track of the current downloaded data.
          count += data.length;
          // Calculate the current progress.
          double val = ((count / size));
          var msg = '${video.title} Downloaded to $appDocPath/${video.id}';
          for (val; val == 1.0; val++) {
            // SnackBar(backgroundColor: Colors.blue,content: Text(msg,style: TextStyle(color: Colors.black),));
            // ScaffoldMessenger.of(context)
            // .showSnackBar(SnackBar(content: Text(msg)));

            print(msg);
            Get.snackbar("Intalled completed", "installed completed $msg",
                colorText: Color.fromARGB(255, 255, 255, 255),
                backgroundColor: Color(0xffffa500),
                snackPosition: SnackPosition.TOP,
                margin: EdgeInsets.symmetric(horizontal: 15),
                isDismissible: true,
                borderRadius: 20,
                icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                ));
          }
          setState(() => progress = val);

          // Write to file.
          output.add(data);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('add youtube video url first!')));
        setState(() => _downloading = false);
      }
    } else {
      await Permission.storage.request();
    }
  }
}
