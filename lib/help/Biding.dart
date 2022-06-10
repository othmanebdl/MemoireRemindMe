import 'package:get/get.dart';
import 'package:testgoogle/src/controller/app_controller.dart';
import 'package:testgoogle/src/repository/youtube_repository.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

import '../view-model/service_firestore/firestoreLessHomework.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Authviewmodel(), fenix: true);
    Get.lazyPut(() => FirestoreLessondevoir(), fenix: true);
    Get.put(FirestoreLessondevoir(), permanent: true);
    Get.put(Authviewmodel(), permanent: true);
    Get.put(YoutubeRepository(), permanent: true);
    Get.put(AppController(), permanent: true);
    Get.lazyPut(() => AppController());

    // TODO: implement dependencies
  }
}
