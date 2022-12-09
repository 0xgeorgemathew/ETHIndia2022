import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invoice/connection_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class SignatureController extends GetxController with StateMixin {
  ConnectionController connectionController = Get.find();
  final _signature = ''.obs;

  signMessageWithMetamask(String message) async {
    change(null, status: RxStatus.loading());
    if (connectionController.connector.connected) {
      try {
        debugPrint("Message received");
        debugPrint(message);

        EthereumWalletConnectProvider provider =
            EthereumWalletConnectProvider(connectionController.connector);
        launchUrlString(connectionController.uri,
            mode: LaunchMode.externalApplication);
        var signature = await provider.personalSign(
            message: message,
            address: connectionController.session.accounts[0],
            password: "");
        debugPrint(signature);
        _signature.value = signature;
        connectionController.signature = signature;
        change(null, status: RxStatus.loading());
      } catch (exp) {
        debugPrint("Error while signing transaction");
        debugPrint(exp.toString());
      }
    }
  }
}
