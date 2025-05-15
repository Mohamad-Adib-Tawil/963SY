part of 'services_bloc.dart';

abstract class ServicesState extends Equatable {
  const ServicesState();

  @override
  List<Object> get props => [];
}

class ServicesInitial extends ServicesState {}

class ServicesLoading extends ServicesState {}

class ServicesLoaded extends ServicesState {
  final String selectedGovernorate;
  final String selectedCategory;
  final List<ServiceItemModel> services;
  final List<String> governorates;
  final List<String> categories;

  const ServicesLoaded({
    required this.selectedGovernorate,
    required this.selectedCategory,
    required this.services,
    required this.governorates,
    required this.categories,
  });

  @override
  List<Object> get props => [
        selectedGovernorate,
        selectedCategory,
        services,
        governorates,
        categories,
      ];
}

class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message);

  @override
  List<Object> get props => [message];
}
