import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Common/commonFunctions.dart';

// Data class para la solicitud
class SendResetCodeRequest {
  final String email;

  SendResetCodeRequest({
    required this.email});

  // Convierte el objeto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

// Data class para la respuesta
class SendResetCodeResponse {
  final String message;
  final String token;
  final String userCode;

  SendResetCodeResponse({
    required this.message,
    required this.token,
    required this.userCode,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory SendResetCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendResetCodeResponse(
      message: json['message'],
      token: json['token'],
      userCode: json['user_coode'], // Nota: Asegúrate de que el nombre del campo coincida con la respuesta
    );
  }
}

class SendResetPassword{
    // valida que la URL del servicio de SendResetCode sea validad
    static String get sendResetCodeUrl {
      return CommonFunctions.validateUrl('/api/reset-password/v1/reset-code');
    }
    // Función para consumir el servicio REST
  static Future<SendResetCodeResponse?> send_reset_code(String email) async {
        // URL del servicio       
        final url = sendResetCodeUrl;
    try {    
        // Crea la solicitud
        final request = 
         SendResetCodeRequest(email: email);

        // Realiza la solicitud HTTP POST
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, // Define el tipo de contenido como JSON
          body: jsonEncode(request.toJson()), // Convierte la solicitud a JSON
        );

        // Verifica si la solicitud fue exitosa
        if (response.statusCode == 200) {
          // Decodifica la respuesta JSON y crea una instancia de ResetPasswordResponse
          return SendResetCodeResponse.fromJson(jsonDecode(response.body));
        } else {
          // Si la solicitud no fue exitosa, lanza una excepción
          throw Exception('Failed to load data: ${response.statusCode}');
        }
        }catch (e) {
      // Manejar errores de conexión o excepciones
         return null;
    }

      }
}
