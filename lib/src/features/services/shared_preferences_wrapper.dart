import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesWrapper {
  late SharedPreferences _prefs;

  SharedPreferencesWrapper._privateConstructor();

  static final SharedPreferencesWrapper _instance =
      SharedPreferencesWrapper._privateConstructor();

  factory SharedPreferencesWrapper() {
    return _instance;
  }

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveObject(String key, String? object) async {
    if (object != null) {
      await _prefs.setString(key, object);
    }
  }

  String? getObject(String key) {
    return _prefs.getString(key);
  }

  void remove(String key) {
    _prefs.remove(key);
  }
}
