import 'package:flutter/material.dart';
import 'package:untitled4/features/home/models/category_model.dart';
import 'package:untitled4/navigation/app_router.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<dynamic> navigateTo(String routeName, {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      return Future.error('Navigator not initialized');
    }
    return navigatorKey.currentState!
        .pushNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToWithReplacement(String routeName,
      {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      return Future.error('Navigator not initialized');
    }
    return navigatorKey.currentState!
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  static Future<dynamic> navigateToAndRemoveUntil(String routeName,
      {Object? arguments}) {
    if (navigatorKey.currentState == null) {
      return Future.error('Navigator not initialized');
    }
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  static void goBack() {
    if (navigatorKey.currentState == null) {
      return;
    }
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    } else {
      navigateToHome();
    }
  }

  static void goBackWithResult(Object result) {
    if (navigatorKey.currentState == null) {
      return;
    }
    return navigatorKey.currentState!.pop(result);
  }

  // Navigation methods for specific routes
  static Future<dynamic> navigateToWelcome() {
    return navigateToAndRemoveUntil(AppRouter.welcome);
  }

  static Future<dynamic> navigateToHome() {
    return navigateToAndRemoveUntil(AppRouter.home);
  }

  static Future<dynamic> navigateToSearch() {
    return navigateTo(AppRouter.search);
  }

  static Future<dynamic> navigateToMap() {
    return navigateTo(AppRouter.map);
  }

  static Future<dynamic> navigateToAbout() {
    return navigateTo(AppRouter.about);
  }

  static Future<dynamic> navigateToContact() {
    return navigateTo(AppRouter.contact);
  }

  static Future<dynamic> navigateToVirtualTour() {
    return navigateTo(AppRouter.virtualTour);
  }

  static Future<dynamic> navigateToServices({required CategoryModel category}) {
    return navigateTo(AppRouter.services, arguments: {'category': category});
  }

  static Future<dynamic> navigateToGovernorates(String tourismType,
      {required int languageId, required int categoryId}) {
    return navigateTo(AppRouter.governorates, arguments: {
      'tourismType': tourismType,
      'languageId': languageId,
      'categoryId': categoryId,
    });
  }
}
