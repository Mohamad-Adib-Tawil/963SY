import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:untitled4/core/network/api_client.dart';
import 'package:untitled4/features/home/models/category_model.dart';

// Events
abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoryEvent {
  final int languageId;

  const LoadCategories(this.languageId);

  @override
  List<Object> get props => [languageId];
}

// States
abstract class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<CategoryModel> categories;

  const CategoryLoaded(this.categories);

  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  const CategoryError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>(_onLoadCategories);
  }

  Future<void> _onLoadCategories(
    LoadCategories event,
    Emitter<CategoryState> emit,
  ) async {
    try {
      emit(CategoryLoading());

      final response = await ApiClient.instance.get(
        '/category/language/${event.languageId}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['data'];
        final categories =
            data.map((json) => CategoryModel.fromJson(json)).toList();
        emit(CategoryLoaded(categories));
      } else {
        emit(const CategoryError('Failed to load categories'));
      }
    } catch (e) {
      emit(CategoryError(e.toString()));
    }
  }
}
