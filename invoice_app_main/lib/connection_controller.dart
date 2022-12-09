import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';

class ConnectionController extends GetxController with StateMixin {
  var connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
          name: 'Sell My Invoice',
          description: 'An app for converting pictures to NFT',
          url: 'https://walletconnect.org',
          icons: [
            'https://files.gitbook.com/v0/b/gitbook-legacy-files/o/spaces%2F-LJJeCjcLrr53DcT1Ml7%2Favatar.png?alt=media'
          ]));

  late SessionStatus _session;
  var _uri, _signature;

  get session => _session;
  get uri => _uri;
  set signature(String value) => _signature = value;
  get getSignature => _signature;
  final box = GetStorage();

  @override
  void onInit() {
    var account = box.read('account');
    var chainId = box.read('chainId');
    if (account == null && chainId == null) {
      change(null, status: RxStatus.empty());
    } else {
      _session = SessionStatus(
        accounts: [account],
        chainId: chainId,
      );
      change(session, status: RxStatus.success());
    }
    connector.on('connect', (SessionStatus session) {
      _session = session;
      box.write('account', session.accounts[0]);
      box.write('chainId', session.chainId);
      change(_session, status: RxStatus.success());
    });
    connector.on('session_update', (SessionStatus payload) {
      _session = payload;
      box.write('account', session.accounts[0]);
      box.write('chainId', session.chainId);
      change(_session, status: RxStatus.success());
      debugPrint(_session.accounts[0]);
      debugPrint(_session.chainId.toString());
    });
    connector.on('disconnect', (SessionStatus payload) {
      box.remove('account');
      box.remove('chainId');
      change(_session, status: RxStatus.success());
    });
    super.onInit();
  }

  void onConnectWalletClick() {
    loginUsingMetamask();
  }

  void loginUsingMetamask() async {
    if (!connector.connected) {
      try {
        SessionStatus session =
            await connector.createSession(onDisplayUri: (uri) async {
          _uri = uri;
          await launchUrlString(uri, mode: LaunchMode.externalApplication);
        });
        debugPrint(session.accounts[0]);
        debugPrint(session.chainId.toString());
        _session = session;
        box.write('account', session.accounts[0]);
        box.write('chainId', session.chainId);
        change(session, status: RxStatus.success());
      } catch (exp) {
        debugPrint(exp.toString());
        change(null, status: RxStatus.error(exp.toString()));
      }
    }
  }

  void disconnectWallet() {
    connector.killSession().then((value) => {
          box.remove('account'),
          box.remove('chainId'),
          change(null, status: RxStatus.empty())
        });
  }
}
