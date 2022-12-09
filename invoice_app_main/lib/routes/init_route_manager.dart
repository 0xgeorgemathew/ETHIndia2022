// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get_navigation/src/nav2/router_outlet.dart';

// Project imports:
import 'app_pages.dart';

class InitRouteManager extends StatelessWidget {
  const InitRouteManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // if (authCtr.isAuthenticated() == null) {
    //   return const Scaffold(
    //     body: Center(child: IndiclawLoader()),
    //   );
    // }
    return Scaffold(
      body: GetRouterOutlet(initialRoute: Routes.invoiceHome
          // anchorRoute: '/',
          // filterPages: (afterAnchor) {
          //   return afterAnchor.take(1);
          // },
          ),
    );
  }
}
