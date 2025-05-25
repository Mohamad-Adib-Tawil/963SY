import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled4/models/governorate_m.dart';

// Events
abstract class GovernoratesEvent {}

class LoadGovernorates extends GovernoratesEvent {
  final String tourismType;
  LoadGovernorates({required this.tourismType});
}

// States
abstract class GovernoratesState {}

class GovernoratesInitial extends GovernoratesState {}

class GovernoratesLoading extends GovernoratesState {}

class GovernoratesLoaded extends GovernoratesState {
  final List<Governorate> governorates;
  GovernoratesLoaded({required this.governorates});
}

class GovernoratesError extends GovernoratesState {
  final String message;
  GovernoratesError({required this.message});
}

// Bloc
class GovernoratesBloc extends Bloc<GovernoratesEvent, GovernoratesState> {
  GovernoratesBloc() : super(GovernoratesInitial()) {
    on<LoadGovernorates>(_onLoadGovernorates);
  }

  void _onLoadGovernorates(
      LoadGovernorates event, Emitter<GovernoratesState> emit) async {
    try {
      emit(GovernoratesLoading());
      // emit(GovernoratesLoaded(governorates: GovernoratesData.governorates));
    } catch (e) {
      emit(GovernoratesError(message: e.toString()));
    }
  }
}
