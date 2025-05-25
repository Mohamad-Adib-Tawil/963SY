import 'package:flutter/material.dart';
import 'package:untitled4/models/place_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final Place place;
  final String youtubeLink;

  const YouTubePlayerScreen({
    super.key,
    required this.place,
    required this.youtubeLink,
  });

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late final WebViewController _controller;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    String videoId = extractYouTubeVideoId(widget.youtubeLink);
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://www.youtube.com/embed/$videoId',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: RTLText(
          text: widget.place.placeName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: WebViewWidget(controller: _controller),
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }

  String extractYouTubeVideoId(String url) {
    try {
      Uri uri = Uri.parse(url);
      if (uri.host.contains('youtu.be')) {
        return uri.pathSegments.first;
      }
      if ((uri.host.contains('youtube.com') ||
              uri.host.contains('m.youtube.com')) &&
          uri.path == '/watch') {
        return uri.queryParameters['v'] ?? '';
      }
      if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'shorts') {
        return uri.pathSegments[1];
      }
      if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
        return uri.pathSegments[1];
      }
      if (uri.queryParameters.containsKey('u')) {
        final embeddedUri =
            Uri.parse(Uri.decodeFull(uri.queryParameters['u']!));
        return extractYouTubeVideoId(embeddedUri.toString());
      }
    } catch (e) {}

    return '';
  }
}
