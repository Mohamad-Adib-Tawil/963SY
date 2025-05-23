import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/core/services/get_it_service.dart';
import 'package:untitled4/features/about/presentation/pages/about_us_page.dart';
import 'package:untitled4/features/contact/presentation/pages/contact_us_screen.dart';
import 'package:untitled4/features/home/models/category_model.dart';
import 'package:untitled4/features/map/presentation/pages/syria_map_page.dart';
import 'package:untitled4/features/search/cubit/search_cubit_cubit.dart';
import 'package:untitled4/features/search/presentation/pages/search_page.dart';
import 'package:untitled4/features/search/repo/search_repo.dart';
import 'package:untitled4/features/services/cubit/place_service_cubit.dart';
import 'package:untitled4/features/services/cubit/service_cubit.dart';
import 'package:untitled4/features/services/cubit/star_cubit.dart';
import 'package:untitled4/features/services/model/place_of_service/place_of_service.dart';
import 'package:untitled4/features/services/repo/servIce_repo.dart';
import 'package:untitled4/screens/virtual_tour_screen.dart';
import 'package:untitled4/screens/welcome_screen.dart';
import 'package:untitled4/features/home/presentation/pages/homepage.dart';
import 'package:untitled4/features/services/services_tabs_screen.dart';
import 'package:untitled4/features/services/bloc/services_bloc.dart';
import 'package:untitled4/features/places/presentation/pages/tourist_places_screen.dart';

import 'package:untitled4/features/about/bloc/about_bloc.dart';
import 'package:untitled4/features/virtual_tour/bloc/virtual_tour_bloc.dart';
import 'package:untitled4/features/home/presentation/pages/syrian_governorates_page.dart';

class AppRouter {
  static const String welcome = '/welcome';
  static const String home = '/home';
  static const String search = '/search';
  static const String map = '/map';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String virtualTour = '/virtual-tour';
  static const String services = '/services';
  static const String governorates = '/governorates';
  static const String details = '/details';
  static const String touristPlaces = '/tourist-places';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const Homepage());
      case search:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => SearchCubit(getIt<SearchRepo>()),
            child: const SearchPage(),
          ),
        );
      case map:
        return MaterialPageRoute(builder: (_) => const SyriaMapPage());
      case about:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AboutBloc()..add(const LoadAboutContent()),
            child: const AboutUsPage(),
          ),
        );
      case contact:
        return MaterialPageRoute(
          builder: (_) =>
              const ContactUsScreen(), // فقط استدعاء الشاشة، البلوك معرف مسبقًا
        );

      case services:
        final a = settings.arguments as Map<String, dynamic>?;
        final category = a?['category'] as CategoryModel;
        return MaterialPageRoute(
          builder: (_) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ServiceCubit(getIt<ServiceRepo>()),
              ),
              BlocProvider(
                create: (context) => PlaceServiceCubit(getIt<ServiceRepo>()),
              ),
              BlocProvider(
                  create: (context) => StarCubit(getIt<ServiceRepo>())),
            ],
            child: RedesignedServiceScreen(
              category: category,
            ),
          ),
        );
      case governorates:
        final args = settings.arguments as Map<String, dynamic>?;
        final tourismType = args?['tourismType'] as String? ?? '';
        final languageId = args?['languageId'] as int? ?? 1;
        final categoryId = args?['categoryId'] as int? ?? 1;
        return MaterialPageRoute(
          builder: (_) => SyrianGovernoratesTabs(
            tourismType: tourismType,
            languageId: languageId,
            categoryId: categoryId,
          ),
        );
      case touristPlaces:
        final screen = settings.arguments as TouristPlacesScreen;
        return MaterialPageRoute(builder: (_) => screen);
      case details:
        final screen = settings.arguments as Widget;
        return MaterialPageRoute(builder: (_) => screen);
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
