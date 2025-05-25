import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/core/network/api_client.dart';
import 'package:untitled4/features/home/models/category_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

part 'home_state.dart';
part 'home_event.dart';

// Bloc
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeStarted>(_onHomeStarted);
    on<HomeSliderChanged>(_onSliderChanged);
    on<HomeCategorySelected>(_onCategorySelected);
    on<HomeLanguageChanged>(_onLanguageChanged);
  }

  // Default slider images using existing assets
  final List<String> defaultSliderImages = [
    'assets/images/site1.jpg',
    'assets/images/site2.jpg',
    'assets/images/site3.jpg',
    'assets/images/site4.jpg',
  ];

  Future<void> _onHomeStarted(
      HomeStarted event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());

      // Get the saved language ID or default to 1 (Arabic)
      final prefs = await SharedPreferences.getInstance();
      final languageId = prefs.getInt('selected_language_id') ?? 1;

      developer.log('Using language ID: $languageId');

      // Emit loading state with default slider images
      emit(HomeLoaded(
        sliderImages: defaultSliderImages,
        categories: const [],
        languageId: languageId,
      ));

      // Use the correct endpoint with language ID
      final response = await ApiClient.instance.get(
        '/category1/category/language/$languageId',
      );

      developer.log('API Response status: ${response.statusCode}');
      developer.log('API Response data: ${response.data}');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final categories =
            data.map((json) => CategoryModel.fromJson(json)).toList();

        developer.log('Categories count: ${categories.length}');

        emit(HomeLoaded(
          sliderImages: defaultSliderImages,
          categories: categories,
          languageId: languageId,
        ));
      } else {
        developer.log('Error: Unexpected status code ${response.statusCode}');
        emit(HomeError('Failed to load categories: ${response.statusCode}'));
      }
    } catch (e, stackTrace) {
      developer.log('Error loading categories',
          error: e, stackTrace: stackTrace);
      emit(HomeError('Failed to load categories: ${e.toString()}'));
    }
  }

  Future<void> _onLanguageChanged(
      HomeLanguageChanged event, Emitter<HomeState> emit) async {
    try {
      // Save the new language ID
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('selected_language_id', event.languageId);

      // Reload categories with new language
      add(HomeStarted());
    } catch (e) {
      developer.log('Error changing language', error: e);
    }
  }

  void _onSliderChanged(HomeSliderChanged event, Emitter<HomeState> emit) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(HomeLoaded(
        sliderImages: currentState.sliderImages,
        currentSliderIndex: event.currentIndex,
        categories: currentState.categories,
        languageId: currentState.languageId,
      ));
    }
  }

  void _onCategorySelected(
      HomeCategorySelected event, Emitter<HomeState> emit) {
    // Handle category selection if needed
  }
}
