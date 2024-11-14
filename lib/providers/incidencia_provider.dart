import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class IncidenciaProvider extends ChangeNotifier {
  final List<Map<String, String>> _incidenciasHistorico = [];
  bool isLoading = false;

  List<Map<String, String>> get incidenciasHistorico => _incidenciasHistorico;

  // Example endpoint (replace with actual endpoint URL)
  final String apiEndpoint =
      'https://script.google.com/macros/s/YOUR_SCRIPT_ID/exec';

  IncidenciaProvider() {
    fetchIncidenciasHistorico();
  }

  // Fetch incident history from server
  Future<void> fetchIncidenciasHistorico() async {
    isLoading = true;
    notifyListeners();
    
    try {
      final response = await http.get(
        Uri.parse('$apiEndpoint?function=fetchIncidencias')
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        _incidenciasHistorico.clear();
        data.forEach((item) {
          _incidenciasHistorico.add({
            "fecha": item['fecha'],
            "descripcion": item['descripcion'],
            "aula": item['aula'],
            "profesor": item['profesor'],
          });
        });
        notifyListeners();
      } else {
        debugPrint("Error fetching data: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Submit a new incident report
  Future<void> submitIncidencia({
    required String aula,
    required String descripcion,
    required String profesor,
    required DateTime fecha,
    required BuildContext context,
  }) async {
    final formattedDate = DateFormat('dd/MM/yyyy').format(fecha);

    if (aula.isEmpty || descripcion.isEmpty || profesor.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos.')),
      );
      return;
    }

    isLoading = true;
    notifyListeners();

    final Uri url = Uri.parse(
      '$apiEndpoint?function=submitIncidencia'
      '&aula=$aula&descripcion=$descripcion&profesor=$profesor&fecha=$formattedDate',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final message = json.decode(response.body)['message'];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
        fetchIncidenciasHistorico(); // Refresh history after submission
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Error al enviar la incidencia.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Display a snackbar
  void showSnackBar(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}
