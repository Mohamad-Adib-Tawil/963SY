import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled4/features/home/models/category_model.dart';

Future<int> getLanguageId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('selected_language_id') ?? 1;
}

CategoryModel? firstCategoty;

