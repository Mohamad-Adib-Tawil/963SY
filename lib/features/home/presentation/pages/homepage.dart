import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled4/const.dart' as app_const;
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/features/home/cubit/language_cubit.dart';
import 'package:untitled4/features/home/cubit/slider_cubit.dart';
import 'package:untitled4/features/home/home_cubit/home_cubit.dart';
import 'package:untitled4/features/places/presentation/pages/details/place_details_screen.dart';
import 'package:untitled4/features/services/cubit/city_cubit.dart';
import 'package:untitled4/navigation/navigation_service.dart';

import 'package:untitled4/widgets/category.dart';
import 'package:untitled4/core/widgets/base_screen.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/providers/language_provider.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/home/bloc/home_bloc.dart';
import 'package:untitled4/widgets/common/shimmer_effect/slider_shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class DirectionalText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final bool isArabic;

  const DirectionalText({
    super.key,
    required this.text,
    this.style,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return isArabic
        ? RTLText(text: text, style: style)
        : Text(text, style: style);
  }
}

class Homepage extends BaseScreen {
  const Homepage({super.key}) : super(navigationIndex: 2);

  @override
  State<BaseScreen> createState() => _HomepageState();
}

class _HomepageState extends BaseScreenState<Homepage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeStarted());
  }

  Future<bool> _onWillPop() async {
    exit(0);
    return false;
  }

  String getTourismType(String title, BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (isArabic) {
      if (title == 'المواقع السياحية') return 'سياحي';
      if (title == 'المواقع التاريخية') return 'تاريخي';
      if (title == 'المواقع الدينية') return 'ديني';
    } else {
      if (title == 'Tourism Sites') return 'سياحي';
      if (title == 'Historical Sites') return 'تاريخي';
      if (title == 'Religious Sites') return 'ديني';
    }
    return '';
  }

  Widget _buildSocialMediaIconOnly({
    required IconData icon,
    required String url,
    required int index,
  }) {
    return InkWell(
      onTap: () => _launchURL(url),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.backgroundWhite,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: AppColors.primary,
          size: 26,
        ),
      ),
    ).animate().fadeIn(duration: 600.ms).slideX(
      begin: 0.3,
      end: 0,
      delay: (index * 200).ms,
      duration: 600.ms,
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('لا يمكن فتح الرابط')),
        );
      }
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    final isArabic =
        context.watch<LanguageProvider>().currentLocale.languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: app_const.AppColors.primary,
                  ),
                  const SizedBox(height: 16),
                  DirectionalText(
                    text: l10n.offlineDescription,
                    isArabic: isArabic,
                    style: const TextStyle(
                      fontSize: 16,
                      color: app_const.AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () {
                      context.read<HomeBloc>().add(HomeStarted());
                      context.read<HomeCubit>().getCategories();
                      context.read<LanguageCubit>().getLanguages();
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(l10n.retry),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: app_const.AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is HomeLoaded) {
          log(state.categories.length.toString());
          final visibleCategories = state.categories
              .where((category) => category.catType < 3)
              .toList();
          return WillPopScope(
            onWillPop: _onWillPop,
            child: Directionality(
              textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
              child: BlocListener<HomeCubit, HomeCubitState>(
                listener: (context, homeState) {
                  if (homeState is HomeCubitSuccess) {
                    int sliderId = homeState.categories
                        .firstWhere((element) => element.catType == 3,
                        orElse: () => homeState.categories[0])
                        .id;
                    context.read<SliderCubit>().getSliderImages(sliderId);
                    log(homeState.categories.length.toString());
                  }
                },
                child: Scaffold(
                  backgroundColor: app_const.AppColors.backgroundLight,
                  appBar: AppBar(
                    automaticallyImplyLeading: false,
                    backgroundColor: app_const.AppColors.primary,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DirectionalText(
                          text: l10n.appTitle,
                          isArabic: isArabic,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        BlocBuilder<LanguageCubit, LanguageState>(
                          builder: (context, state) {
                            if (state is LanguageSucces &&
                                state.languages.isNotEmpty) {
                              return PopupMenuButton<String>(
                                  icon: const Icon(Icons.language,
                                      color: Colors.white),
                                  onSelected: (value) async {
                                    final languageId = state.languages
                                        .firstWhere((e) => e.code == value)
                                        .id!;
                                    context
                                        .read<HomeBloc>()
                                        .add(HomeLanguageChanged(languageId));
                                    await context
                                        .read<LanguageProvider>()
                                        .changeLanguage(value);
                                    context.read<HomeCubit>().getCategories();
                                  },
                                  itemBuilder: (context) {
                                    return state.languages.map((language) {
                                      return PopupMenuItem(
                                        value: language.code,
                                        child: RTLText(
                                          text: language.name!,
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                      );
                                    }).toList() as List<PopupMenuEntry<String>>;
                                  });
                            } else if (state is LanguageFailuer) {
                              return Text(l10n.error);
                            } else {
                              return const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    color: AppColors.backgroundLight,
                                  ));
                            }
                          },
                        ),
                      ],
                    ),
                    elevation: 0,
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        SizedBox(
                          height: 180,
                          child: BlocBuilder<SliderCubit, SliderState>(
                            builder: (context, sliderState) {
                              if (sliderState is SliderSuccess &&
                                  sliderState.sliderItems.isNotEmpty) {
                                return CarouselSlider(
                                  options: CarouselOptions(
                                    height: 160.0,
                                    autoPlay: true,
                                    enlargeCenterPage: true,
                                    onPageChanged: (index, reason) {
                                      context
                                          .read<HomeBloc>()
                                          .add(HomeSliderChanged(index));
                                    },
                                  ),
                                  items:
                                  sliderState.sliderItems.map((imagePath) {
                                    return Builder(
                                      builder: (BuildContext context) {
                                        return GestureDetector(
                                            onTap: () {
                                              NavigationService.navigateTo(
                                                  '/details',
                                                  arguments: PlaceDetailsScreen(
                                                      place: imagePath));
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                              BorderRadius.circular(16),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(16),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image:
                                                    CachedNetworkImageProvider(
                                                      imagePath.photo,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ));
                                      },
                                    );
                                  }).toList(),
                                );
                              } else if (sliderState is SliderSuccess &&
                                  sliderState.sliderItems.isEmpty) {
                                return Center(child: Text(l10n.error));
                              } else if (sliderState is SliderFailuer) {
                                return Center(
                                    child: Text(sliderState.errorMessage));
                              } else {
                                return const SliderShimmer();
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:
                          List.generate(state.sliderImages.length, (index) {
                            bool isActive = state.currentSliderIndex == index;
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              width: isActive ? 12 : 8,
                              height: isActive ? 12 : 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isActive
                                    ? app_const.AppColors.secondary
                                    : Colors.grey[300],
                              ),
                            );
                          }),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Directionality(
                            textDirection: isArabic
                                ? TextDirection.rtl
                                : TextDirection.ltr,
                            child: Column(
                              crossAxisAlignment: isArabic
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: double.infinity,
                                  alignment: isArabic
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: DirectionalText(
                                    text: l10n.tourismSites,
                                    isArabic: isArabic,
                                    style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: app_const.AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Container(
                                  width: double.infinity,
                                  alignment: isArabic
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: DirectionalText(
                                    text: l10n.searchHint,
                                    isArabic: isArabic,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 8,
                                    mainAxisSpacing: 8,
                                    childAspectRatio: 1,
                                  ),
                                  itemCount: visibleCategories.length,
                                  itemBuilder: (context, index) {
                                    final category = visibleCategories[index];

                                    return Category_Card(
                                      category: category,
                                      onTap: () {
                                        log('Category tapped: $category');
                                        final categoryType = getTourismType(
                                            category.catName, context);
                                        // context.read<HomeBloc>().add(
                                        //       HomeCategorySelected(
                                        //         categoryTitle: category.catName,
                                        //         categoryType: categoryType,
                                        //       ),
                                        //     );

                                        if (category.catType == 2) {
                                          context
                                              .read<CityCubit>()
                                              .getServiceCities(category.id);
                                          NavigationService.navigateToServices(
                                              category: category);
                                        } else {
                                          NavigationService
                                              .navigateToGovernorates(
                                            title: category.catName,
                                            categoryType,
                                            languageId: state.languageId,
                                            categoryId: category.id,
                                          );
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildSocialMediaIconOnly(
                              icon: FontAwesomeIcons.globe,
                              url: 'https://963sy.net',
                              index: 0,
                            ),
                            _buildSocialMediaIconOnly(
                              icon: FontAwesomeIcons.facebook,
                              url:
                              'https://www.facebook.com/share/12J86eBRuZK/',
                              index: 1,
                            ),
                            _buildSocialMediaIconOnly(
                              icon: FontAwesomeIcons.instagram,
                              url:
                              'https://www.instagram.com/963sy.app?igsh=eWV3bTkzZW14cjA=',
                              index: 2,
                            ),
                            _buildSocialMediaIconOnly(
                              icon: FontAwesomeIcons.youtube,
                              url:
                              'https://youtube.com/@963syapp?si=KpjVYAYEwy8oekRR',
                              index: 3,
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
