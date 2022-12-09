import 'package:get/get.dart';
import 'package:invoice/upload/upload_controller.dart';

import '../provider/api_provider.dart';

class UploadBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadController>(() => UploadController());
    Get.lazyPut<ApiProvider>(() => ApiProvider());
  }
}
