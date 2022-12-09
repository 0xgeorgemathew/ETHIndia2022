import 'package:get/get.dart';
import 'package:invoice/home/home_binding.dart';
import 'package:invoice/invoice/invoice_binding.dart';
import 'package:invoice/invoice/invoice_view.dart';
import 'package:invoice/upload/upload_binding.dart';
import 'package:invoice/upload/upload_view.dart';

import '../home/home_view.dart';
import 'init_route_manager.dart';

// Package imports:
// Project imports:

// Project imports:
part './app_routes.dart';

class AppPages {
  AppPages._();

  static final pages = [
    /// initial
    GetPage(
      name: '/',
      page: () => const InitRouteManager(),
      binding: HomeBinding(),
      participatesInRootNavigator: true,
    ),
    //splash
    // GetPage is used to define the route, page, and name of the route.
    // We use the route name to navigate to it.
    GetPage(
        name: Routes.invoiceHome,
        page: () => const HomeView(),
        binding: HomeBinding()),
    GetPage(
        name: Routes.invoiceEntries,
        page: () => const InvoiceView(),
        binding: InvoiceBinding()),

    GetPage(
        name: Routes.invoiceUpload,
        page: () => const UploadView(),
        binding: UploadBinding()),
  ];
}
