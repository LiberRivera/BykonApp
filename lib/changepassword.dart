import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _currentPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_onFieldChange);
    _newPasswordController.addListener(_onFieldChange);
    _confirmPasswordController.addListener(_onFieldChange);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onFieldChange() {
    setState(() {});
  }

  bool get _allFieldsFilled =>
      _currentPasswordController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool visible,
    required VoidCallback onVisibilityToggle,
    required Color cardBackgroundColor,
    required Color textColor,
    required Color hintTextColor,
    required Color iconColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: cardBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: !visible,
              style: TextStyle(color: textColor, fontSize: 16.0),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: label,
                hintStyle: TextStyle(color: hintTextColor, fontSize: 16.0),
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              visible ? Icons.visibility : Icons.visibility_off,
              color: iconColor,
            ),
            onPressed: onVisibilityToggle,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Gradiente de fondo
    final LinearGradient backgroundGradient = const LinearGradient(
      colors: [Color(0xFF33004C), Color(0xFFFF2D6A)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    final Color cardBackgroundColor = const Color(0xFF1C1C1C);
    final Color textColor = Colors.white;
    final Color hintTextColor = Colors.grey;
    final Color iconColor = const Color(0xFFBFBFBF);

    // Botón: color de fondo cuando activo e inactivo
    final Color buttonActiveColor = const Color(0xFFF6D0FF);
    final Color buttonActiveTextColor = const Color(0xFF330036);
    final Color buttonInactiveColor = Colors.grey.shade600;
    final Color buttonInactiveTextColor = Colors.grey.shade300;

    final bool allFieldsFilled = _allFieldsFilled;

    // Escoge colores según estado
    final Color currentButtonColor =
        allFieldsFilled ? buttonActiveColor : buttonInactiveColor;
    final Color currentButtonTextColor =
        allFieldsFilled ? buttonActiveTextColor : buttonInactiveTextColor;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: backgroundGradient),
        child: Column(
          children: [
            // ------------------ AppBar ------------------
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                color: Colors.black,
                child: SafeArea(
                  bottom: false,
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 60),

            // ------------------ Contenedor negro ------------------
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Column(
                  children: [
                    // Campos scrolleables
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 24.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Campo: Contraseña actual
                            _buildPasswordField(
                              label: 'Contraseña actual',
                              controller: _currentPasswordController,
                              visible: _currentPasswordVisible,
                              onVisibilityToggle: () {
                                setState(() {
                                  _currentPasswordVisible = !_currentPasswordVisible;
                                });
                              },
                              cardBackgroundColor: cardBackgroundColor,
                              textColor: textColor,
                              hintTextColor: hintTextColor,
                              iconColor: iconColor,
                            ),
                            const SizedBox(height: 8),

                            // ¿Olvidaste tu contraseña?
                            GestureDetector(
                              onTap: () {
                                // Acción "Olvidé mi contraseña"
                              },
                              child: Text(
                                '¿Olvidaste tu contraseña?',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 214, 129, 253),
                                  fontSize: 16,
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Campo: Nueva contraseña
                            _buildPasswordField(
                              label: 'Nueva contraseña',
                              controller: _newPasswordController,
                              visible: _newPasswordVisible,
                              onVisibilityToggle: () {
                                setState(() {
                                  _newPasswordVisible = !_newPasswordVisible;
                                });
                              },
                              cardBackgroundColor: cardBackgroundColor,
                              textColor: textColor,
                              hintTextColor: hintTextColor,
                              iconColor: iconColor,
                            ),
                            const SizedBox(height: 8),

                            // Info “Debe tener una mayúscula...”
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.info_outline, color: Color.fromARGB(255, 255, 255, 255), size: 16),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Debe tener una mayúscula, 8 caracteres mínimo y un caracter especial ("@#")',
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            // Campo: Confirmar contraseña
                            _buildPasswordField(
                              label: 'Confirmar contraseña',
                              controller: _confirmPasswordController,
                              visible: _confirmPasswordVisible,
                              onVisibilityToggle: () {
                                setState(() {
                                  _confirmPasswordVisible = !_confirmPasswordVisible;
                                });
                              },
                              cardBackgroundColor: cardBackgroundColor,
                              textColor: textColor,
                              hintTextColor: hintTextColor,
                              iconColor: iconColor,
                            ),

                            const SizedBox(height: 32),
                          ],
                        ),
                      ),
                    ),

                    // ------------------ BOTÓN al final ------------------
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
                          // onPressed => manejamos la lógica
                          onPressed: () {
                            if (!allFieldsFilled) {
                              // Campos incompletos => Warning Icon
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(Icons.warning, color: Color.fromARGB(255, 255, 219, 166)),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text('Por favor, llena todos los campos'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              // Campos llenos => Check Icon
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(Icons.check_circle, color: Color.fromARGB(255, 130, 255, 163)),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text('La contraseña se ha guardado con éxito'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                              // Acción real si todo está lleno
                              // ...
                            }
                          },
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
