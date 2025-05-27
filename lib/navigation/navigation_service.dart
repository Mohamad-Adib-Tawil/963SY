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

  // إزالة جميع الصفحات السابقة والانتقال
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

  // الرجوع للوراء
  static void goBack() {
    if (navigatorKey.currentState == null) return;
    if (navigatorKey.currentState!.canPop()) {
      navigatorKey.currentState!.pop();
    } else {
      navigateToHome();
    }
  }

  // الرجوع مع نتيجة
  static void goBackWithResult(Object result) {
    if (navigatorKey.currentState == null) return;
    navigatorKey.currentState!.pop(result);
  }

  static Future<dynamic> navigateToWelcome() {
    return navigateToAndRemoveUntil(AppRouter.welcome);
  }

  static Future<dynamic> navigateToHome() {
    return navigateToAndRemoveUntil(AppRouter.home);
  }

  static Future<dynamic> navigateToSearch() {
    return navigateToWithReplacement(AppRouter.search);
  }

  static Future<dynamic> navigateToMap() {
    return navigateToWithReplacement(AppRouter.map);
  }

  static Future<dynamic> navigateToAbout() {
    return navigateToWithReplacement(AppRouter.about);
  }

  static Future<dynamic> navigateToContact() {
    return navigateToWithReplacement(AppRouter.contact);
  }

  static Future<dynamic> navigateToVirtualTour() {
    return navigateToWithReplacement(AppRouter.virtualTour);
  }

  static Future<dynamic> navigateToServices({required CategoryModel category}) {
    return navigateToWithReplacement(AppRouter.services,
        arguments: {'category': category});
  }

  static Future<dynamic> navigateToGovernorates(String tourismType,
      {required int languageId, required int categoryId}) {
    return navigateToWithReplacement(AppRouter.governorates, arguments: {
      'tourismType': tourismType,
      'languageId': languageId,
      'categoryId': categoryId,
    });
  }
}
