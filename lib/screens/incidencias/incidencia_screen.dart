import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class IncidenciaFormScreen extends StatefulWidget {
  const IncidenciaFormScreen({super.key});

  @override
  _IncidenciaFormScreenState createState() => _IncidenciaFormScreenState();
}

class _IncidenciaFormScreenState extends State<IncidenciaFormScreen> {
  final TextEditingController _roomNumberController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedProfessor = '';
  DateTime _selectedDate = DateTime.now();

  // Ejemplo de datos para el historial de incidencias
  final List<Map<String, String>> _incidenciasHistorico = [
    {
      "fecha": "01/11/2023",
      "descripcion": "Problema con el proyector",
      "aula": "101",
      "profesor": "fbenchi274@g.educaand.es",
    },
    {
      "fecha": "15/10/2023",
      "descripcion": "Ventana rota",
      "aula": "202",
      "profesor": "fbenchi274@g.educaand.es",
    },
    {
      "fecha": "05/10/2023",
      "descripcion": "Aire acondicionado no funciona",
      "aula": "303",
      "profesor": "fbenchi274@g.educaand.es",
    },
  ];

  // Método para enviar el formulario
  Future<void> _submitForm() async {
    String roomNumber = _roomNumberController.text;
    String description = _descriptionController.text;
    String professor = _selectedProfessor;
    DateFormat('dd/MM/yyyy').format(_selectedDate);

    // Validación de campos
    if (roomNumber.isEmpty || professor.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    // Agregar nueva incidencia al historial
    setState(() {
      _incidenciasHistorico.insert(0, {
        "fecha": DateFormat('dd/MM/yyyy').format(_selectedDate),
        "descripcion": description,
        "aula": roomNumber,
        "profesor": professor,
      });
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Incidencia enviada.')),
    );

    // Limpiar los campos después de enviar
    _roomNumberController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDate = DateTime.now();
      _selectedProfessor = '';
    });
  }

  // Método para seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Función para mostrar el popup con el historial de incidencias en forma de tabla
void _showHistoricoIncidencias() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // Obtener las dimensiones de la pantalla
      double screenWidth = MediaQuery.of(context).size.width;
      double screenHeight = MediaQuery.of(context).size.height;

      // Determinar un ancho adecuado para el diálogo
      double dialogWidth = screenWidth * 0.8; // 80% del ancho de la pantalla
      double dialogHeight = screenHeight * 0.7; // 70% del alto de la pantalla

      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Bordes redondeados
        ),
        title: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(4, 78, 144, 1), // Fondo oscuro
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Historial de Incidencias',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        content: SizedBox(
          width: dialogWidth, // Ancho dinámico
          height: dialogHeight, // Alto dinámico
          child: SingleChildScrollView(
            child: DataTable(
              headingRowHeight: 50, // Alto de la fila de encabezado
              columnSpacing: 20, // Espaciado entre las columnas
              horizontalMargin: 12, // Margen horizontal
              columns: const [
                DataColumn(
                  label: Text(
                    'Fecha',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Aula',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Profesor',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Descripción',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
              rows: _incidenciasHistorico.map((incidencia) {
                bool isEven = _incidenciasHistorico.indexOf(incidencia) % 2 == 0;
                return DataRow(
                  color: isEven
                      ? MaterialStateColor.resolveWith((states) => Colors.grey.shade200) 
                      : MaterialStateColor.resolveWith((states) => Colors.white),
                  cells: [
                    DataCell(Text(incidencia['fecha'] ?? '')),
                    DataCell(Text(incidencia['aula'] ?? '')),
                    DataCell(Text(incidencia['profesor'] ?? '')),
                    DataCell(Text(incidencia['descripcion'] ?? '')),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.blueAccent, // Color de texto
            ),
            child: const Text('Cerrar'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          'Formulario de Incidencias',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF044E90),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Center(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Campo para Número de Aula
                      TextField(
                        controller: _roomNumberController,
                        decoration: InputDecoration(
                          labelText: 'Número de Aula',
                          labelStyle: const TextStyle(color: Color(0xFF044E90)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF044E90), width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Selector de Profesor
                      DropdownButtonFormField<String>(
                        value: _selectedProfessor.isNotEmpty ? _selectedProfessor : null,
                        decoration: InputDecoration(
                          labelText: 'Nombre Profesor Detecta Incidencia',
                          labelStyle: const TextStyle(color: Color(0xFF044E90)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF044E90), width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        items: <String>['fbenchi274@g.educaand.es'] // Reemplazar con la lista real
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProfessor = newValue ?? '';
                          });
                        },
                      ),
                      const SizedBox(height: 16.0),

                      // Selección de Fecha
                      GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: const Color(0xFF044E90), width: 2.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                DateFormat('dd/MM/yyyy').format(_selectedDate),
                                style: const TextStyle(fontSize: 16, color: Color(0xFF333333)),
                              ),
                              const Icon(Icons.calendar_today, color: Color(0xFF044E90)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Campo para Descripción de la Incidencia
                      TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Descripción de Incidencia',
                          labelStyle: const TextStyle(color: Color(0xFF044E90)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF044E90), width: 2.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      // Botón de Enviar
                      Center(
                        child: ElevatedButton.icon(
                          onPressed: _submitForm,
                          icon: const Icon(Icons.send, color: Colors.white),
                          label: const Text('Enviar Incidencia', style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF044E90),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),

                // Botón para abrir el historial de incidencias
                ElevatedButton(
                  onPressed: _showHistoricoIncidencias,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF044E90),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
                  ),
                  child: const Text('Ver Historial de Incidencias', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}