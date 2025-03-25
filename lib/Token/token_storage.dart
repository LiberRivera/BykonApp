import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
   // Función para almacenar el token
   static const _storage = FlutterSecureStorage();

    static    Future<void> saveToken(String key, String token) async {
        await _storage.write(key: key, value: token);
      }
    static  Future<String?> getToken(String key) async {
        return await _storage.read(key: key);
      }

    static  Future<void> deleteToken(String key) async {
        await _storage.delete(key: key);
      }

}