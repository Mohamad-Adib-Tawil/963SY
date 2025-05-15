import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class YouTubeWebViewScreen extends StatelessWidget {
  final String videoId;

  const YouTubeWebViewScreen({super.key, required this.videoId});

  @override
  Widget build(BuildContext context) {
    final videoUrl = 'https://www.youtube.com/embed/$videoId';

    return Scaffold(
      appBar: AppBar(
        title: const Text('مشاهدة الفيديو'),
        backgroundColor: Colors.red,
      ),
      body: WebViewWidget(
        controller: WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..loadRequest(Uri.parse(videoUrl)),
      ),
    );
  }
}
