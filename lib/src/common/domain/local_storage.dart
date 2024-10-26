import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  factory LocalStorage() => _storage;
  late SharedPreferences preferences;
  final _tokenStreamController = StreamController<String?>.broadcast();

  Stream<String?> get tokenStream => _tokenStreamController.stream;

  LocalStorage._internal();
  static final _storage = LocalStorage._internal();

  Future<void> setSharedPreferences(SharedPreferences prefs) async {
    if (!isInitialized) {
      preferences = prefs;
      isInitialized = true;
    }
  }

  bool isInitialized = false;

  Future<String?> read({required String key}) async {
    return preferences.getString(key);
  }

  Future<void> write(String key, String value) async {
    await preferences.setString(key, value);
    if (key == 'Token') {
      _tokenStreamController.add(value);
    }
    print('$key, $value');
  }

  Future<void> removeToken() async {
    await preferences.remove('Token');
    _tokenStreamController.add(null);
  }

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('username') ?? 'Аноним';
  }

  Future<String> getAvatar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('avatar') ?? '';
  }

  String? get appToken => preferences.getString('Token');
  String? get userName => preferences.getString('username') ?? '';
  String? get avatar => preferences.getString('avatar') ?? '';
}
