import 'package:shared_preferences/shared_preferences.dart';

import '../models/user/user_model.dart';

class CacheManager {
  CacheManager._();

  static CacheManager? _instance;

  static CacheManager? getInstance() {
    _instance ??= CacheManager._();
    return _instance!;
  }

  late SharedPreferences _sharedPreferences;

  Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future storeUserModelData(UserModel data) async {
    await _sharedPreferences.setString("user_data", data.toString());
  }

  UserModel getUserModelData() {
    return UserModel.fomString(_sharedPreferences.getString("user_data")!);
  }

  bool isLogged() {
    if (_sharedPreferences.getString("user_data") != null) {
      return true;
    }
    return false;
  }

  Future logout() async {
    await _sharedPreferences.remove("user_data");
  }
}
