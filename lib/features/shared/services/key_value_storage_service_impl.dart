import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

//CREANDO EL ADAPTRADOR PARA GUARDAR LOS VALORES EN MI SHAREPREFERENCE

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    final prefs = await getSharedPrefs();
    final value = prefs.get(key);

    if (value == null) return null;

    if (value is T) {
      return value as T; // ✅ cast explícito
    } else {
      throw UnimplementedError(
        'Get not implemented or cast failed for key "$key" as type ${T.toString()}',
      );
    }
  }

  @override
  Future<bool> removeKey(String key) async {
    final prefs = await getSharedPrefs();
    return await prefs.remove(key);
  }

  @override
  Future<void> setKeyValue<T>(String key, T value) async {
    final prefs = await getSharedPrefs();

    // 🔒 Validación de tipo segura
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is List<String>) {
      prefs.setStringList(key, value);
    } else {
      // 🧠 Mostrar tipo real para depuración
      throw UnimplementedError(
          'set not implemented for type ${value.runtimeType}');
    }
  }

  @override
  Future<void> clearAll() async {
    final prefs = await getSharedPrefs();
    await prefs.clear();
  }
}
