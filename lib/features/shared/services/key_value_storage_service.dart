//una clase astracta
//T es tipo de dato generico
abstract class KeyValueStorageService {
  Future<void> setKeyValue<T>(String key, T value);
  Future<T?> getValue<T>(String key);
  Future<bool> removeKey(String key);
  Future<void> clearAll();
}
