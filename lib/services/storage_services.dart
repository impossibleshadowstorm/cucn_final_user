import 'package:shared_preferences/shared_preferences.dart';

class StorageServices {
  late final SharedPreferences _prefs;

  Future<StorageServices> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> setBool(String key, bool value) async {
    return await _prefs.setBool(key, value);
  }

  bool getBool(String key) {
    return _prefs.getBool(key) ?? false;
  }

  bool getDeviceFirstOpen() {
    // return _prefs.set(Constants.storageDeviceOpenFirstTime) ?? false;
    return true;
  }

  Future<bool> setString(String key, String value) async {
    return await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<bool> removeData(String key) async {
    return _prefs.remove(key);
  }

  Future<bool> removeAllData() async {
    return _prefs.clear();
  }
}
