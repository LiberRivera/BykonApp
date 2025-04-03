import 'package:flutter/material.dart';
import 'package:mi_app/Login/login_screen.dart';
import '../Common/commonFunctions.dart';
import 'create_new_password_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../main.dart'; 

Future<void> main() async {
  await dotenv.load(fileName: ".env"); // Cargar variables de entorno
  runApp(MyApp());
}
class ChangePasswordScreen extends StatefulWidget {
    final String token;
  final String userCode;
  const ChangePasswordScreen({super.key, required this.token,required this.userCode});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
String token = '';
String userCode = '';

   final TextEditingController _newPasswordController = TextEditingController();
   final TextEditingController _confirmPasswordController = TextEditingController();

  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _hasInteractedWithNewPassword = false;

//_ChangePasswordScreenState();

  @override
  void initState() {
    super.initState();
    // Escuchamos cambios en ambos campos para refrescar el botón
    _newPasswordController.addListener(_onFieldChange);
    _confirmPasswordController.addListener(_onFieldChange);

    //_newPasswordController.text;// = "%h4rRyP0tt3r%"; 
    //_confirmPasswordController.text;// = "%h4rRyP0tt3r%"; 
  }
  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFieldChange() {
    // Cada vez que cambian los campos, se reconstruye la UI
    setState(() {
      _hasInteractedWithNewPassword = true; 
    });
  }
    
    // Verifica si el password es una formula-bien-formada
   bool get _allFieldsFilled =>
     _newPasswordController.text.isNotEmpty && CommonFunctions.isValidPassword(_newPasswordController.text); 
  // Verifica si ambos passwords coinciden
  bool get arePasswordsEqual =>
    _newPasswordController.text == _confirmPasswordController.text;
 
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

    // Determinar si el password no es vacio y está bien formado
    final bool allFieldsFilled = _allFieldsFilled;

    // Definir los colores actuales del botón según estado
    final Color currentButtonColor = allFieldsFilled && arePasswordsEqual? buttonActiveColor : buttonInactiveColor;
    final Color currentButtonTextColor = allFieldsFilled && arePasswordsEqual? buttonActiveTextColor : buttonInactiveTextColor;
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
                              // Texto: "Crea una nueva contraseña"
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.only(bottom: 24.0),
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

                              // Campo: nueva contraseña
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
                                          hintText: 'abj162@',
                                          hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                                        ),
                                                                            onChanged: (value) {
                                      setState(() {
                                        _hasInteractedWithNewPassword = true;
                                      });
                                    },
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
                              if (_hasInteractedWithNewPassword && _newPasswordController.text.length>5 && !_allFieldsFilled)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
                                      child: Row(
                                        children: const [
                                          Icon(Icons.info_outline, color: Colors.white70, size: 16),
                                          SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              'Debe tener una mayúscula, al menos 8 caracteres, mínimo un número y un carácter especial (“@#%)',
                                              style: TextStyle(color:  Color(0xFFFFE5EA), fontSize: 14),
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
                      // Mostrar cuadro de texto si las contraseñas no coinciden
                        if (_hasInteractedWithNewPassword && _confirmPasswordController.text.length>5 && !arePasswordsEqual)
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0, left: 32.0),
                            child: Row(
                              children: const [
                                Icon(Icons.warning, color: Colors.red, size: 16),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'La contraseña no coincide.',
                                    style: TextStyle(color: Color(0xFFFFE5EA), fontSize: 14),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      // 2) Botón “Guardar nueva contraseña” al final, dentro del contenedor negro
                      Padding(
                        padding: const EdgeInsets.only(left: 24.0,right: 24.0, bottom: 10.0),
                        //padding: const EdgeInsets.all(24.0),//padding: EdgeInsets.only(bottom: 24.0),
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
                                          child: Text('Por favor, llena correo'),
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
                              } else {
//--------------------------------------------------------------------------
                      if(arePasswordsEqual){
                              final sendChangePassword = await 
                                                SendChangePassword.changePassword(
                                                  widget.token,widget.userCode, _newPasswordController.text
                                                );
                                      if (sendChangePassword != null) {     
                                            // Mostrar SnackBar de éxito
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                const Icon(Icons.check_circle, color: Colors.green),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                   sendChangePassword.message, //'Contraseña guardada con éxito.',
                                                    style: const TextStyle(color: Colors.white),
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
                                // Están completos => navegamos a Home                          
                                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                                    Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) => LoginScreen(),
                                                      ),
                                                    );
                                                }
                                               );
                                              } else {
                                                //no se pudo cambiar la contraseña
                                                 ScaffoldMessenger.of(context).showSnackBar(
                                                    SnackBar(
                                                      content: Row(
                                                        children: const [
                                                          Icon(Icons.warning, color: Colors.red, size: 16),
                                                          SizedBox(width: 8),
                                                          Expanded(
                                                            child: Text('No se pudo guardar la contraseña. Inténtalo más tarde'),
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
                                         } 
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
                        padding: const EdgeInsets.only(left: 24.0,right: 24.0),
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
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Row(
                                              children: [
                                                Icon(Icons.warning, color: Color.fromARGB(255, 255, 219, 166)),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    'Cambio de contraseña cancelada.',
                                                    style: const TextStyle(color: Colors.white),
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
                                  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => LoginScreen()),
                                      );
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


