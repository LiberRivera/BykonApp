import 'dart:convert';
import 'package:http/http.dart' as http;

// Clase para la solicitud
class ResetCodeRequest {
  final String email;

  ResetCodeRequest({required this.email});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

// Clase para la respuesta
class ResetCodeResponse {
  final String message;
  final String token;
  final String userCode;

  ResetCodeResponse({
    required this.message,
    required this.token,
    required this.userCode,
  });

  factory ResetCodeResponse.fromJson(Map<String, dynamic> json) {
    return ResetCodeResponse(
      message: json['message'],
      token: json['token'],
      userCode: json['user_code'], // Nota: el campo tiene un typo en "user_"
    );
  }
}

// Función para consumir el servicio
Future<ResetCodeResponse?> sendResetCode(String email) async {
  
  final url = Uri.parse('https://dev-bykonapp.bertinsalas.com/api/reset-password/v1/reset-code');
      final Map<String, dynamic> requestBody = {
        "email": email
      };


  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      //print('LOG_DEBUG_1: $responseData');
      return ResetCodeResponse.fromJson(responseData);
    } else {

      return null;
    }
  } catch (e) {

    return null;
  }
}


/*
class SendResetCodePassword{
    // valida que la URL del servicio de SendResetCode sea validad
    static String get sendResetCodeUrl {
      return CommonFunctions.validateUrl('/api/reset-password/v1/reset-code');
    }
    // Función para consumir el servicio REST
  static Future<SendResetCodeResponse?> sendResetCode(String email) async {
        // URL del servicio       
        final url = sendResetCodeUrl;
    try {    
        // Crea la solicitud
        //final request = SendResetCodeRequest(email: email);
        final Map<String, dynamic> requestBody = {
          "email": email
        };
        // Realiza la solicitud HTTP POST
        final response = await http.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'}, // Define el tipo de contenido como JSON
          body: jsonEncode(requestBody), // Convierte la solicitud a JSON
        );

        // Verifica si la solicitud fue exitosa
        if (response.statusCode == 200) {
          // Decodifica la respuesta JSON y crea una instancia de ResetPasswordResponse
          final Map<String, dynamic> responseData = jsonDecode(response.body);
          return SendResetCodeResponse.fromJson(responseData);
        } else {
          // Manejar errores de la API
      return null;
        }
        }catch (e) {
      // Manejar errores de conexión o excepciones
         return null;
    }

      }
}


            // URL del servicio       
        final url = sendResetCodeUrl;
        */
    // Fun