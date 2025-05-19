import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/places/cubit/place_details_cubit.dart';
import 'package:untitled4/models/link.dart';
import 'package:untitled4/models/place_model.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';

class YouTubePlayerScreen extends StatefulWidget {
  final Place place;

  const YouTubePlayerScreen({
    super.key,
    required this.place,
  });

  @override
  State<YouTubePlayerScreen> createState() => _YouTubePlayerScreenState();
}

class _YouTubePlayerScreenState extends State<YouTubePlayerScreen> {
  late final WebViewController _controller;
  String? videoUrl;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {});
          },
          onPageFinished: (String url) {
            setState(() {});
          },
        ),
      );
  }

  void _loadVideo(String url) {
    setState(() {
      videoUrl = url;
    });
    _controller.loadRequest(Uri.parse(url));
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
      body: BlocConsumer<PlaceDetailsCubit, PlaceDetailsState>(
        listener: (context, state) {
          if (state is PlaceDetailsSuccess) {
            // افترض أن الفيديو ID جاي من الداتا هيك:
            final links = state.data as List<Link>;
            final youtubeLink = links.firstWhere(
              (link) => link.linkType == 2 && link.linkHttp != null,
              orElse: () => Link(linkHttp: null, linkType: 0),
            );
            if (youtubeLink.linkHttp != null) {
              final embedUrl = convertToEmbedUrl(youtubeLink.linkHttp!);
              log('Link : ${youtubeLink.linkHttp}');
              _loadVideo(embedUrl);
            }
          }
        },
        builder: (context, state) {
          if (state is PlaceDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PlaceDetailsSuccess) {
            return Stack(
              children: [
                Center(
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: WebViewWidget(controller: _controller),
                  ),
                ),
              ],
            );
          }
          return const Center(child: Text('Something went wrong'));
        },
      ),
    );
  }

  String convertToEmbedUrl(String url) {
    final uri = Uri.parse(url);
    if (uri.host.contains('youtube.com') && uri.queryParameters['v'] != null) {
      final videoId = uri.queryParameters['v']!;
      return 'https://www.youtube.com/embed/$videoId';
    }
    return url;
  }
}
