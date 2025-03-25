import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ChangeCreateNewPassword/create_new_password_screen.dart';
import '../Common/commonFunctions.dart';
import 'package:mi_app/ResetPassword/send_reset_code_service.dart';


// Importa la pantalla ChangePassword

class SetCodeVerificationScreen extends StatefulWidget {
  final String email;
  final String token;
  final String user_code;
  const SetCodeVerificationScreen({super.key, required this.email, required this.token,required this.user_code});

  @override
  // ignore: no_logic_in_create_state
  State<SetCodeVerificationScreen> createState() => _SetCodeVerificationScreen(email: email, token:token, user_code: user_code );
}

class _SetCodeVerificationScreen extends State<SetCodeVerificationScreen> {
    //'email' se pasa como argumento al widget
  final String email;
  final String token;                            
  String user_code;

  String obfuscatedEmail =''; // Inicializar con un valor por defecto
  String user_code_screen = ''; // Variable para almacenar los seis valores

  int _remainingTime = 900; // Tiempo en segundos
  late Timer _timer;

  //6 CodeTexts
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  void _nextField(int index, String value) {
    if (value.length == 1 && index < _focusNodes.length - 1) {
      FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
    }
  }
  _SetCodeVerificationScreen({required this.email, required this.token, required this.user_code}); // Constructor para recibir el email


   //final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    obfuscatedEmail = CommonFunctions.obfuscateEmail(email);
    startTimer();
  }

  //control Timer
  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer.cancel();
        }
      });
    });
  }
  void resetTimer() {
    setState(() {
      _remainingTime = 900; // Reiniciar el tiempo a 15 minutos
    });
    _timer.cancel();
    startTimer();
  }

   @override
  void dispose() {
    _timer.cancel();

    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
        controller.dispose();
    }
    super.dispose();
  }

  void _onFieldChange() {
    // Cada vez que cambian los campos, se reconstruye la UI
    setState(() {});
  }
  


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
    //const Color cardColor = Color(0xFF1C1C1C);

    // Colores para el botón ACTIVO
    final Color buttonActiveColor = const Color.fromARGB(255, 246, 240, 255); 
    final Color buttonActiveTextColor = const Color.fromARGB(255, 51, 0, 54); 

    // Colores para el botón INACTIVO (disabled visual)
    final Color buttonInactiveColor = Colors.grey.shade600;
    final Color buttonInactiveTextColor = Colors.grey.shade300;

    // Determinar si el email no es vacio y está bien formado
    final bool emailFieldWellDoneFilled = true;

    // Definir los colores actuales del botón según estado
    final Color currentButtonColor = emailFieldWellDoneFilled ? buttonActiveColor : buttonInactiveColor;
    final Color currentButtonTextColor = emailFieldWellDoneFilled ? buttonActiveTextColor : buttonInactiveTextColor;
    
    // Calcular minutos y segundos restantes
    final int minutes = _remainingTime ~/ 60;
    final int seconds = _remainingTime % 60;
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
                              // Texto: "Escribe el código de verificación que enviamos a:"
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: Text(
                                    'Escribe el código de\nverificación que enviamos a:',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              // Texto: correo ofuscado
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: Text(
                                    obfuscatedEmail,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),

//--------------------textFields 6 digits----------------
                            Center(
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: List.generate(
                                      6,
                                      (index) => SizedBox(
                                        width: 60,
                                        height: 72,
                                        child: TextFormField(
                                          controller: _controllers[index],
                                          focusNode: _focusNodes[index],
                                          textAlign: TextAlign.center,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: [
                                            LengthLimitingTextInputFormatter(1),
                                            FilteringTextInputFormatter.digitsOnly,
                                          TextInputFormatter.withFunction((oldValue, newValue) {
                                            if (newValue.text.isNotEmpty) {
                                              Future.delayed(const Duration(milliseconds: 500), () {
                                                _controllers[index].text = '•';
                                                _controllers[index].selection = TextSelection.collapsed(offset: 1);
                                              });
                                              return newValue;
                                            }
                                            return newValue;
                                          }),
                                          ],
                                          style: const TextStyle(color: Colors.white, fontSize: 20),
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color(0xFF331D4F), // Darker purple input background
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: _focusNodes[index].hasFocus ? Colors.white : Colors.transparent, // Highlight the focused field
                                                width: 2.0,
                                                ),
                                            ),
                                            enabledBorder: OutlineInputBorder( // Add this for when the field is not focused
                                              borderRadius: BorderRadius.circular(8),
                                                borderSide: BorderSide(
                                                  color: _focusNodes[index].hasFocus ? Colors.white : Colors.transparent, // Highlight the focused field
                                                  width: 2.0,
                                                ),
                                            ),
                                            focusedBorder: OutlineInputBorder( // Add this for when the field is focused
                                              borderRadius: BorderRadius.circular(8),
                                              borderSide: BorderSide(
                                                color: _focusNodes[index].hasFocus ? Colors.white : Colors.transparent, // Highlight the focused field
                                                width: 2.0,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            _nextField(index, value);
                                            if (value.isEmpty && index > 0) {
                                              FocusScope.of(context).requestFocus(_focusNodes[index - 1]);
                                            }
                                          // Actualizar user_code_screen
                                            setState(() {
                                              user_code_screen = _controllers.map((controller) => controller.text).join('.');
                                            });
                                          },
                                          onTap: () {
                                            setState(() {
                                              // Actualizar el estado para resaltar el campo enfocado
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
//-------------------------------------------------------                             
                              // Timer: 'Tu código de seguridad vence en: 00:45'
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
                                  child: Text(
                                    'Tu código de seguridad vence en: ${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 2) Botón “Continuar” , dentro del contenedor negro
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
//----------------Click en boton continuar----------------                            
                            onPressed: () async {
//                            if (CommonFunctions.isValidUserCode(user_code_screen) && user_code_screen == user_code && _remainingTime > 0)
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => 
                                  CreateNewPasswordScreen(token: token, user_code: user_code)),
                                );
                            },
//--------------------------------------------------------------------------       
                            child: Text(
                              'Continuar',
                              style: TextStyle(
                                color: currentButtonTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),


                  // 3) Botón “Reenviar código” al final, dentro del contenedor negro
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white, // Color del texto y del contorno
                                side: BorderSide(color: Colors.white), // Color del contorno
                              backgroundColor: containerColor,//currentButtonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.all(16),
                            ),
                            // El botón siempre tiene onPressed,
                            // pero si no están los campos llenos => SnackBar
                            onPressed: () async {
                              final sendResetCodeResponse = await 
                                                SendResetPassword.send_reset_code(
                                                  email
                                                );
                                  if (sendResetCodeResponse != null) {    
                                    user_code = sendResetCodeResponse.userCode;
                                    resetTimer(); // Reiniciar el timer
                                  // Limpiar todos los campos de código
                                      for (var controller in _controllers) {
                                        controller.clear();
                                        }
                                        setState(() {
                                          user_code_screen = '';
                                        });
                                      // Posicionar el cursor en el primer controlador
                                      FocusScope.of(context).requestFocus(_focusNodes[0]);
                                    }              
                                  },
//--------------------------------------------------------------------------       
                            child: Text(
                              'Reenviar código',
                              style: TextStyle(
                                color: Colors.white,
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
