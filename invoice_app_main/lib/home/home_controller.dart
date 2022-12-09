import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController with StateMixin {
  RxInt tabIndex = 0.obs;
  RxString title = 'Sell My Invoice'.obs;

  void onTabClick(int newTab) {
    tabIndex.value = newTab;
  }
}
