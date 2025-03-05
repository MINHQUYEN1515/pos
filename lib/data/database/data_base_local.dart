import 'package:shared_preferences/shared_preferences.dart';

class DataBaseLocal {
  static final DataBaseLocal instance = DataBaseLocal._internal();
  late SharedPreferences _prefs;

  // Constructor riêng tư để đảm bảo Singleton
  DataBaseLocal._internal();
  // Hàm khởi tạo (cần gọi trước khi sử dụng)
  static Future<void> init() async {
    instance._prefs = await SharedPreferences.getInstance();
  }

  // 🔹 Lưu dữ liệu kiểu String
  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  // 🔹 Lưu dữ liệu kiểu int
  Future<void> setInt(String key, int value) async {
    await _prefs.setInt(key, value);
  }

  int? getInt(String key) {
    return _prefs.getInt(key);
  }

  // 🔹 Lưu dữ liệu kiểu bool
  Future<void> setBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  // 🔹 Xóa dữ liệu
  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  // 🔹 Xóa toàn bộ dữ liệu
  Future<void> clear() async {
    await _prefs.clear();
  }
}
