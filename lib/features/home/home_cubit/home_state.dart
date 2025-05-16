part of 'home_cubit.dart';

sealed class HomeCubitState extends Equatable {
  const HomeCubitState();

  @override
  List<Object> get props => [];
}

final class HomeCubitInitial extends HomeCubitState {}
final class HomeCubitLoading extends HomeCubitState {}
final class HomeCubitSuccess extends HomeCubitState {
  final List<CategoryModel> categories;
  const HomeCubitSuccess(this.categories);
}
final class HomeCubitError extends HomeCubitState {
  final String message;
  const HomeCubitError(this.message);
}
