import 'package:flutter/material.dart';
// Importa tu pantalla de cambiar contraseña
import 'changepassword.dart'; // Ajusta la ruta según tu estructura de archivos

class ConfigurationScreen extends StatefulWidget {
  const ConfigurationScreen({super.key});

  @override
  State<ConfigurationScreen> createState() => _ConfigurationScreenState();
}

class _ConfigurationScreenState extends State<ConfigurationScreen> {
  // Variables para los Switch
  bool isBiometricEnabled = true;
  bool isNotificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    // ------------------- PARÁMETROS DE ESTILO -------------------
    // Degradado de fondo
    final LinearGradient backgroundGradient = const LinearGradient(
      colors: [
        Color(0xFF33004C), // Morado oscuro
        Color(0xFFFF2D6A), // Rosa fuerte
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    // AppBar personalizado
    final Color appBarColor = Colors.black;
    final Color appBarIconColor = Colors.white;
    final double appBarBottomRadius = 10.0; // Borde redondeado inferior
    final String appBarTitle = 'Configuración';
    final double appBarTitleSize = 20.0;
    final Color appBarTitleColor = Colors.white;

    // **Espacio fijo** para que se vea el degradado
    final double spaceBetweenAppBarAndContainer = 80.0; 

    // Contenedor negro (para las tarjetas)
    final double containerTopRadius = 16.0;  
    final Color containerColor = Colors.black;

    // Tarjetas
    final Color cardBackgroundColor = const Color(0xFF1C1C1C);
    final double cardBorderRadius = 8.0;
    final double cardPadding = 16.0;
    final Color iconColor = const Color(0xFFD9B3FF);
    final double iconSize = 32.0;
    final Color textColor = Colors.white;
    final double textSize = 18.0;

    // Switch
    final Color switchActiveColor = Colors.white;
    final Color switchActiveTrackColor = const Color(0xFF9E00FF);
    final Color switchInactiveThumbColor = Colors.white;
    final Color switchInactiveTrackColor = Colors.grey;

    // Botón “Cerrar sesión”
    final Color buttonBackgroundColor = Colors.black;
    final Color buttonTextColor = const Color.fromARGB(255, 242, 224, 254);
    final double buttonFontSize = 18.0;
    final Color buttonBorderColor = const Color.fromARGB(255, 242, 224, 254);
    final double buttonBorderWidth = 2.0;
    final double buttonBorderRadius = 30.0;
    final double buttonPadding = 16.0;
    // ------------------------------------------------------------

    return Scaffold(
      // Quitamos color sólido para mostrar el degradado
      body: Container(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: Column(
          children: [
            // ------------------------------------------------------------
            // AppBar "Personalizado" con bordes redondeados abajo
            // ------------------------------------------------------------
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(appBarBottomRadius),
                bottomRight: Radius.circular(appBarBottomRadius),
              ),
              child: Container(
                color: appBarColor,
                child: SafeArea(
                  bottom: false,
                  child: SizedBox(
                    height: kToolbarHeight,
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.arrow_back, color: appBarIconColor),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          appBarTitle,
                          style: TextStyle(
                            color: appBarTitleColor,
                            fontSize: appBarTitleSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // ------------------------------------------------------------
            // Espacio fijo para que se vea el degradado
            // ------------------------------------------------------------
            SizedBox(height: spaceBetweenAppBarAndContainer),

            // ------------------------------------------------------------
            // Contenedor negro con bordes redondeados arriba
            // ------------------------------------------------------------
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(containerTopRadius),
                    topRight: Radius.circular(containerTopRadius),
                  ),
                ),
                child: Column(
                  children: [
                    // Scroll para las tarjetas
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 24.0,
                        ),
                        child: Column(
                          children: [
                            // Tarjeta 1: "Cambiar contraseña"
                            // Envuelta en GestureDetector (o InkWell) para que sea clicable
                            GestureDetector(
                              onTap: () {
                                // Navega a la pantalla de cambiar contraseña
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ChangePasswordScreen(), 
                                  ),
                                );
                              },
                              child: Container(
                                height: 80.0,
                                margin: const EdgeInsets.only(bottom: 24.0),
                                padding: EdgeInsets.all(cardPadding),
                                decoration: BoxDecoration(
                                  color: cardBackgroundColor,
                                  borderRadius:
                                      BorderRadius.circular(cardBorderRadius),
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.lock,
                                        color: iconColor, size: iconSize),
                                    const SizedBox(width: 16),
                                    Text(
                                      'Cambiar contraseña',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: textSize,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // Tarjeta 2: "Ingresar con huella o rostro"
                            Container(
                              margin: const EdgeInsets.only(bottom: 24.0),
                              padding: EdgeInsets.all(cardPadding),
                              decoration: BoxDecoration(
                                color: cardBackgroundColor,
                                borderRadius:
                                    BorderRadius.circular(cardBorderRadius),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.fingerprint,
                                      color: iconColor, size: iconSize),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      'Ingresar con huella o rostro',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: textSize,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                    value: isBiometricEnabled,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isBiometricEnabled = value;
                                      });
                                    },
                                    activeColor: switchActiveColor,
                                    activeTrackColor: switchActiveTrackColor,
                                    inactiveThumbColor:
                                        switchInactiveThumbColor,
                                    inactiveTrackColor:
                                        switchInactiveTrackColor,
                                  ),
                                ],
                              ),
                            ),

                            // Tarjeta 3: "Notificaciones"
                            Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              padding: EdgeInsets.all(cardPadding),
                              decoration: BoxDecoration(
                                color: cardBackgroundColor,
                                borderRadius:
                                    BorderRadius.circular(cardBorderRadius),
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.notifications,
                                      color: iconColor, size: iconSize),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      'Notificaciones',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: textSize,
                                      ),
                                    ),
                                  ),
                                  Switch(
                                    value: isNotificationsEnabled,
                                    onChanged: (bool value) {
                                      setState(() {
                                        isNotificationsEnabled = value;
                                      });
                                    },
                                    activeColor: switchActiveColor,
                                    activeTrackColor: switchActiveTrackColor,
                                    inactiveThumbColor:
                                        switchInactiveThumbColor,
                                    inactiveTrackColor:
                                        switchInactiveTrackColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Botón "Cerrar sesión"
                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonBackgroundColor,
                            side: BorderSide(
                              color: buttonBorderColor,
                              width: buttonBorderWidth,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(buttonBorderRadius),
                            ),
                            padding: EdgeInsets.all(buttonPadding),
                          ),
                          onPressed: () {
                            // Maneja aquí la acción de cerrar sesión
                          },
                          child: Text(
                            'Cerrar sesión',
                            style: TextStyle(
                              color: buttonTextColor,
                              fontSize: buttonFontSize,
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
    );
  }
}
