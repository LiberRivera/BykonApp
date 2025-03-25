import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'resumen.dart';

class IncidenciasVacacionesScreen extends StatefulWidget {
  const IncidenciasVacacionesScreen({super.key});

  @override
  State<IncidenciasVacacionesScreen> createState() => _IncidenciasVacacionesScreenState();
}

class _IncidenciasVacacionesScreenState extends State<IncidenciasVacacionesScreen> {
  // Lista de fechas seleccionadas
  List<DateTime> _selectedDates = [];

  // Texto que se muestra en “Escoge tus días”
  // Lo mostraremos multiline, por eso `maxLines: null`
  String _selectedRangeText = 'Días';

  // Control para habilitar el botón
  bool _isButtonActive = false;

  @override
  Widget build(BuildContext context) {
    // Colores para el botón
    final Color buttonActiveColor = const Color.fromARGB(255, 255, 222, 255);
    final Color buttonInactiveColor = Colors.grey;
    final Color buttonActiveTextColor = Colors.black;
    final Color buttonInactiveTextColor = Colors.white;

    final Color currentButtonColor =
        _isButtonActive ? buttonActiveColor : buttonInactiveColor;
    final Color currentButtonTextColor =
        _isButtonActive ? buttonActiveTextColor : buttonInactiveTextColor;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.transparent,

      // AppBar negro redondeado
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
                  'Agendar vacaciones',
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

      // Fondo degradado
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
            const SizedBox(height: 180),

            // Contenedor negro
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
                    // Scroll
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Ejemplo: "Días disponibles"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Días disponibles',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Ej: refrescar
                                  },
                                  icon: const Icon(
                                    Icons.hourglass_bottom,
                                    size: 40,
                                    color: Color.fromARGB(255, 241, 200, 255),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),

                            const Text(
                              '12 días',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 36,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Vigencia: {{fecha}}',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 24),

                            const Text(
                              'Nueva incidencia',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Texto “Recuerda consultar las políticas…”
                            RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                ),
                                children: [
                                  TextSpan(text: 'Recuerda consultar '),
                                  TextSpan(
                                    text: 'las políticas',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 255, 184, 255),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  TextSpan(text: ' para poder realizar tu trámite.'),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Campo 1: Solicitud
                            Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(0xFF1C1C1C),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Solicitud',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Vacaciones',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Escoge tus días
                            Container(
                              margin: const EdgeInsets.only(bottom: 16.0),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                color: Color(0xFF1C1C1C),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  // Desplegamos en multiline
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Escoge tus días',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 18,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      // AQUI MOSTRAMOS MULTILINE
                                      SizedBox(
                                        width: 200, // Ajusta según tu layout
                                        child: Text(
                                          _selectedRangeText,
                                          maxLines: null,
                                          softWrap: true,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () => _showMultiDatePicker(),
                                    icon: const Icon(
                                      Icons.calendar_today,
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

                    // Botón "Continuar"
                    Padding(
                      padding: const EdgeInsets.all(16.0),
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
                          onPressed: () {
                            if (!_isButtonActive) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Row(
                                    children: const [
                                      Icon(Icons.warning, color: Colors.white),
                                      SizedBox(width: 8),
                                      Expanded(
                                        child: Text('Por favor, selecciona tus días de vacaciones'),
                                      ),
                                    ],
                                  ),
                                  backgroundColor: Colors.grey[800],
                                ),
                              );
                            } else {
                              // Lógica real: Navegar a Resumen, etc.
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ResumenScreen(
                                    fechaInicio: '...',
                                    fechaFin: '...',
                                  ),
                                ),
                              );
                            }
                          },
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
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Abre un dialog con SfDateRangePicker en modo multiple
  void _showMultiDatePicker() {
    // Copiamos la selección previa
    List<DateTime> tempDates = List.from(_selectedDates);

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Selecciona tus días'),
          content: SizedBox(
            width: 300,
            height: 400,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.multiple,
              initialSelectedDates: tempDates,
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is List<DateTime>) {
                  tempDates = args.value;
                }
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('CANCELAR'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _selectedDates = tempDates;
                  _isButtonActive = _selectedDates.isNotEmpty;
                  // Agrupamos por mes/año en multiline
                  _selectedRangeText = _formatDatesGrouped(_selectedDates);
                });
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  /// Agrupa por mes y año => múltiples líneas
  String _formatDatesGrouped(List<DateTime> dates) {
    if (dates.isEmpty) return 'Días';
    dates.sort((a,b) => a.compareTo(b));

    // Map "abril 2025" => [23, 24, 25]
    final Map<String, List<int>> grouped = {};

    for (final date in dates) {
      // "MMMM yyyy" => "abril 2025"
      final key = DateFormat('MMMM yyyy', 'es').format(date).toLowerCase();
      grouped.putIfAbsent(key, () => []);
      grouped[key]!.add(date.day);
    }

    // Convertimos cada "mes año" => "Abril 23, 24, 25 de 2025"
    final lines = <String>[];

    grouped.forEach((monthYear, days) {
      days.sort();
      final daysString = days.join(', ');

      // parted => ["abril", "2025"]
      final parted = monthYear.split(' ');
      final theMonth = parted[0]; // "abril"
      final theYear = parted[1];  // "2025"

      // Primera letra mayúscula
      final capitalMonth = '${theMonth[0].toUpperCase()}${theMonth.substring(1)}';
      // "Abril 23, 24, 25 de 2025"
      final line = '$capitalMonth $daysString de $theYear';

      lines.add(line);
    });

    // Unir con saltos de línea
    // Ej: 
    // Abril 23, 24, 25 de 2025
    // Mayo 2, 5 de 2025
    return lines.join('\n');
  }
}
