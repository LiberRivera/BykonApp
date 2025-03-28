class SendResetCodeData {
  final String message;
  final String token;
  final String userCode;

  SendResetCodeData({required this.message, required this.token, required this.userCode});

  // Método para crear el cuerpo del request
  Map<String, dynamic> toRequest() {
    return {
      "email": "libertad.rivera@bykon.com.mx", // El email está hardcodeado según tu ejemplo
    };
  }

  // Factory constructor para crear una instancia de Data desde un mapa (response)
  factory SendResetCodeData.fromJson(Map<String, dynamic> json) {
    return SendResetCodeData(
      message: json['message'] as String,
      token: json['token'] as String,
      userCode: json['user_coode'] as String,
    );
  }
}

class  SendResetCodeResponse{
  final String message;
  final String token;
  final String userCode;

  SendResetCodeResponse({
    required this.message,
    required this.token,
    required this.userCode,
  });

  factory SendResetCodeResponse.fromJson(Map<String, dynamic> json) {
    return SendResetCodeResponse(
      message: json['message'] as String,
      token: json['token'] as String,
      userCode: json['user_coode'] as String,
    );
  }
}

