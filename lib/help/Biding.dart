import 'package:get/get.dart';
import 'package:testgoogle/view-model/auth_view_model.dart';

import '../view-model/service_firestore/firestoreLessHomework.dart';

class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Authviewmodel(),fenix: true);
    Get.lazyPut(() => FirestoreLessondevoir(),fenix:true);
    // TODO: implement dependencies
  }
}
