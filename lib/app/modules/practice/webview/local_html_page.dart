import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:webview_flutter/webview_flutter.dart';

class LocalHtmlPage extends StatefulWidget {
  const LocalHtmlPage({super.key});

  @override
  State<LocalHtmlPage> createState() => _LocalHtmlPageState();
}

class _LocalHtmlPageState extends State<LocalHtmlPage> {
  late WebViewController _controller;

  /// 跳转到 IM
  void _jump2IM(JavaScriptMessage message) {
    // jumpToConversationPage();
    print(message.message);
  }

  void _initWebController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'jumpToIM',
        onMessageReceived: _jump2IM,
      );
    _loadHtmlFromAssets();
  }

  @override
  void initState() {
    super.initState();
    _initWebController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('H5 ↔ Flutter 通信')),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }

  Future<void> _loadHtmlFromAssets() async {
    final String fileHtmlContents =
        await rootBundle.loadString('assets/html/local.html');
    await _controller.loadHtmlString(fileHtmlContents);
  }
}
