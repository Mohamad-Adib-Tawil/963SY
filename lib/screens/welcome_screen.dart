import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:untitled4/navigation/app_router.dart';
import 'package:untitled4/core/constants/app_colors.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    _controller = VideoPlayerController.asset('assets/video/4.mp4');

    try {
      await _controller.initialize();
      await _controller.setLooping(false);
      await _controller.play();

      if (mounted) {
        setState(() {
          _isVideoInitialized = true;
        });
      }

      // Listen for video completion
      _controller.addListener(() {
        if (_controller.value.position >= _controller.value.duration) {
          // Navigate to home screen when video ends
          Navigator.pushReplacementNamed(context, AppRouter.home);
        }
      });
    } catch (e) {
      print('Error initializing video: $e');
      // If video fails to load, navigate to home screen
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.home);
      }
    }
  }

  void _skipVideo() {
    _controller.pause();
    Navigator.pushReplacementNamed(context, AppRouter.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: _isVideoInitialized
                ? SizedBox.expand(
                    child: FittedBox(
                      fit: BoxFit.cover,
                      child: SizedBox(
                        width: _controller.value.size.width,
                        height: _controller.value.size.height,
                        child: VideoPlayer(_controller),
                      ),
                    ),
                  )
                : const CircularProgressIndicator(
                    color: Colors.white,
                  ),
          ),
          // Skip button
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: TextButton(
              onPressed: _skipVideo,
              style: TextButton.styleFrom(
                backgroundColor: Colors.black.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
