import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:invoice/routes/app_pages.dart';
import 'package:invoice/test/ethereum_transaction_tester.dart';
import 'package:invoice/test/transaction_tester.dart';
import 'package:invoice/wallet_connect_lifecycle.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'connect_wallet.dart';
import 'transaction_state.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sell My Invoice',
      getPages: AppPages.pages,
      navigatorObservers: [FlutterSmartDialog.observer],
      // here
      builder: FlutterSmartDialog.init(),
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class ConnectWalletQR extends StatefulWidget {
  const ConnectWalletQR({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ConnectWalletQR> createState() => _ConnectWalletQRState();
}

class _ConnectWalletQRState extends State<ConnectWalletQR> {
  String txId = '';
  String _displayUri = '';
  TransactionState _state = TransactionState.disconnected;
  final TransactionTester _transactionTester = EthereumTransactionTester();

  @override
  Widget build(BuildContext context) {
    return WalletConnectLifecycle(
      connector: _transactionTester.connector,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (_displayUri.isEmpty)
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Text(
                            'Click on the button below to connect',
                            style: Theme.of(context).textTheme.headline6,
                            textAlign: TextAlign.center,
                          ),
                        )
                      : QrImage(data: _displayUri),
                  ElevatedButton(
                    onPressed:
                        _transactionStateToAction(context, state: _state),
                    child: Text(
                      _transactionStateToString(state: _state),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      await _transactionTester.disconnect();
                    },
                    child: const Text(
                      'Disconnect',
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {},
                    child: const Text(
                      'Disconnect',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _transactionStateToString({required TransactionState state}) {
    switch (state) {
      case TransactionState.disconnected:
        return 'Connect!';
      case TransactionState.connecting:
        return 'Connecting';
      case TransactionState.connected:
        return 'Session connected, preparing transaction...';
      case TransactionState.connectionFailed:
        return 'Connection failed';
      case TransactionState.transferring:
        return 'Transaction in progress...';
      case TransactionState.success:
        return 'Transaction successful';
      case TransactionState.failed:
        return 'Transaction failed';
    }
  }

  VoidCallback? _transactionStateToAction(BuildContext context,
      {required TransactionState state}) {
    switch (state) {
      // Progress, action disabled
      case TransactionState.connecting:
      case TransactionState.transferring:
      case TransactionState.connected:
        return null;

      // Initiate the connection
      case TransactionState.disconnected:
      case TransactionState.connectionFailed:
        return () async {
          setState(() => _state = TransactionState.connecting);
          final session = await _transactionTester.connect(
            onDisplayUri: (uri) => setState(() => _displayUri = uri),
          );
          if (session != null) {
            debugPrint('Unable to connect');
            setState(() => _state = TransactionState.failed);
            return;
          }

          setState(() => _state = TransactionState.connected);
          Future.delayed(const Duration(seconds: 1), () async {
            // Initiate the transaction
            setState(() => _state = TransactionState.transferring);

            try {
              await _transactionTester.signTransaction(session);
              setState(() => _state = TransactionState.success);
            } catch (e) {
              debugPrint('Transaction error: $e');
              setState(() => _state = TransactionState.failed);
            }
          });
        };

      // Finished
      case TransactionState.success:
      case TransactionState.failed:
        return null;
    }
  }
}
