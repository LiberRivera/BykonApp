import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../ChangeCreateNewPassword/create_new_password_screen.dart';
import '../Common/commonFunctions.dart';
import 'package:mi_app/ResetPassword/send_reset_code_service.dart';

// Importa la pantalla ChangePassword

class SetCodeVerificationScreen extends StatefulWidget {
  final String email;
  String token;
  String userCode;

  SetCodeVerificationScreen({super.key, required this.email,required this.token, required this.userCode});

  @override
  // ignore: no_logic_in_create_state
  State<SetCodeVerificationScreen> createState() => _SetCodeVerificationScreenState();
}

class _SetCodeVerificationScreenState extends State<SetCodeVerificationScreen> {
  late String token; 
  late String userCode; 
  String obfuscatedEmail =''; // Inicializar con un valor por defecto
  String userCodeScreen = ''; // Variable para almacenar los seis valores ofuscados con puntos
  List<String> userCodeScreenNoObfuscated = List.filled(6, ''); // Lista para almacenar los seis valores no ofuscados

  int _remainingTime = 900; // Tiempo en segundos
  late Timer _timer;

  //6 CodeTexts
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());

  @override
  void initState() {
    super.initState();
    token = widget.token;
    userCode = widget.userCode;
    obfuscatedEmail = CommonFunctions.obfuscateEmail(widget.email);
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

  //void _onFieldChange() {setState(() {});}// Cada vez que cambian los campos, se reconstruye la UI
  


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
              const SizedBox(height: 25),
              Image.asset(
                'assets/ByKon Logo.png',
                width: 240, // Logo grande
              ),
              const SizedBox(height: 20),

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
            const SizedBox(height: 28),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                6,
                (index) => SizedBox(
                  width: 50,
                  height: 80,
                  child: TextField(
                    controller: _controllers[index], // Controlador para manejar el texto
                    focusNode: _focusNodes[index], // Nodo de foco para manejar el foco
                    textAlign: TextAlign.center, // Centrar el texto
                    keyboardType: TextInputType.number, // Solo números
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(1), // Limitar a un carácter
                      FilteringTextInputFormatter.digitsOnly, // Solo dígitos
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
                    style: const TextStyle(color: Colors.white, fontSize: 24), // Estilo del texto
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:// Colors.grey[800], //fillColor: Colors.grey[800], // Fondo gris oscuro
                            _focusNodes[index].hasFocus && index < _focusNodes.length - 1 ? Colors.white : Colors.grey[800],
                         
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(
                          color: _focusNodes[index].hasFocus ? Colors.white : Colors.transparent, // Resaltar el borde si está enfocado
                          width: 2.0,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.transparent), // Borde transparente cuando no está enfocado
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.white, width: 2.0), // Borde blanco cuando está enfocado
                      ),
                    ),
                    onChanged: (value) {
                      // Mover al siguiente campo si se ingresa un carácter
                      if (value.length == 1 && index < _focusNodes.length - 1) {
                        FocusScope.of(context).requestFocus(_focusNodes[index + 1]);
                      }
                      // Actualizar el valor en la lista
                      setState(() {
                        userCodeScreen = _controllers.map((controller) => controller.text).join('.');
                        userCodeScreenNoObfuscated[index] = value;
                         
                        //_hasValue[index] = value.isNotEmpty;
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
            padding: const EdgeInsets.only(top: 5.0, left: 24.0,right: 24.0, bottom: 24.0),
            //padding: const EdgeInsets.all(24.0),
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
//--------------k en boton continuar----------------                            
                onPressed: () async {
                 String userCodeAsString = userCodeScreenNoObfuscated.join();
                      if (CommonFunctions.isValidUserCode(userCodeAsString) && userCodeAsString == widget.userCode && _remainingTime > 3){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => 
                           ChangePasswordScreen(token: widget.token,userCode: widget.userCode)),
                          );
                    } //else codigo incorrecto
                else {
                    // Mostrar SnackBar: código incorrecto
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Row(
                          children: const [
                            Icon(Icons.warning, color: Color.fromARGB(255, 255, 219, 166)),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text('Código incorrecto'),
                            ),
                          ],
                        ),
                        backgroundColor: const Color(0xFF4D4D4D), // Fondo negro como en la imagen
                        behavior: SnackBarBehavior.floating, 
                            margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), // Centrar horizontalmente y ajustar verticalmente
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
                            ),// Flotante como en la imagen
                      ),
                    );
                  }
                },
//--------------------------------------------------------------------       
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
                        padding: const EdgeInsets.only(top: 5.0, left: 24.0,right: 24.0),
                        //padding: const EdgeInsets.all(24.0),
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
                                  final sendResetCodeResponse = await sendResetCode(widget.email);
                                  if (sendResetCodeResponse != null) {
                                    widget.token = sendResetCodeResponse.token;
                                    widget.userCode = sendResetCodeResponse.userCode;
                                        // Mostrar SnackBar de éxito
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: const [
                                                Icon(Icons.check_circle, color: Colors.green),
                                                SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    'Código de verificación enviado.',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            backgroundColor: const Color(0xFF4D4D4D), // Fondo negro como en la imagen
                                            behavior: SnackBarBehavior.floating, 
                                                margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0), // Centrar horizontalmente y ajustar verticalmente
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(10.0), // Bordes redondeados
                                                ),// Flotante como en la imagen
                                          ),
                                        );
                                    // 
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SetCodeVerificationScreen(
                                          email: widget.email,
                                          token: widget.token,
                                          userCode: sendResetCodeResponse.userCode, // Pasar el nuevo valor de userCode
                                        ),
                                      ),
                                    );
                                    resetTimer(); // Reiniciar el timer
                                  // Limpiar todos los campos de código
                                      for (var controller in _controllers) {
                                        controller.clear();
                                        }
                                        setState(() {
                                          userCodeScreen = '';
                                          userCodeScreenNoObfuscated = List.filled(6, '');
                                        });
                                      // Posicionar el cursor en el primer controlador
                                      FocusScope.of(context).requestFocus(_focusNodes[0]);
                                    }  else {
    // Mostrar SnackBar si ocurre un error
                                       ScaffoldMessenger.of(context).showSnackBar(
                                         const SnackBar(
                                           content: Text('Error al reenviar el código. Inténtalo de nuevo.'),
                                         ),
                                       );
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


