import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:untitled4/core/network/api_service.dart';
import 'package:untitled4/features/home/repos/home_repo.dart';
import 'package:untitled4/features/search/repo/search_repo.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerSingleton<ApiService>(ApiService(Dio()));
  getIt.registerSingleton<HomeRepo>(HomeRepo(apiService: getIt<ApiService>()));
  getIt.registerSingleton<SearchRepo>(SearchRepo(apiService: getIt<ApiService>()));
}