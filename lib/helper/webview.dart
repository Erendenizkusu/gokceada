import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewComponent extends StatefulWidget {
  const WebViewComponent({super.key,required this.url, required this.title});
  final String url;
  final String title;

  @override
  State<WebViewComponent> createState() => _WebViewComponentState();
}

class _WebViewComponentState extends State<WebViewComponent> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.disabled)
      ..loadRequest(Uri.parse(widget.url));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: WebViewWidget(
        controller: controller,
      ),
    );
  }
}
