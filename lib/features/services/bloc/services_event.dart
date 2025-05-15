part of 'services_bloc.dart';

abstract class ServicesEvent extends Equatable {
  const ServicesEvent();

  @override
  List<Object> get props => [];
}

class InitialLoad extends ServicesEvent {
  const InitialLoad();
}

class LoadServices extends ServicesEvent {
  final String governorate;
  final String category;
  final BuildContext context;

  const LoadServices({
    required this.governorate,
    required this.category,
    required this.context,
  });

  @override
  List<Object> get props => [governorate, category];
}

class ChangeGovernorate extends ServicesEvent {
  final String governorate;
  final BuildContext context;

  const ChangeGovernorate({
    required this.governorate,
    required this.context,
  });

  @override
  List<Object> get props => [governorate];
}

class ChangeCategory extends ServicesEvent {
  final String category;
  final BuildContext context;

  const ChangeCategory({
    required this.category,
    required this.context,
  });

  @override
  List<Object> get props => [category];
}
