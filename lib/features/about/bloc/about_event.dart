part of 'about_bloc.dart';

abstract class AboutEvent extends Equatable {
  const AboutEvent();

  @override
  List<Object> get props => [];
}

class LoadAboutContent extends AboutEvent {
  const LoadAboutContent();

  @override
  List<Object> get props => [];
}

class LoadAppInfo extends AboutEvent {
  const LoadAppInfo();

  @override
  List<Object> get props => [];
}
