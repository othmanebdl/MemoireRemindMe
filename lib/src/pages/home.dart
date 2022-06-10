import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testgoogle/src/components/custom_appbar.dart';
import 'package:testgoogle/src/components/video_widget.dart';
import 'package:testgoogle/src/components/youtube_detail.dart';
import 'package:testgoogle/src/controller/home_controller.dart';
import 'package:testgoogle/src/controller/video_controller.dart';
import 'package:testgoogle/src/controller/youtube_detail_controller.dart';

class Home extends StatelessWidget {
  Home({Key key}) : super(key: key);

  final HomeController controller = Get.put(HomeController());
  YoutubeDetailController controller1 = Get.put(YoutubeDetailController());
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
             // floating: true,
             // snap: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onTap: () {
               
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
