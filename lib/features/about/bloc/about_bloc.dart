import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'about_event.dart';
part 'about_state.dart';

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  AboutBloc() : super(AboutInitial()) {
    on<LoadAboutContent>(_onLoadAboutContent);
    on<LoadAppInfo>(_onLoadAppInfo);
  }

  void _onLoadAboutContent(
      LoadAboutContent event, Emitter<AboutState> emit) async {
    try {
      emit(AboutLoading());

      // TODO: Replace with actual API call
      // For now, we'll use static data
      final content = {
        'title': 'About Syria Tourism',
        'description': 'Explore the rich history and culture of Syria...',
        'version': '1.0.0',
        'lastUpdated': '2024-05-03',
      };

      emit(AboutContentLoaded(content: content));
    } catch (e) {
      emit(AboutError(e.toString()));
    }
  }

  void _onLoadAppInfo(LoadAppInfo event, Emitter<AboutState> emit) async {
    try {
      emit(AboutLoading());

      // TODO: Replace with actual API call
      // For now, we'll use static data
      final appInfo = {
        'name': 'Syria Tourism',
        'version': '1.0.0',
        'developer': 'Your Company',
        'website': 'https://example.com',
        'privacyPolicy': 'https://example.com/privacy',
        'termsOfService': 'https://example.com/terms',
      };

      emit(AppInfoLoaded(appInfo: appInfo));
    } catch (e) {
      emit(AboutError(e.toString()));
    }
  }
}
