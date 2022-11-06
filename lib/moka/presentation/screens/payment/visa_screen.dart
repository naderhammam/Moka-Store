import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moka_store/core/network/api_constance.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../config/locale/app_localizations.dart';
import '../../../../config/shared/component.dart';
import '../../../../core/utils/color_manager.dart';
import '../../../../core/utils/icons_manager.dart';
import '../../../../core/utils/strings_manager.dart';
import '../../../../core/utils/values_manager.dart';

final Completer<WebViewController> _controller = Completer<WebViewController>();

class VisaScreen extends StatelessWidget {
  const VisaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${ApiConstance.FRAME_URL}${ApiConstance.PAYMENT_FINAL_TOKEN_VISA}');
    return WillPopScope(
      onWillPop: () {
        backToHome(context, AppStrings.backToHomeBase);
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
                AppLocalizations.of(context)!.translate('payment_by_card')!,
                style: TextStyle(color: Colors.black)),
            backgroundColor: AppColor.paymobBackGround,
            leading: IconButton(
                onPressed: () {
                  backToHome(context, AppStrings.backToHomeBase);
                },
                icon: const Icon(Icons.arrow_back_ios,
                    size: AppSize.s24, color: Colors.black)),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  right: AppPadding.p4,
                ),
                child: IconButton(
                    onPressed: () {
                      backToHome(context, AppStrings.backToHomeVisa);
                    },
                    icon: const Icon(IconBroken.Home, color: Colors.black)),
              )
            ],
          ),
          body: WebView(
            initialUrl:
                '${ApiConstance.FRAME_URL}${ApiConstance.PAYMENT_FINAL_TOKEN_VISA}',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
            onProgress: (int progress) {},
            javascriptChannels: <JavascriptChannel>{
              _toasterJavascriptChannel(context),
            },
            backgroundColor: const Color(0x00000000),
          ),
        ),
      ),
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
