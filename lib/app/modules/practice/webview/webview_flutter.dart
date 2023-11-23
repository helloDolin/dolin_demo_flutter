import 'package:dolin/app/modules/practice/my_provider_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewFlutter extends StatelessWidget {
  const WebviewFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WebviewFlutter'),
      ),
      body: const SafeArea(
        child: MyWebView(),
      ),
    );
  }
}

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  late final WebViewController controller;
  double height = 0;
  @override
  void initState() {
    controller = WebViewController()
      ..addJavaScriptChannel(
        'CallFlutter',
        onMessageReceived: (JavaScriptMessage obj) {
          debugPrint(obj.message);
          Get.to<void>(() => const MyProviderPage());
        },
      )
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 允许 js
      ..loadRequest(
        Uri.parse(
          'file:///Users/bd/Desktop/dolin_demo_flutter/lib/app/modules/practice/webview/local_html.html',
        ),
      );

    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          child: const Text('call js'),
          onPressed: () {
            controller.runJavaScript('setTimeout(function() {callJS()}, 500);');
          },
        ),
        Expanded(child: WebViewWidget(controller: controller)),
      ],
    );
  }
}
