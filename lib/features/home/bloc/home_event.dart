part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class HomeStarted extends HomeEvent {}

class HomeCategorySelected extends HomeEvent {
  final String categoryTitle;
  final String categoryType;

  const HomeCategorySelected({
    required this.categoryTitle,
    required this.categoryType,
  });

  @override
  List<Object?> get props => [categoryTitle, categoryType];
}

class HomeSliderChanged extends HomeEvent {
  final int currentIndex;

  const HomeSliderChanged(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

class HomeLanguageChanged extends HomeEvent {
  final int languageId;

  const HomeLanguageChanged(this.languageId);

  @override
  List<Object?> get props => [languageId];
}
