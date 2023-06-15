import 'package:cuidapet_mobile/app/core/local_storage/local_storage/i_local_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage implements ILocalStorage {

  Future<SharedPreferences> get _instance => SharedPreferences.getInstance();

  @override
  Future<void> clean() async {
    final instance = await _instance;
    await instance.clear();
  }

  @override
  Future<bool> contains(String key) async {
    final instance = await _instance;
    return instance.containsKey(key);
  }

  @override
  Future<V?> read<V>(String key) async {
    final instance = await _instance;
    return instance.get(key) as V?;
  }

  @override
  Future<void> remove(String key) async {
    final instance = await _instance;
    await instance.remove(key);
  }

  @override
  Future<void> write<V>(String key, V value) async {
    final instance = await _instance;

    switch(V) {
      case String:
        await instance.setString(key, value as String);
      break;
      case int:
        await instance.setInt(key, value as int);
      break;
      case bool:
        await instance.setBool(key, value as bool);
      break;
      case double:
        await instance.setDouble(key, value as double);
      break;
      case List<String>:
        await instance.setStringList(key, value as List<String>);
      break;
      default:
        throw Exception("Type is not supported");
    }
  }
  
}