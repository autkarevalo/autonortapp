import 'package:shared_preferences/shared_preferences.dart';

import 'key_value_storage_service.dart';

//CREANDO EL ADAPTRADOR PARA GUARDAR LOS VALORES EN MI SHAREPREFERENCE

class KeyValueStorageServiceImpl extends KeyValueStorageService {
  Future<SharedPreferences> getSharedPrefs() async {
    return await SharedPreferences.getInstance();
  }

  @override
  Future<T?> getValue<T>(String key) async {
    //leer el valor
    final prefs = await getSharedPrefs();
    if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == String) {
      return prefs.getString(key) as T?;
    } else {
      throw UnimplementedError('Get no implment for type ${T.runtimeType}');
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

    if (T == int) {
      prefs.setInt(key, value as int);
    } else if (T == String) {
      prefs.setString(key, value as String);
    } else {
      throw UnimplementedError('set not implemented for type ${T.runtimeType}');
    }
  }
}
