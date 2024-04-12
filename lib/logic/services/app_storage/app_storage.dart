import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:webspark_test/logic/services/app_storage/model/state.dart';
import 'package:webspark_test/logic/utils/utils.dart';

@singleton
class AppStorage {
  final SharedPreferences _prefs;

  AppStorage(this._prefs);

  final _key = 'testKey';

  Future<void> setData(AppState appState) async {
    final json = appState.toJson();
    final data = jsonEncode(json);
    await _prefs.setString(_key, data);
  }

  AppState get data {
    final data = _prefs.getString(_key);
    if (data == null) {
      return const AppState();
    }
    final map = jsonDecode(data);

    return AppState.fromJson(map);
  }

  Future setLanguage(AppSupportedLocale language) async {
    await setData(data.copyWith(language: language));
  }

  Future<bool> clearStorage() async {
    try {
      await Future.forEach(_prefs.getKeys(), (key) async => await _prefs.remove(key));

      return true;
    } catch (e) {
      return false;
    }
  }
}
