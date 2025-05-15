import 'package:flutter/material.dart';
import 'package:untitled4/models/governorate_m.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/screens/youtube_player_screen.dart';

class SignLanguageScreen extends StatelessWidget {
  final TouristPlace place;
  static const String signLanguageText = 'اضغط هنا لمشاهدة فيديو بلغة الإشارة';

  const SignLanguageScreen({super.key, required this.place});

  String _extractVideoId(String url) {
    url = url.split('?')[0];
    if (url.contains('youtu.be/')) {
      return url.split('youtu.be/')[1];
    } else if (url.contains('youtube.com/shorts/')) {
      return url.split('shorts/')[1];
    } else if (url.contains('youtube.com/watch?v=')) {
      return url.split('watch?v=')[1];
    }
    return '';
  }

  void _openVideo(BuildContext context, String url, String title) {
    final videoId = _extractVideoId(url);
    if (videoId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('الرابط غير صالح'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => YouTubePlayerScreen(videoId: videoId, title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لغة الإشارة', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        centerTitle: true,
      ),
      body: Center(
        child: GestureDetector(
          onTap: () {
            final url = place.signLanguageVideoUrl;
            if (url.isNotEmpty) {
              _openVideo(context, url, 'فيديو بلغة الإشارة');
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لا يوجد فيديو لغة إشارة متاح'),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primary.withOpacity(0.3)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.play_circle_outline,
                    color: AppColors.primary, size: 24),
                SizedBox(width: 8),
                Text(
                  signLanguageText,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
