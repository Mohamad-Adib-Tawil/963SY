part of 'about_bloc.dart';

abstract class AboutState extends Equatable {
  const AboutState();

  @override
  List<Object> get props => [];
}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutContentLoaded extends AboutState {
  final Map<String, dynamic> content;

  const AboutContentLoaded({required this.content});

  @override
  List<Object> get props => [content];
}

class AppInfoLoaded extends AboutState {
  final Map<String, dynamic> appInfo;

  const AppInfoLoaded({required this.appInfo});

  @override
  List<Object> get props => [appInfo];
}

class AboutError extends AboutState {
  final String message;

  const AboutError(this.message);

  @override
  List<Object> get props => [message];
}
