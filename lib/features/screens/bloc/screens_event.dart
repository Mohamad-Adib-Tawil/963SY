part of 'screens_bloc.dart';

abstract class ScreensEvent extends Equatable {
  const ScreensEvent();

  @override
  List<Object> get props => [];
}

class LoadScreenContent extends ScreensEvent {
  final String screenType;
  final String? contentId;

  const LoadScreenContent({
    required this.screenType,
    this.contentId,
  });

  @override
  List<Object> get props => [screenType, contentId ?? ''];
}

class LoadMediaClips extends ScreensEvent {
  const LoadMediaClips();

  @override
  List<Object> get props => [];
}

class LoadPhotos extends ScreensEvent {
  final String placeId;

  const LoadPhotos({required this.placeId});

  @override
  List<Object> get props => [placeId];
}
