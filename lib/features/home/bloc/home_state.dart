part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final int currentSliderIndex;
  final List<String> sliderImages;
  final List<CategoryModel> categories;
  final int languageId;

  const HomeLoaded({
    this.currentSliderIndex = 0,
    required this.sliderImages,
    required this.categories,
    required this.languageId,
  });

  @override
  List<Object> get props => [
        currentSliderIndex,
        sliderImages,
        categories,
        languageId,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object> get props => [message];
}
