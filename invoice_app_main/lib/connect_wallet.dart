import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slider_button/slider_button.dart';

import 'connection_controller.dart';
import 'helper.dart';

class ConnectWallet extends GetView<ConnectionController> {
  const ConnectWallet({super.key});

  getNetworkName(chainId) {
    switch (chainId) {
      case 1:
        return 'Ethereum Mainnet';
      case 3:
        return 'Ropsten Testnet';
      case 4:
        return 'Rinkeby Testnet';
      case 5:
        return 'Goreli Testnet';
      case 42:
        return 'Kovan Testnet';
      case 137:
        return 'Polygon Mainnet';
      case 80001:
        return 'Mumbai Testnet';
      default:
        return 'Unknown Chain';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/main_page_image.png',
              fit: BoxFit.fitHeight,
            ),
            controller.obx((state) => successScreen(),
                onLoading: const CircularProgressIndicator(),
                onEmpty: ElevatedButton(
                    onPressed: () => controller.loginUsingMetamask(),
                    child: const Text("Connect with Metamask"))),
          ],
        ),
      ),
    );
  }

  Container successScreen() {
    return Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Account',
              style: GoogleFonts.merriweather(
                  fontWeight: FontWeight.bold, fontSize: 16),
            ),
            Text(
              '${controller.session.accounts[0]}',
              style: GoogleFonts.inconsolata(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Chain: ',
                  style: GoogleFonts.merriweather(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  getNetworkName(controller.session.chainId),
                  style: GoogleFonts.inconsolata(fontSize: 16),
                )
              ],
            ),
            const SizedBox(height: 20),
            (controller.session.chainId != 80001)
                ? Row(
                    children: const [
                      Icon(Icons.warning, color: Colors.redAccent, size: 15),
                      Text('Network not supported. Switch to '),
                      Text(
                        'Mumbai Testnet',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )
                : (controller.getSignature == null)
                    ? Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () {
                              controller.disconnectWallet();
                            },
                            // onPressed: () =>
                            //     signMessageWithMetamask(
                            //         context,
                            //         generateSessionMessage(
                            //             _session.accounts[0])),
                            child: const Text('Disconnect Wallet')),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Signature: ",
                                style: GoogleFonts.merriweather(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text(
                                  truncateString(
                                      controller.getSignature.toString(), 4, 2),
                                  style: GoogleFonts.inconsolata(fontSize: 16))
                            ],
                          ),
                          const SizedBox(height: 20),
                          SliderButton(
                            action: () async {
                              // TODO: Navigate to main page
                            },
                            label: const Text('Slide to login'),
                            icon: const Icon(Icons.check),
                          )
                        ],
                      )
          ],
        ));
  }
}
