import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';
import 'package:photo_view/photo_view.dart';
import 'package:untitled4/models/media.dart';
import 'package:untitled4/models/place_model.dart';

class PhotosScreen extends StatefulWidget {
  final Place place;
  final List<Media> photos;
  static const int photoCount = 5;

  const PhotosScreen({super.key, required this.place, required this.photos});

  @override
  State<PhotosScreen> createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundWhite,
        appBar: _buildAppBar(),
        body: Column(
          children: [
            _buildFeaturedPhoto(widget.photos),
            Expanded(
              child: _buildPhotoGrid(widget.photos),
            ),
          ],
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text(
        'معرض الصور',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildFeaturedPhoto(List<Media> media) {
    return GestureDetector(
      onTap: () => _showFullScreenImage(0, media),
      child: Container(
        height: 250,
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: CachedNetworkImage(
            imageUrl: widget.place.photo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoGrid(List<Media> media) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),
      itemCount: media.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _showFullScreenImage(index, media),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    media[index].medContent!,
                    fit: BoxFit.cover,
                  ),
                  if (index == _selectedIndex)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.primary,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showFullScreenImage(int index, List<Media> media) {
    setState(() {
      _selectedIndex = index;
    });

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            PhotoView(
              imageProvider: NetworkImage(media[index].medContent!),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              backgroundDecoration: const BoxDecoration(
                color: Colors.transparent,
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
