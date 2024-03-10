import 'package:shared_preferences/shared_preferences.dart';

class NotePreferences {
  static SharedPreferences? _preferences;

  static const _keySortByCharacter = 'sortByCharacter';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future sortByCharacter(bool condition) async =>
      await _preferences?.setBool(_keySortByCharacter, condition);

  static bool isSortedByCharacter() =>
      _preferences?.getBool(_keySortByCharacter) ?? false;
}
