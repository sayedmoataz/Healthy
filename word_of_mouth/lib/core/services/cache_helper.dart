import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putData({
    required String key,
    required dynamic value,
  }) async {
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setStringList(key, value);
  }

  static dynamic getData({required String key}) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> deleteData({
    required String key,
  }) {
    return sharedPreferences!.remove(key);
  }

  static Future<bool> clearCache({
    required String key,
  }) {
    return sharedPreferences!.clear();
  }
}