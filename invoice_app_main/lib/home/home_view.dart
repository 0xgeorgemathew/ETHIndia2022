import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice/connect_wallet.dart';
import 'package:invoice/constants.dart';
import 'package:invoice/home/home_controller.dart';
import 'package:invoice/invoice/invoice_binding.dart';
import 'package:invoice/invoice/invoice_view.dart';
import 'package:invoice/routes/app_pages.dart';
import 'package:invoice/upload/upload_binding.dart';
import 'package:invoice/upload/upload_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(controller.title.value)),
        centerTitle: true,
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.tabIndex.value,
          children: [
            Navigator(
              key: Get.nestedKey(Constants.invoiceHomeId),
              initialRoute: Routes.invoiceUpload,
              onGenerateRoute: (routeSettings) {
                if (routeSettings.name == Routes.invoiceEntries) {
                  return GetPageRoute(
                      routeName: Routes.invoiceEntries,
                      page: () => const InvoiceView(),
                      transitionDuration: const Duration(milliseconds: 100),
                      transition: Transition.circularReveal,
                      popGesture: true,
                      maintainState: true,
                      binding: InvoiceBinding());
                }
                if (routeSettings.name == Routes.invoiceUpload) {
                  return GetPageRoute(
                      routeName: Routes.invoiceUpload,
                      page: () => const UploadView(),
                      transitionDuration: const Duration(milliseconds: 100),
                      transition: Transition.circularReveal,
                      popGesture: true,
                      maintainState: true,
                      binding: UploadBinding());
                }
                return null;
              },
            ),
            const ConnectWallet()
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.tabIndex.value,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
          ],
          onTap: controller.onTabClick,
        ),
      ),
    );
  }
}
