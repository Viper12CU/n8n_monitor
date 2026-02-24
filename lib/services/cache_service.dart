import 'package:hive/hive.dart';

class CacheService {
  final Box box = Hive.box('cache');

  Map<String, dynamic>? getData() {
    final data = box.get('api_cache');
    if (data == null) return null;
    return Map<String, dynamic>.from(data);
  }

  Future<void> saveData(Map<String, dynamic> json) async {
    await box.put('api_cache', json);
  }

  Future<void> clear() async {
    await box.delete('api_cache');
  }
}