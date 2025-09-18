import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled4/const.dart';
import 'package:untitled4/features/places/cubit/place_details_cubit.dart';
import 'package:untitled4/features/places/data/models/coordinates.dart';
import 'package:untitled4/models/link.dart';
import 'package:untitled4/l10n/app_localizations.dart';

import 'package:untitled4/models/media.dart';
import 'package:untitled4/models/place_model.dart';
import 'package:untitled4/screens/info_screen.dart';

import 'package:untitled4/screens/photos_screen.dart';
import 'package:untitled4/screens/virtual_tour_screen.dart';
import 'package:untitled4/screens/youtube_player_screen.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';

import 'package:untitled4/navigation/navigation_service.dart';
import 'package:url_launcher/url_launcher.dart';

class PlaceDetailsScreen extends StatefulWidget {
  final Place place;
  final bool? isServeice;
  const PlaceDetailsScreen({super.key, required this.place, this.isServeice});

  @override
  State<PlaceDetailsScreen> createState() => _PlaceDetailsScreenState();
}

class _PlaceDetailsScreenState extends State<PlaceDetailsScreen> {
  late String youtubeLink = '';
  late String virtualTourLink = '';
  late String signlanguageLink = '';
  late List<Media> photo = [];
  late List<Media> info = [];
  late Coordinates way = Coordinates(horizontal: '0.0', vertical: '0.0');
  @override
  void initState() {
    super.initState();
    final cubit = context.read<PlaceDetailsCubit>();
    cubit.getDetails(
      placeId: widget.place.id,
      cityId: widget.place.citiesIdcities,
      categoryId: widget.place.categoriesIdcategories,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(context),
      body: BlocConsumer<PlaceDetailsCubit, PlaceDetailsState>(
        listener: (context, state) {
          if (state is PlaceDetailsSuccess) {
            final media = state.placeDetailsModel.media;
            final links = state.placeDetailsModel.links;
            way = state.placeDetailsModel.coordinates;
            if (links.isNotEmpty) {
              youtubeLink =
                  links
                      .firstWhere(
                        (link) => link.linkType == 2 && link.linkHttp != null,
                        orElse: () => Link(linkHttp: ''),
                      )
                      .linkHttp ??
                  '';
              virtualTourLink =
                  links
                      .firstWhere(
                        (link) => link.linkType == 3 && link.linkHttp != null,
                        orElse: () => Link(linkHttp: ''),
                      )
                      .linkHttp ??
                  '';
              signlanguageLink =
                  links
                      .firstWhere(
                        (link) => link.linkType == 1 && link.linkHttp != null,
                        orElse: () => Link(linkHttp: ''),
                      )
                      .linkHttp ??
                  '';
            }

            photo = media.where((media) => media.medType == 1).toList();
            info = media.where((media) => media.medType == 2).toList();
          }
        },
        builder: (context, state) {
          if (state is PlaceDetailsLoading) {
            return const LinearProgressIndicator(
              color: AppColors.backgroundLight,
            );
          }
          if (state is PlaceDetailsError) {
            return Center(child: Text(state.errorMessage));
          }
          if (state is PlaceDetailsSuccess) {
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
          return Center(child: Text(l10n.somethingWentWrong));
        },
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      centerTitle: true,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: RTLText(
        text: widget.place.placeName,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPlaceImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: CachedNetworkImage(
        imageUrl: widget.place.photo,
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                height: 240,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
        errorWidget: (context, url, error) => const Icon(Icons.error),
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
            text: widget.place.placeName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          RTLText(
            text: widget.place.description,
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

  Future<String> fetchTextFileContent(String fileUrl) async {
    try {
      final response = await Dio().get(
        fileUrl,
        options: Options(
          responseType: ResponseType.plain,
        ), // Treat response as plain text
      );

      log(response.data.toString());

      return response.data.toString();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('some thing went wrong, try again later')),
      );
      return '';
    }
  }

  List<Widget> _buildFeatureItems(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      if (info.isNotEmpty)
        _FeatureItem(
          imagePath: 'assets/images/info-removebg-preview (1).png',
          label: l10n.information,
          onTap: () async {
            String text = await fetchTextFileContent(info[0].medContent!);
            if (text.isNotEmpty || text != '') {
              _navigateToScreen(
                context,
                InfoScreen(place: widget.place, info: text),
              );
            }
          },
        ),
      if (photo.isNotEmpty)
        _FeatureItem(
          imagePath: 'assets/images/photo-removebg-preview (1).png',
          label: l10n.photos,
          onTap: () {
            _navigateToScreen(
              context,
              PhotosScreen(photos: photo, place: widget.place),
            );
          },
        ),
      if (virtualTourLink.isNotEmpty || virtualTourLink != '')
        _FeatureItem(
          imagePath: 'assets/images/virtual-removebg-preview (1).png',
          label: l10n.virtualTour,
          onTap:
              () => _navigateToScreen(
                context,
                VirtualTourScreen(url: virtualTourLink),
              ),
        ),
      if (way.horizontal != '0' || way.vertical != '0')
        _FeatureItem(
          imagePath: 'assets/images/goto-removebg-preview (1).png',
          label: l10n.goToPlace,
          onTap: () async {
            String url =
                "https://www.google.com/maps/search/?api=1&query=${way.vertical},${way.horizontal}";
            final uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(l10n.cannotOpenGoogleMaps),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }
          },
        ),
      if (youtubeLink.isNotEmpty || youtubeLink != '')
        _FeatureItem(
          imagePath: 'assets/images/video-removebg-preview (1).png',
          label: l10n.mediaClips,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => YouTubePlayerScreen(
                      place: widget.place,
                      youtubeLink: youtubeLink,
                    ),
              ),
            );
          },
        ),
      if (signlanguageLink.isNotEmpty || signlanguageLink != '')
        _FeatureItem(
          imagePath:
              widget.isServeice != null
                  ? widget.isServeice!
                      ? 'assets/images/video-removebg-preview (1).png'
                      : 'assets/images/signlanguage-removebg-preview (1).png'
                  : 'assets/images/signlanguage-removebg-preview (1).png',
          label:
              widget.isServeice != null
                  ? widget.isServeice!
                      ? l10n.mediaClips
                      : l10n.signLanguage
                  : l10n.signLanguage,
          onTap: () {
            _navigateToScreen(
              context,
              YouTubePlayerScreen(
                place: widget.place,
                youtubeLink: signlanguageLink,
              ),
            );
          },
        ),
    ];
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    NavigationService.navigateTo('/details', arguments: screen);
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
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
