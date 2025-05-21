part of 'service_cubit.dart';

sealed class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

final class ServiceInitial extends ServiceState {}

final class ServiceLoading extends ServiceState {}

final class ServiceSuccess extends ServiceState {
  final List<Service> services;

  const ServiceSuccess({required this.services});
}

final class ServiceFailuer extends ServiceState {
  final String errorMessage;

  const ServiceFailuer({required this.errorMessage});
}
