import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/videoYoutube/components/custom_appbar.dart';
import 'package:testgoogle/videoYoutube/components/video_widget.dart';
import 'package:testgoogle/videoYoutube/components/youtube_detail.dart';
import 'package:testgoogle/videoYoutube/controller/Task_controller.dart';
import 'package:testgoogle/videoYoutube/controller/youtube_detail_controller.dart';

class TaskVd extends StatelessWidget {
  TaskVd({Key key}) : super(key: key);
  final TaskVedController controller = Get.put(TaskVedController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => CustomScrollView(
          controller: controller.scrollController,
          slivers: [
            SliverAppBar(
              backgroundColor: Colors.white,
              title: CustomAppBar(),
            
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
                      
                      YoutubeDetailController.videoid = controller
                          .youtubeResult.value.items[index].id.videoId;
                          
                      YoutubeDetail.title = controller
                          .youtubeResult.value.items[index].snippet.title;
                      YoutubeDetail.publishTime = controller
                          .youtubeResult.value.items[index].snippet.publishTime;
                      YoutubeDetail.description = controller
                          .youtubeResult.value.items[index].snippet.description;
                      controller.youtubeResult.value.items[index].snippet
                          .thumbnails.medium.url;
                          
                      Get.to(
                        YoutubeDetail(),
                        binding: BindingsBuilder(
                          () => Get.lazyPut<YoutubeDetailController>(
                              () => YoutubeDetailController()),
                        ),
                       
                      );
                    },
                    child: VideoWidget(
                        video: controller.youtubeResult.value.items[index]),
                  );
                },
                childCount: controller.youtubeResult.value.items == null
                    ? 0
                    : controller.youtubeResult.value.items.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
