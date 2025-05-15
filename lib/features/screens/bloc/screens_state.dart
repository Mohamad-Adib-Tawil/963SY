part of 'screens_bloc.dart';

abstract class ScreensState extends Equatable {
  const ScreensState();

  @override
  List<Object> get props => [];
}

class ScreensInitial extends ScreensState {}

class ScreensLoading extends ScreensState {}

class ScreenContentLoaded extends ScreensState {
  final dynamic content;
  final String screenType;

  const ScreenContentLoaded({
    required this.content,
    required this.screenType,
  });

  @override
  List<Object> get props => [content, screenType];
}

class MediaClipsLoaded extends ScreensState {
  final List<dynamic> clips;

  const MediaClipsLoaded({required this.clips});

  @override
  List<Object> get props => [clips];
}

class PhotosLoaded extends ScreensState {
  final List<String> photos;
  final String placeId;

  const PhotosLoaded({
    required this.photos,
    required this.placeId,
  });

  @override
  List<Object> get props => [photos, placeId];
}

class ScreensError extends ScreensState {
  final String message;

  const ScreensError(this.message);

  @override
  List<Object> get props => [message];
}
