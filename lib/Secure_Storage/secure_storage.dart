import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocationStorage {
  static const storage = FlutterSecureStorage();

  Future saveLocation(String key, String path) async {
    return await storage.write(key: key, value: path);
  }

  Future getLocation(String key) async {
    return await storage.read(key: key);
  }
}
