import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Common/commonFunctions.dart';

class ApiService {
  // Instancia única de la clase (Singleton)
  static final ApiService _instance = ApiService._internal();

  // Constructor privado
  ApiService._internal();

  // Método factory para obtener la instancia única
  factory ApiService() {
    return _instance;
  }

  // URL base de la API

  // Servicio 1: Login
  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = CommonFunctions.validateUrl('/api/auth/v1/login');
    try {
      final response = await http.post(
        Uri.parse(url),//url as Uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );

      if (response.statusCode == 200) {
        
         final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData; //data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Servicio 2: Reset Password
  Future<Map<String, dynamic>?> resetPassword(String email) async {
    final url = CommonFunctions.validateUrl('/api/reset-password/v1/reset-code');
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

