import 'package:get/get.dart';
import 'package:invoice/connection_controller.dart';
import 'package:invoice/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ConnectionController>(() => ConnectionController());
  }
}
