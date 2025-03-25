import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../ResetPassword/send_reset_code_screen.dart';
import '../main.dart'; // Ajusta la ruta a donde tengas tu HomeScreen
import 'login_auth_service.dart';
//import '../changepassword.dart';




Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Cargar variables de entorno
  runApp(MyApp());
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}
     
class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController =  TextEditingController();



  bool _passwordVisible = false;
  bool _rememberMe = true;

  @override
  void initState() {
    super.initState();
    // Escuchamos cambios en ambos campos para refrescar el botón
    _emailController.addListener(_onFieldChange);
    _passwordController.addListener(_onFieldChange);

    _emailController.text = "libertad.rivera@bykon.com.mx"; //"bertin.salas@bykon.com.mx";
    _passwordController.text = "%h4rRyP0tt3r%"; //"%h4rRyP0tt3r%23";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onFieldChange() {
    // Cada vez que cambian los campos, se reconstruye la UI
    setState(() {});
  }

  // Verifica si ambos campos están llenos
  bool get _allFieldsFilled =>
      _emailController.text.isNotEmpty &&
      _passwordController.text.isNotEmpty;

//--------------------------------------------------
  Map<String, dynamic>? loginResponse;
  bool isLoading = false;
  // Función para manejar el login

//--------------------------------------------------


  @override
  Widget build(BuildContext context) {
    // -------------------------
    // Estilos / Colores
    // -------------------------
    final LinearGradient backgroundGradient = const LinearGradient(
      colors: [
        Color.fromARGB(255, 70, 0, 86), // Morado
        Color(0xFFFF0080),             // Rosa intenso
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    // Contenedor negro para el formulario
    const Color containerColor = Colors.black;
    // "Tarjetas" más oscuras dentro del contenedor
    const Color cardColor = Color(0xFF1C1C1C);

    // Colores para el botón ACTIVO
    final Color buttonActiveColor = const Color.fromARGB(255, 246, 240, 255); 
    final Color buttonActiveTextColor = const Color.fromARGB(255, 51, 0, 54); 

    // Colores para el botón INACTIVO (disabled visual)
    final Color buttonInactiveColor = Colors.grey.shade600;
    final Color buttonInactiveTextColor = Colors.grey.shade300;

    // Determinar si están ambos campos llenos
    final bool allFieldsFilled = _allFieldsFilled;

    // Definir los colores actuales del botón según estado
    final Color currentButtonColor = allFieldsFilled ? buttonActiveColor : buttonInactiveColor;
    final Color currentButtonTextColor = allFieldsFilled ? buttonActiveTextColor : buttonInactiveTextColor;

    return Scaffold(
      // El fondo degradado ocupa toda la pantalla
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        // Column principal que separa:
        // 1) Zona superior con el logo
        // 2) Zona inferior (contenedor negro con formulario y botón)
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // -----------------------------------------------------------------
              // PARTE SUPERIOR: Logo grande con espacio
              // -----------------------------------------------------------------
              const SizedBox(height: 40),
              Image.asset(
                'assets/ByKon Logo.png',
                width: 280, // Logo grande
              ),
              const SizedBox(height: 24),

              // -----------------------------------------------------------------
              // PARTE INFERIOR: Contenedor negro con formulario + botón
              // -----------------------------------------------------------------
              Expanded(
                child: Container(
                  // Borde redondeado solo en la parte de arriba
                  decoration: const BoxDecoration(
                    color: containerColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  // Para ubicar formulario y botón dentro
                  child: Column(
                    children: [
                      // 1) Formulario scrolleable
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 24,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Texto: "Inicia sesión con tu correo de ByKon"
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 36.0),
                                  child: Text(
                                    'Inicia sesión con tu correo\nde ByKon',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // Campo: Correo
                              Container(
                                height: 90.0,
                                margin: const EdgeInsets.only(bottom: 32.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: TextField(
                                  controller: _emailController,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Correo',
                                    labelStyle: TextStyle(color: Colors.grey, fontSize: 24),
                                    hintText: 'ejemplo@bykon.com.mx',
                                    hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                                  ),
                                ),
                              ),

                              // Campo: Contraseña
                              Container(
                                height: 90.0,
                                margin: const EdgeInsets.only(bottom: 8.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                decoration: BoxDecoration(
                                  color: cardColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _passwordController,
                                        obscureText: !_passwordVisible,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Contraseña',
                                          labelStyle: TextStyle(color: Colors.grey, fontSize: 24),
                                          hintText: 'abj162@',
                                          hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _passwordVisible = !_passwordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _passwordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Row: “Recuérdame” + “Olvidé mi contraseña”
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: _rememberMe,
                                        onChanged: (bool? newValue) {
                                          setState(() {
                                            _rememberMe = newValue ?? false;
                                          });
                                        },
                                        // ignore: deprecated_member_use
                                        fillColor: MaterialStateProperty.all(
                                          const Color.fromARGB(89, 240, 175, 255),
                                        ),
                                        checkColor: const Color.fromARGB(255, 237, 166, 255),
                                      ),
                                      const Text(
                                        'Recuérdame',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Acción "Olvidé mi contraseña"
                                  // Navegar a ChangePasswordScreen
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          //builder: (context) => ChangePasswordScreen(),
                                         builder: (context) => ResetPasswordScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Olvidé mi contraseña',
                                      style: TextStyle(
                                        color: Colors.white,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 2) Botón “Iniciar sesión” al final, dentro del contenedor negro
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: currentButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            // El botón siempre tiene onPressed,
                            // pero si no están los campos llenos => SnackBar
                            onPressed: () async {
                              if (!allFieldsFilled) {
                                // Mostrar SnackBar: faltan datos
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: const [
                                        Icon(Icons.warning, color: Color.fromARGB(255, 255, 219, 166)),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text('Por favor, llena correo y contraseña'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
//--------------------------------------------------------------------------
                                  final loginResponse = await 
                                                LoginService.login(
                                                  _emailController.text,
                                                  _passwordController.text
                                                );
                                      if (loginResponse != null) {                                         
                                // Están completos => navegamos a Home
                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => HomeScreen(
                                                            name: loginResponse.user.fullName, jobPosition: loginResponse.user.jobPosition
                                                        ),
                                                      ),
                                                    );
                                                }
                                               );
                                              } 
                                            }
                                          },
//--------------------------------------------------------------------------       
                            child: Text(
                              'Iniciar sesión',
                              style: TextStyle(
                                color: currentButtonTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  
}
