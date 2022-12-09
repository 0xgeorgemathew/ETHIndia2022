import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice/constants.dart';
import 'package:invoice/routes/app_pages.dart';
import 'package:invoice/upload/upload_controller.dart';

class UploadView extends GetView<UploadController> {
  const UploadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: controller.obx(
          (_) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Upload your invoice as pdf here',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.pickFiles(),
                child: const Text('Pick Files'),
              ),
              // ElevatedButton(
              //   onPressed: () => Get.toNamed(Routes.invoiceEntries,
              //       id: Constants.invoiceHomeId),
              //   child: const Text('Go to invoice'),
              // )
            ],
          ),
          onLoading: const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
