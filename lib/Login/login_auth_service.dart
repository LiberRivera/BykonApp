import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Common/commonFunctions.dart';
import 'login_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


Future<void> saveToken(String key, String token) async {
  final storage = FlutterSecureStorage();
  await storage.write(key: key, value: token);
}

Future<String?> getToken(String key) async {
  final storage = FlutterSecureStorage();
  return await storage.read(key: key);
}

Future<void> deleteToken(String key) async {
  final storage = FlutterSecureStorage();
  await storage.delete(key: key);
}

  class LoginService {
  // valida que la URL del servicio de autenticación sea validad
  static String get loginUrl {
    return CommonFunctions.validateUrl('/api/auth/v1/login');
  }

  // Método para realizar el login
  static Future<LoginResponse?> login(String email, String password) async {
    final url = loginUrl;
    try {
       // Usar la URL desde .env
      // Crear el cuerpo de la solicitud
      final Map<String, dynamic> requestBody = {
        "email": email,
        "password": password,
      };

      // Realizar la solicitud POST
      final response = await http.post(
          Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      // Verificar el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final Map<String, dynamic> responseData = jsonDecode(response.body);


        // guardar el accessToken y refreshToken   
        final accessToken = dotenv.env['ACCESS_TOKEN'];
          if (accessToken == null) {
            throw Exception('ACCESS_TOKEN no está definido en el archivo .env');
          } else
            {await saveToken(accessToken,LoginResponse.fromJson(responseData).accessToken); }
        final refreshToken = dotenv.env['REFRESH_TOKEN'];
          if (refreshToken == null) {
            throw Exception('REFRESH_TOKEN no está definido en el archivo .env');
          } else
            {await saveToken(refreshToken,LoginResponse.fromJson(responseData).refreshToken); }
      return LoginResponse.fromJson(responseData);

      } else {
        // Manejar errores de la API
      return null;
      }
    } catch (e) {
      // Manejar errores de conexión o excepciones
         return null;
    }
  }
}