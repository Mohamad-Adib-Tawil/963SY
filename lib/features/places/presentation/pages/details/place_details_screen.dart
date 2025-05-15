import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';
import 'package:untitled4/models/governorate_m.dart';
import 'package:untitled4/screens/info_screen.dart';
import 'package:untitled4/screens/photos_screen.dart';
import 'package:untitled4/screens/youtube_player_screen.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:untitled4/navigation/app_router.dart';
import 'package:untitled4/navigation/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatelessWidget {
  final TouristPlace place;

  const PlaceDetailsScreen({super.key, required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(),
      body: _buildBody(context),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => NavigationService.navigateToGovernorates(
          place.tourismType,
          languageId: 1,
          categoryId: 1,
        ),
      ),
      title: RTLText(
        text: place.name,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildPlaceImage(),
          _buildPlaceInfo(),
          const SizedBox(height: 10),
          _buildFeatureGrid(context),
        ],
      ),
    );
  }

  Widget _buildPlaceImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: Image.asset(
        place.images[0],
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildPlaceInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RTLText(
            text: place.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          RTLText(
            text: place.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary.withOpacity(0.7),
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _buildFeatureItems(context).length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) => _buildFeatureItems(context)[index],
      ),
    );
  }

  List<Widget> _buildFeatureItems(BuildContext context) {
    return [
      _FeatureItem(
        imagePath: 'assets/images/info-removebg-preview (1).png',
        label: 'المعلومات',
        onTap: () => _navigateToScreen(context, InfoScreen(place: place)),
      ),
      _FeatureItem(
        imagePath: 'assets/images/photo-removebg-preview (1).png',
        label: 'الصور',
        onTap: () => _navigateToScreen(context, PhotosScreen(place: place)),
      ),
      _FeatureItem(
        imagePath: 'assets/images/virtual-removebg-preview (1).png',
        label: 'جولة افتراضية',
        onTap: () => Navigator.pushNamed(context, AppRouter.virtualTour),
      ),
      _FeatureItem(
        imagePath: 'assets/images/goto-removebg-preview (1).png',
        label: 'توجه للمكان',
        onTap: () async {
          final url =
              'https://www.google.com/maps/search/?api=1&query=${place.latitude},${place.longitude}';
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          } else {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لا يمكن فتح خرائط جوجل'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        },
      ),
      _FeatureItem(
        imagePath: 'assets/images/video-removebg-preview (1).png',
        label: 'مقاطع الوسائط',
        onTap: () {
          if (place.VideoUrl.isNotEmpty) {
            final videoId = _extractVideoId(place.VideoUrl);
            if (videoId.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => YouTubePlayerScreen(
                    videoId: videoId,
                    title: 'مقطع فيديو',
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('الرابط غير صالح'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('لا يوجد فيديو متاح'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
      ),
      _FeatureItem(
        imagePath: 'assets/images/signlanguage-removebg-preview (1).png',
        label: 'لغة الإشارة',
        onTap: () {
          if (place.signLanguageVideoUrl.isNotEmpty) {
            final videoId = _extractVideoId(place.signLanguageVideoUrl);
            if (videoId.isNotEmpty) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => YouTubePlayerScreen(
                    videoId: videoId,
                    title: 'فيديو بلغة الإشارة',
                  ),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('الرابط غير صالح'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('لا يوجد فيديو لغة إشارة متاح'),
                backgroundColor: Colors.orange,
              ),
            );
          }
        },
      ),
    ];
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    NavigationService.navigateTo('/details', arguments: screen);
  }

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
}

class _FeatureItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  const _FeatureItem({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 2,
        shadowColor: Colors.black12,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: 48,
                height: 48,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              RTLText(
                text: label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
