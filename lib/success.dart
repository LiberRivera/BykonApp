import 'package:flutter/material.dart';
import 'main.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Permite que el body se extienda detrás del AppBar
      extendBodyBehindAppBar: true,
      // Fondo transparente para ver el gradiente
      backgroundColor: Colors.transparent,

      // ----------------------------
      // AppBar negro con esquinas redondeadas
      // ----------------------------
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          child: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            title: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  'Incidencias y vacaciones',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),

      // ----------------------------
      // Cuerpo con fondo degradado
      // ----------------------------
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 51, 0, 76),
              Color(0xFFFF2D6A),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            // Espacio para ver el degradado debajo del AppBar
            const SizedBox(height: 180),

            // ----------------------------
            // Contenedor negro
            // ----------------------------
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
                    // Contenido (scroll si pantalla pequeña)
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 160,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Ícono check en un círculo verde claro
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 175, 255, 184),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check,
                                size: 60,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Título
                            const Text(
                              '¡Tu solicitud ha sido enviada!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Subtexto
                            const Text(
                              'Hemos recibido tu solicitud de vacaciones. '
                              'Te mantendremos informado del status de tu solicitud '
                              'mediante notificaciones.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Link "Ver solicitud"
                            GestureDetector(
                              onTap: () {
                                // Acción: p.ej. abrir detalle
                              },
                              child: const Text(
                                'Ver solicitud',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 255, 184, 255),
                                  fontSize: 18,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ----------------------------
                    // Botón al final: "Ir al Home"
                    // ----------------------------
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 255, 222, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.all(16),
                          ),
                          onPressed: () {
                            // Navegar al Home. 
                            // O "pushReplacement", "popUntil"...
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>  HomeScreen(name: 'NOMBRE2', jobPosition: 'POSICION2'),
                              ),
                            );
                          },
                          child: const Text(
                            'Ir al Home',
                            style: TextStyle(
                              color: Colors.black,
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
