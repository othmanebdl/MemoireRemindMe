import 'package:get/get.dart';

enum RouteName { GetXVd, Add, DartVid }

class AppController extends GetxService {
  //If you need to use your controller in many other places, and outside of GetBuilder, just create a get in your controller and have it easily. (or use Get.find<Controller>() ) نصيحه يعني
  static AppController get to => Get.find();

  RxInt currentIndex = 0.obs;

  void changePageIndex(int index) {
    if (RouteName.values[index] == RouteName.Add) {
      
    } else {
      currentIndex(index);
    }
  }
}
