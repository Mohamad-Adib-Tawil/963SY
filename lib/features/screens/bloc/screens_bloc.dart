import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/features/places/data/models/governorates_data.dart';

part 'screens_event.dart';
part 'screens_state.dart';

class ScreensBloc extends Bloc<ScreensEvent, ScreensState> {
  ScreensBloc() : super(ScreensInitial()) {
    on<LoadScreenContent>(_onLoadScreenContent);
    // on<LoadMediaClips>(_onLoadMediaClips);
    // on<LoadPhotos>(_onLoadPhotos);
  }

  void _onLoadScreenContent(
      LoadScreenContent event, Emitter<ScreensState> emit) async {
    //   try {
    //     emit(ScreensLoading());

    //     // TODO: Replace with actual API call
    //     // For now, we'll use static data
    //  //   const governorates = GovernoratesData.governorates;
    //     dynamic content;

//       switch (event.screenType) {
//         case 'info':
//           content = {
//             'title': 'About Syria Tourism',
//             'description': 'Explore the rich history and culture of Syria...',
//           };
//           break;
//         case 'sign_language':
//           if (event.contentId != null) {
//             for (final governorate in governorates) {
//               try {
//                 final place = governorate.places.firstWhere(
//                   (p) => p.name == event.contentId,
//                 );
//                 content = {
//                   'videoUrl': place.signLanguageVideoUrl,
//                   'placeName': place.name,
//                 };
//                 break;
//               } catch (_) {
//                 continue;
//               }
//             }
//           }
//           break;
//         default:
//           content = null;
//       }

//       if (content != null) {
//         emit(ScreenContentLoaded(
//           content: content,
//           screenType: event.screenType,
//         ));
//       } else {
//         emit(const ScreensError('Content not found'));
//       }
//     } catch (e) {
//       emit(ScreensError(e.toString()));
//     }
//   }

//   void _onLoadMediaClips(
//       LoadMediaClips event, Emitter<ScreensState> emit) async {
//     try {
//       emit(ScreensLoading());

//       // TODO: Replace with actual API call
//       // For now, we'll use static data
//       final clips = [
//         {
//           'title': 'Syria Tourism Promo',
//           'url': 'https://example.com/clip1',
//         },
//         {
//           'title': 'Historical Sites',
//           'url': 'https://example.com/clip2',
//         },
//       ];

//       emit(MediaClipsLoaded(clips: clips));
//     } catch (e) {
//       emit(ScreensError(e.toString()));
//     }
//   }

//   void _onLoadPhotos(LoadPhotos event, Emitter<ScreensState> emit) async {
//     // try {
//     //   emit(ScreensLoading());

//       // TODO: Replace with actual API call
//       // For now, we'll use static data
//      // const governorates = GovernoratesData.governorates;
//       // List<String> photos = [];

//       // for (final governorate in governorates) {
//       //   try {
//       //     final place = governorate.places.firstWhere(
//       //       (p) => p.name == event.placeId,
//       //     );
//       //     photos = [place.images[0]];
//       //     break;
//       //   } catch (_) {
//       //     continue;
//       //   }
//       // }

//     //   emit(PhotosLoaded(photos: photos, placeId: event.placeId));
//     // } catch (e) {
//     //   emit(ScreensError(e.toString()));
  }
}
