import 'dart:convert';
import 'package:http/http.dart' as http;

import '../Common/commonFunctions.dart';

//Data class para la solicitud
class ChangePasswordRequest {
  final String token;
  final String userCode;
  final String newPassword;

  ChangePasswordRequest({
    required this.token,
    required this.userCode,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'user_code': userCode,
      'new_password': newPassword,
    };
  }
}

//Data class para la respuesta
class ChangePasswordResponse {
  final String message;

  ChangePasswordResponse({
    required this.message});

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      message: json['message'],
    );
  }
}

class SendChangePassword{
// valida que la URL del servicio de SendChangePassword sea valida
    static String get sendChangePasswordUrl {
      return CommonFunctions.validateUrl('api/reset-password/v1/validate-change');
    }
    /*
      String token, String userCode, String newPassword,
     */
// Función para consumir el servicio
static Future<ChangePasswordResponse?> changePassword(String token, String userCode, String newPassword) async {
   final url = sendChangePasswordUrl;
try{
  // Realiza la solicitud HTTP POST
    final request = 
         ChangePasswordRequest(token: token, userCode: userCode, newPassword: newPassword);

  
  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
    },
    body: jsonEncode(request.toJson()),
  );

  if (response.statusCode == 200) {
    print('LOG_D response 200: ${response.body}');
    return ChangePasswordResponse.fromJson(jsonDecode(response.body));
  } else {
    print('LOG_D response : Failed to reset password');
    throw Exception('Failed to reset password');
  }
  }catch (e) {
      // Manejar errores de conexió
      //n o excepciones
      print('LOG_D response : Failed to reset password $e');
         return null;
}
}

}