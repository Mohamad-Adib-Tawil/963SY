import 'package:shared_preferences/shared_preferences.dart';

Future<int> getLanguageId() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getInt('selected_language_id') ?? 1;
}
