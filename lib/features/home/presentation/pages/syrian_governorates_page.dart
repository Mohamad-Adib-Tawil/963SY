import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';
import 'package:untitled4/core/services/get_it_service.dart';
import 'package:untitled4/features/home/places_cubit/places_cubit_cubit.dart';
import 'package:untitled4/features/home/repos/home_repo.dart';
import 'package:untitled4/models/governorate_m.dart';
import 'package:untitled4/features/places/presentation/pages/details/place_details_screen.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/features/places/bloc/places_bloc.dart';
import 'package:untitled4/models/place_model.dart';
import 'package:untitled4/navigation/navigation_service.dart';

class SyrianGovernoratesTabs extends StatelessWidget {
  final VoidCallback? onBack;
  final String tourismType;
  final int languageId;
  final int categoryId;
  const SyrianGovernoratesTabs({
    super.key,
    this.onBack,
    required this.tourismType,
    required this.languageId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PlacesBloc()
        ..add(LoadPlaces(
            tourismType: tourismType,
            languageId: languageId,
            categoryId: categoryId)),
      child: BlocProvider(
        create: (context) => PlacesCubitCubit(getIt<HomeRepo>()),
        child: _SyrianGovernoratesTabsContent(
          onBack:
              onBack ?? () => Navigator.pushReplacementNamed(context, '/home'),
          tourismType: tourismType,
          languageId: languageId,
          categoryId: categoryId,
        ),
      ),
    );
  }
}

class _SyrianGovernoratesTabsContent extends StatelessWidget {
  final VoidCallback? onBack;
  final String tourismType;
  final int languageId;
  final int categoryId;

  const _SyrianGovernoratesTabsContent({
    required this.onBack,
    required this.tourismType,
    required this.languageId,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';

    return BlocBuilder<PlacesBloc, PlacesState>(
      builder: (context, state) {
        if (state is PlacesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PlacesError) {
          return Center(child: Text(state.message));
        }

        if (state is PlacesLoaded) {
          context
              .read<PlacesCubitCubit>()
              .getPlaces(categoryId, state.governorates[0].id);
          return DefaultTabController(
            length: state.governorates.length,
            child: Scaffold(
              appBar: AppBar(
                title: RTLText(
                  text: l10n.tourismSites,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                backgroundColor: AppColors.primary,
                elevation: 0,
                leading: onBack != null
                    ? IconButton(
                        icon: Icon(
                          isRTL ? Icons.arrow_forward : Icons.arrow_back,
                          color: Colors.white,
                        ),
                        onPressed: onBack,
                      )
                    : null,
              ),
              body: Column(
                children: [
                  Container(
                    height: 70,
                    alignment:
                        isRTL ? Alignment.centerRight : Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    color: Colors.white,
                    child: _CustomTabBar(governorates: state.governorates),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: AppColors.backgroundWhite,
                      ),
                      child: TabBarView(
                        children: state.governorates
                            .map((gov) => _buildGovernorateView(gov, context))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Center(child: Text('Something went wrong'));
      },
    );
  }

  Widget _buildGovernorateView(Governorate governorate, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<PlacesCubitCubit, PlacesCubitState>(
      builder: (context, state) {
        if (state is PlacesCubitLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is PlacesCubitSuccess) {
          log('___Cubit:*******PLACES : ${state.places.toString()}');
          return ListView.builder(
            
            padding: const EdgeInsets.all(16),
            itemCount: state.places.length,
            itemBuilder: (context, index) {
              return _buildPlaceCard(
                      context, governorate, state.places[index] )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideX(begin: 0.1, end: 0, duration: 500.ms);
            },
          );
        } else if (state is PlacesCubitFailuer) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }

  Widget _buildPlaceCard(
      BuildContext context, Governorate governorate, Place place) {
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
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RTLText(
                    text: place.placeName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
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

class _CustomTabBar extends StatefulWidget {
  final List<Governorate> governorates;

  const _CustomTabBar({required this.governorates});

  @override
  State<_CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<_CustomTabBar> {
  late TabController _controller;
  final ScrollController _scrollController = ScrollController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller = DefaultTabController.of(context);
    _controller.addListener(_handleTabChange);
  }

  void _handleTabChange() {
    if (mounted) {
      setState(() {});
      _scrollToSelectedTab();
    }
  }

  void _scrollToSelectedTab() {
    final selectedIndex = _controller.index;
    const itemWidth = 120.0;
    final screenWidth = MediaQuery.of(context).size.width;
    final scrollOffset =
        (selectedIndex * itemWidth) - (screenWidth / 2) + (itemWidth / 2);

    _scrollController.animateTo(
      scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTabChange);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: List.generate(widget.governorates.length, (index) {
          final bool selected = _controller.index == index;
          final governorate = widget.governorates[index];

          return GestureDetector(
            onTap: () {
              if (_controller.index != index) {
                _controller.animateTo(index);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 6),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.6),
                  width: selected ? 2 : 1,
                ),
                boxShadow: selected
                    ? [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: RTLText(
                text: governorate.name,
                style: TextStyle(
                  color: selected ? AppColors.primary : Colors.black,
                  fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  String _getLocalizedGovernorateName(String name, BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final normalizedName = name.toLowerCase().trim();

    switch (normalizedName) {
      case 'damascus':
      case 'دمشق':
        return l10n.damascus;
      case 'aleppo':
      case 'حلب':
        return l10n.aleppo;
      case 'homs':
      case 'حمص':
        return l10n.homs;
      case 'hama':
      case 'حماة':
        return l10n.hama;
      case 'latakia':
      case 'اللاذقية':
        return l10n.latakia;
      case 'tartus':
      case 'طرطوس':
        return l10n.tartus;
      case 'deir ezzor':
      case 'دير الزور':
        return l10n.deirEzzor;
      case 'raqqa':
      case 'الرقة':
        return l10n.raqqa;
      case 'hasakah':
      case 'الحسكة':
        return l10n.hasakah;
      case 'idlib':
      case 'إدلب':
        return l10n.idlib;
      case 'daraa':
      case 'درعا':
        return l10n.daraa;
      case 'sweida':
      case 'السويداء':
        return l10n.sweida;
      case 'quneitra':
      case 'القنيطرة':
        return l10n.quneitra;
      default:
        return name;
    }
  }
}
