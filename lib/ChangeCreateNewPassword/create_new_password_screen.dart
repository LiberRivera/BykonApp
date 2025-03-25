// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:mi_app/ChangeCreateNewPassword/change_password_service.dart';
import '../Common/commonFunctions.dart';


class CreateNewPasswordScreen extends StatefulWidget {
  final String token;
  final String user_code;
  
  const CreateNewPasswordScreen({super.key, required this.token,required this.user_code});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState( token:token, user_code: user_code );
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final String token;                            
  String user_code;

  _CreateNewPasswordScreenState({required this.token, required this.user_code});

  final TextEditingController _newPasswordController =  TextEditingController();
  final TextEditingController _confirmPasswordController =  TextEditingController();

 bool _newPasswordVisible = true;
 bool _confirmPasswordVisible = true;
  @override
  void initState() {
    super.initState();
    // Escuchamos cambios en ambos campos para refrescar el botón
    _newPasswordController.addListener(_onFieldChange);
    _confirmPasswordController.addListener(_onFieldChange);
    
  }
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFieldChange() {
    // Cada vez que cambian los campos, se reconstruye la UI
    setState(() {});
  }
  
    // Verifica si el password es una formula-bien-formada
   bool get _isPasswordWellDone =>
     _newPasswordController.text.isNotEmpty && CommonFunctions.isValidPassword(_newPasswordController.text); 

 Map<String, dynamic>? resetPasswordResponse;
  bool isLoading = false;


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

    // Determinar si el confirmPassword no es vacio y está bien formado
    final bool newPasswordFieldWellDoneFilled = _isPasswordWellDone;


 
    // Definir los colores actuales del botón según estado
    final Color currentButtonColor = newPasswordFieldWellDoneFilled ? buttonActiveColor : buttonInactiveColor;
    final Color currentButtonTextColor = newPasswordFieldWellDoneFilled ? buttonActiveTextColor : buttonInactiveTextColor;
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
                              // Texto: "Crea una nueva contraseña"
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 36.0),
                                  child: Text(
                                    'Crea una nueva contraseña',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),

                              // Campo: Nueva contraseña
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
                                        controller: _newPasswordController,
                                        obscureText: !_newPasswordVisible,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Nueva contraseña',
                                          labelStyle: TextStyle(color: Colors.grey, fontSize: 24),
                                          hintText: 'Labj162@',
                                          hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _newPasswordVisible = !_newPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _newPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Campo: Confirmar contraseña
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
                                        controller: _confirmPasswordController,
                                        obscureText: !_confirmPasswordVisible,
                                        style: const TextStyle(color: Colors.white),
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          labelText: 'Confirmar contraseña',
                                          labelStyle: TextStyle(color: Colors.grey, fontSize: 24),
                                          hintText: 'abj162@',
                                          hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _confirmPasswordVisible = !_confirmPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _confirmPasswordVisible
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // 2) Botón “Guardar nueva contraseña” al final, dentro del contenedor negro                                          
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
                            onPressed: () async { //newPasswordFieldWellDoneFilled
                            if (CommonFunctions.arePasswordsEqual(
                                  _newPasswordController.text,
                                  _confirmPasswordController.text)){
                                          final changePasswordResponse = await 
                                                SendChangePassword.changePassword(
                                                 token,
                                                  user_code,
                                                  _newPasswordController.text
                                                );
                                  }else {
                                // Mostrar SnackBar: las contraseñas no coinciden
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Row(
                                      children: const [
                                        Icon(Icons.warning, color: Color.fromARGB(255, 255, 219, 166)),
                                        SizedBox(width: 8),
                                        Expanded(
                                          child: Text('Las contraseñas no coinciden'),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
//--------------------------------------------------------------------------       
                            child: Text(
                              'Guardar nueva contraseña',
                              style: TextStyle(
                                color: currentButtonTextColor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      // 3) Botón “Cancelar” al final, dentro del contenedor negro
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

              
                                  },
//--------------------------------------------------------------------------       
                            child: Text(
                              'Cancelar',
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

