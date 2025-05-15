import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';
import 'package:untitled4/models/governorate_m.dart';
import 'package:untitled4/features/places/presentation/pages/details/place_details_screen.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/navigation/navigation_service.dart';

class TouristPlacesScreen extends StatelessWidget {
  final Governorate governorate;
  final String tourismType;
  static const double imageHeight = 120.0;
  static const double cardBorderRadius = 16.0;
  static const double cardElevation = 2.0;
  static const double contentPadding = 16.0;
  static const double verticalSpacing = 10.0;
  static const int descriptionMaxLines = 2;

  const TouristPlacesScreen({
    super.key,
    required this.governorate,
    required this.tourismType,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
        // backgroundColor: AppColors.backgroundLight,
        // appBar: _buildAppBar(context, l10n),
        // body: _buildBody(context),
        );
  }

  // PreferredSizeWidget _buildAppBar(
  //     BuildContext context, AppLocalizations l10n) {
  //   return AppBar(
  //     automaticallyImplyLeading: false,
  //     flexibleSpace: _buildAppBarBackground(),
  //     centerTitle: true,
  //     title: RTLText(
  //       text: '${l10n.tourismSites} ${governorate.name}',
  //       style: const TextStyle(
  //         fontSize: 22,
  //         fontWeight: FontWeight.bold,
  //         color: Colors.white,
  //         letterSpacing: 1,
  //       ),
  //     ),
  //     elevation: 0,
  //   );
  // }

  // Widget _buildAppBarBackground() {
  //   return Container(
  //     decoration: BoxDecoration(
  //       gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [
  //           AppColors.primary,
  //           AppColors.primary.withOpacity(0.9),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBody(BuildContext context) {
  //   return ListView.builder(
  //     padding: const EdgeInsets.all(contentPadding),
  //     itemCount: governorate.places.length,
  //     itemBuilder: (context, index) => _buildPlaceCard(context, index)
  //         .animate()
  //         .fadeIn(duration: 600.ms)
  //         .slideY(
  //           begin: 0.3,
  //           end: 0,
  //           delay: (index * 200).ms,
  //           duration: 600.ms,
  //         ),
  //   );
  // }

  // Widget _buildPlaceCard(BuildContext context, int index) {
  //   final place = governorate.places[index];
  //   return Card(
  //     shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.circular(cardBorderRadius),
  //       side: BorderSide(
  //         color: AppColors.primary.withOpacity(0.1),
  //         width: 1,
  //       ),
  //     ),
  //     margin: const EdgeInsets.only(bottom: contentPadding),
  //     elevation: cardElevation,
  //     color: AppColors.backgroundWhite,
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         _buildPlaceImage(place),
  //         _buildPlaceContent(context, place),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPlaceImage(TouristPlace place) {
  //   return ClipRRect(
  //     borderRadius:
  //         const BorderRadius.vertical(top: Radius.circular(cardBorderRadius)),
  //     child: Stack(
  //       children: [
  //         Image.asset(
  //           place.images[0],
  //           height: imageHeight,
  //           width: double.infinity,
  //           fit: BoxFit.cover,
  //           errorBuilder: (context, error, stackTrace) {
  //             return Container(
  //               height: imageHeight,
  //               color: Colors.grey[300],
  //               child: const Center(
  //                 child: Icon(
  //                   Icons.error_outline,
  //                   color: Colors.grey,
  //                   size: 40,
  //                 ),
  //               ),
  //             );
  //           },
  //         ),
  //         Positioned(
  //           top: 8,
  //           right: 8,
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
  //             decoration: BoxDecoration(
  //               color: AppColors.primary.withOpacity(0.8),
  //               borderRadius: BorderRadius.circular(8),
  //             ),
  //             child: RTLText(
  //               text: tourismType,
  //               style: const TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 12,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPlaceContent(BuildContext context, TouristPlace place) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(
  //         horizontal: contentPadding, vertical: verticalSpacing),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         _buildPlaceName(place),
  //         const SizedBox(height: verticalSpacing / 2),
  //         _buildPlaceDescription(place),
  //         const SizedBox(height: verticalSpacing),
  //         _buildDetailsButton(context, place),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildPlaceName(TouristPlace place) {
  //   return RTLText(
  //     text: place.name,
  //     style: const TextStyle(
  //       fontSize: 18,
  //       fontWeight: FontWeight.bold,
  //       color: AppColors.textPrimary,
  //     ),
  //   );
  // }

  // Widget _buildPlaceDescription(TouristPlace place) {
  //   final firstLine = place.description.split(RegExp(r'\r?\n')).first.trim();
  //   return RTLText(
  //     text: firstLine,
  //     maxLines: 1,
  //     overflow: TextOverflow.ellipsis,
  //     style: TextStyle(
  //       fontSize: 14,
  //       color: AppColors.textPrimary.withOpacity(0.7),
  //       height: 1.5,
  //     ),
  //   );
  // }

  // Widget _buildDetailsButton(BuildContext context, TouristPlace place) {
  //   final l10n = AppLocalizations.of(context)!;
  //   return ElevatedButton.icon(
  //     onPressed: () => _navigateToPlaceDetails(context, place),
  //     icon: const Icon(Icons.info_outline, size: 18),
  //     label: RTLText(
  //       text: l10n.readMore,
  //       style: const TextStyle(fontSize: 14),
  //     ),
  //     style: ElevatedButton.styleFrom(
  //       foregroundColor: Colors.white,
  //       backgroundColor: AppColors.primary,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  //       elevation: 0,
  //     ),
  //   );
}

  // void _navigateToPlaceDetails(BuildContext context, TouristPlace place) {
  //   NavigationService.navigateTo('/details',
  //       arguments: PlaceDetailsScreen(place: place));
  // }
//}
