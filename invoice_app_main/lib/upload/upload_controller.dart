import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice/constants.dart';
import 'package:invoice/routes/app_pages.dart';

import '../provider/api_provider.dart';

class UploadController extends GetxController with StateMixin {
  ApiProvider provider = Get.find();
  final box = GetStorage();

  @override
  void onInit() {
    change(null, status: RxStatus.success());
    super.onInit();
  }

  void pickFiles() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

// The result will be null, if the user aborted the dialog
    if (result != null) {
      File file = File(result.files.first.path!);
      change(null, status: RxStatus.loading());
      await provider.signPdf(file).then((value) => {
            if (value.data != null)
              {
                box.write('Signed', value.data!.signedMessage),
                box.write('cId', value.data!.cId),
                change(null, status: RxStatus.success()),
                Get.snackbar("Success", "Signed Successfully",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white),
                Get.toNamed(Routes.invoiceEntries, id: Constants.invoiceHomeId)
              }
            else
              {
                Get.snackbar("Error", "Error while signing",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white)
              }
          });
    }
  }
}
