import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/navigation/app_router.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/navigation/navigation_service.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final l10n = AppLocalizations.of(context)!;

    return Directionality(
      textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: ConvexAppBar(
        backgroundColor: AppColors.backgroundWhite,
        color: AppColors.bottomBarInactive,
        activeColor: AppColors.secondary,
        initialActiveIndex: currentIndex,
        onTap: (int index) {
          switch (index) {
            case 0:
              NavigationService.navigateTo(AppRouter.about);
              break;
            case 1:
              NavigationService.navigateTo(AppRouter.search);
              break;
            case 2:
              NavigationService.navigateTo(AppRouter.home);
              break;
            case 3:
              NavigationService.navigateTo(AppRouter.map);
              break;
            case 4:
              NavigationService.navigateTo(AppRouter.contact);
              break;
          }
        },
        items: [
          TabItem(
            icon: Icons.info_outline,
            title: l10n.aboutUs,
          ),
          TabItem(
            icon: Icons.search,
            title: l10n.search,
          ),
          TabItem(
            icon: Icons.home,
            title: l10n.home,
          ),
          TabItem(
            icon: Icons.map,
            title: l10n.map,
          ),
          TabItem(
            icon: Icons.contact_mail_outlined,
            title: l10n.contact,
          ),
        ],
      ),
    );
  }
}
