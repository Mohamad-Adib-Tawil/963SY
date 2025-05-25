import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/core/services/custom_bloc_observer.dart';
import 'package:untitled4/core/services/get_it_service.dart';
import 'package:untitled4/features/home/cubit/language_cubit.dart';
import 'package:untitled4/features/home/cubit/slider_cubit.dart';
import 'package:untitled4/features/home/home_cubit/home_cubit.dart';
import 'package:untitled4/features/home/repos/home_repo.dart';
import 'package:untitled4/features/places/cubit/place_details_cubit.dart';
import 'package:untitled4/features/places/data/repos/place_details_repo.dart';
import 'package:untitled4/features/services/cubit/city_cubit.dart';
import 'package:untitled4/features/services/repo/servIce_repo.dart';
import 'package:untitled4/screens/language_selection_screen.dart';
import 'package:untitled4/screens/privacy_policy_screen.dart';
import 'package:untitled4/screens/welcome_screen.dart';
import 'package:untitled4/features/home/presentation/pages/homepage.dart';
import 'package:untitled4/features/home/bloc/home_bloc.dart';
import 'package:untitled4/features/contact/bloc/contact_bloc.dart';
import 'package:untitled4/l10n/app_localizations.dart';
import 'package:untitled4/navigation/navigation_service.dart';
import 'package:untitled4/navigation/app_router.dart';
import 'package:untitled4/providers/language_provider.dart';
import 'package:untitled4/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  final isFirstRun = prefs.getBool('is_first_run') ?? true;
  String initialRoute;

  if (isFirstRun) {
    initialRoute = '/language';
    await prefs.setBool('has_seen_language_selection', true);
    await prefs.setBool('is_first_run', false);
  } else {
    final hasSeenPrivacy = prefs.getBool('has_seen_privacy') ?? false;

    if (!hasSeenPrivacy) {
      initialRoute = '/privacy';
      await prefs.setBool('has_seen_privacy', true);
    } else {
      initialRoute = '/welcome';
    }
  }
  Bloc.observer = CustomBlocObserver();
  setupGetIt();
  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(
            create: (context) => HomeCubit(getIt<HomeRepo>())..getCategories()),
        BlocProvider(
            create: (context) => ContactBloc()
              ..add(const LoadContactInfo())), // Contact Bloc هنا
        BlocProvider(
            create: (context) => PlaceDetailsCubit(getIt<PlaceDetailsRepo>())),
        BlocProvider(create: (context) => CityCubit(getIt<ServiceRepo>())),
        BlocProvider(
            create: (context) =>
                LanguageCubit(getIt<HomeRepo>())..getLanguages()),
        BlocProvider(
            create: (context) =>
                SliderCubit(getIt<HomeRepo>())..getSliderImages()),
        ChangeNotifierProvider(create: (context) => LanguageProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            title: 'Tourism App',
            debugShowCheckedModeBanner: false,
            navigatorKey: NavigationService.navigatorKey,
            theme: AppTheme.lightTheme,
            locale: languageProvider.currentLocale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en'),
              Locale('ar'),
              Locale('fr'),
              Locale('es'),
              Locale('tr'),
              Locale('zh'),
              Locale('it')
            ],
            initialRoute: initialRoute,
            onGenerateRoute: AppRouter.generateRoute,
            routes: {
              '/language': (context) => const LanguageSelectionScreen(),
              '/privacy': (context) => PrivacyPolicyScreen(),
              '/welcome': (context) => const WelcomeScreen(),
              '/home': (context) => const Homepage(),
            },
          );
        },
      ),
    );
  }
}
