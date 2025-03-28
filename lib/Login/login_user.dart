
class User {
  final String admissionDate;
  final int areaUuid;
  final String contactPhone;
  final String createdAt;
  final String email;
  final String fullName;
  final String jobPosition;
  final bool rememberChangePassword;
  final String userBirthday;
  final int userStatusUuid;
  final int userTypeUuid;
  final int userUuid;

  User({
    required this.admissionDate,
    required this.areaUuid,
    required this.contactPhone,
    required this.createdAt,
    required this.email,
    required this.fullName,
    required this.jobPosition,
    required this.rememberChangePassword,
    required this.userBirthday,
    required this.userStatusUuid,
    required this.userTypeUuid,
    required this.userUuid,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      admissionDate: json['admission_date'],
      areaUuid: json['area_uuid'],
      contactPhone: json['contact_phone'],
      createdAt: json['created_at'],
      email: json['email'],
      fullName: json['full_name'],
      jobPosition: json['job_position'],
      rememberChangePassword: json['remember_change_password'],
      userBirthday: json['user_birthday'],
      userStatusUuid: json['user_status_uuid'],
      userTypeUuid: json['user_type_uuid'],
      userUuid: json['user_uuid'],
    );
  }
}

class LoginResponse {
  final String accessToken;
  final String message;
  final String refreshToken;
  final User user;

  LoginResponse({
    required this.accessToken,
    required this.message,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json['access_token'],
      message: json['message'],
      refreshToken: json['refresh_token'],
      user: User.fromJson(json['user']),
    );
  }
}  



// Función para realizar el login
/*Future<LoginResponse> login(String email, String password) async {
  final url = Uri.parse('https://dev-bykonapp.bertinsalas.com/api/auth/v1/login');
  final body = jsonEncode({
    'email': email,
    'password': password,
  });

  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: body,
  );

  if (response.statusCode == 200) {
    // Si la solicitud es exitosa, parseamos la respuesta
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return LoginResponse.fromJson(responseData);
  } else {
    // Si hay un error, lanzamos una excepción
    throw Exception('Error al realizar el login: ${response.statusCode}');
  }
}*/
