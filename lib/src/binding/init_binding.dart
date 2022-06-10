import 'package:get/get.dart';
import 'package:testgoogle/src/controller/app_controller.dart';
import 'package:testgoogle/src/controller/video_controller.dart';
import 'package:testgoogle/src/repository/youtube_repository.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';
import 'package:testgoogle/view-model/service_firestore/firestoreLessHomework.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    //Get.put(YoutubeRepository(), permanent: true);
    //Get.put(AppController());
    //Get.lazyPut(() => AppController());
  
   
   
  }
}
