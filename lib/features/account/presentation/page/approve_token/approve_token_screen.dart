import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ApproveTokenScreen extends StatefulWidget {
  String token;

  ApproveTokenScreen({super.key, required this.token});

  @override
  State<ApproveTokenScreen> createState() => _ApproveTokenScreenState();
}

class _ApproveTokenScreenState extends State<ApproveTokenScreen> {
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.themoviedb.org/authenticate/${widget.token}'))
      ..setNavigationDelegate(NavigationDelegate(
        onPageFinished: (String url) {
          if (url.contains('allow')) {
            Navigator.pop(context, true);
          }
        }
      ));
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewWidget(controller: _controller),
    );
  }
}
