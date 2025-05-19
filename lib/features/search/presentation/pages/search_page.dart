import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/core/widgets/base_screen.dart';
import 'package:untitled4/const.dart' as app_const;
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/features/map/presentation/pages/syria_map_page.dart';
import 'package:untitled4/features/search/cubit/search_cubit_cubit.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled4/models/place_model.dart';

class SearchPage extends BaseScreen {
  const SearchPage({super.key}) : super(navigationIndex: 1);

  @override
  State<BaseScreen> createState() => _SearchPageState();
}

class _SearchPageState extends BaseScreenState<SearchPage> {
  @override
  Widget buildBody(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<SearchCubit, SearchCubitState>(
      listener: (context, state) {
        if (state is SearchCubitSuccess) {
          log('---Cubit:${state.places.toString()}');
        }
      },
      builder: (context, state) {
        return Directionality(
          textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
          child: Scaffold(
            backgroundColor: AppColors.backgroundLight,
            appBar: AppBar(
              backgroundColor: app_const.AppColors.primary,
              elevation: 0,
              title: isArabic
                  ? RTLText(
                      text: l10n.search,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    )
                  : Text(
                      l10n.search,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: app_const.AppColors.primary,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(30),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: l10n.searchHint,
                        hintStyle: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 16,
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.primary,
                          size: 24,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.filter_list,
                            color: AppColors.primary,
                          ),
                          onPressed: () {},
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) {
                        debugPrint("Searching for: $value");
                        context.read<SearchCubit>().search(value);
                      },
                    ),
                  ),
                ).animate().fadeIn(duration: 500.ms),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: state is SearchCubitLoding
                        ? const Center(child: CircularProgressIndicator())
                        : state is SearchCubitSuccess
                            ? ListView.builder(
                                itemCount: state.places.length,
                                itemBuilder: (context, index) =>
                                    _buildPlaceCard(
                                        context, state.places[index]),
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    l10n.findPlaces,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ).animate().fadeIn(delay: 200.ms),
                                  const SizedBox(height: 20),
                                  Expanded(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.search_off_rounded,
                                            size: 100,
                                            color: Colors.grey[400],
                                          ).animate().scale(delay: 400.ms),
                                          const SizedBox(height: 16),
                                          Text(
                                            l10n.searchResults,
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.grey[600],
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ).animate().fadeIn(delay: 600.ms),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceCard(BuildContext context, Place place) {
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';

    return GestureDetector(
      onTap: () {
        // NavigationService.navigateTo('/details',
        //     arguments: PlaceDetailsScreen(place: place));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.only(bottom: 16),
        elevation: 4,
        shadowColor: AppColors.primary.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                place.photo,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RTLText(
                    text: place.placeName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
