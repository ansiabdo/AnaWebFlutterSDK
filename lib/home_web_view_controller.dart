import 'package:anaweb_flutter_sdk/main.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

enum ProgressStatus { download, uncompress, load, ready, failed }

class HomeWebViewController extends GetxController {
  DateTime? currentBackPressTime;

  InAppWebViewController? webController;

  String lang = 'ar';

  final progressStatus = ProgressStatus.load.obs;

  final progress = 0.0.obs;

  String url = 'https://stagebas.yk-bank.com:9104/';
  // String url = 'https://anawebykb.web.app/';

  Future<bool> onBack({bool byDeviceBackButton = false}) async {
    bool? x =
        await InAppWebViewController.setSafeBrowsingAllowlist(hosts: [url]);
    logger.w("setSafeBrowsingAllowlist :$x");
    String? navUrl = (await webController?.getUrl())?.toString();
    if (navUrl?.endsWith("/") == true) {
      navUrl = navUrl?.substring(0, navUrl.length - 1);
    }
    final miniAppBaseUrl = Uri.encodeFull(url);
    // logger.d(navUrl);
    // logger.d(miniAppBaseUrl);
    // bool inHomeOfMiniAppUrl = navUrl?.split('/').last == appUrl.split('/').last;
    bool isInHomeOfMiniApp = await webController?.canGoBack() == false;
    // logger.i(isInHomeOfMiniApp);
    bool canBackWithGet =
        isInHomeOfMiniApp || navUrl == null || navUrl == miniAppBaseUrl;

    if (canBackWithGet) {
      if (byDeviceBackButton) {
        return true;
      }
      // Get.back();
      return true;
    } else {
      webController?.goBack();
      return false;
    }
  }

  void toastMessage(param0) {}
}