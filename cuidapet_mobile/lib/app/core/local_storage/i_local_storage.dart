abstract class ILocalStorage {
  
  Future<V?> read<V>(String key);

  Future<void> write<V>(String key, V value);

  Future<bool> contains(String key);

  Future<void> clean();

  Future<void> remove(String key);
}

abstract class ILocalSecureStorage {
  Future<String?> read(String key);

  Future<void> write(String key, String value);

  Future<bool> contains(String key);

  Future<void> clean();

  Future<void> remove(String key);
}