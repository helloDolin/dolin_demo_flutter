import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebView extends StatefulWidget {
  const WebView({super.key});

  @override
  State<WebView> createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  bool _showLoading = true;
  String _title = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_title),
      ),
      body: Column(
        children: [
          _showLoading
              ? const LinearProgressIndicator()
              : const SizedBox.shrink(),
          Expanded(
            child: InAppWebView(
              onTitleChanged: (controller, title) {
                setState(() {
                  _title = title ?? '';
                });
              },
              initialUrlRequest:
                  URLRequest(url: Uri.parse('https://github.com/helloDolin')),
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                if (progress == 100) {
                  setState(() {
                    _showLoading = false;
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
