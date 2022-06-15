import 'package:get/get.dart';

enum RouteName {TaskVd}

class AppController extends GetxService {
  //If you need to use your controller in many other places, and outside of GetBuilder, just create a get in your controller and have it easily. (or use Get.find<Controller>() ) 
  static AppController get to => Get.find();

 

 
}
