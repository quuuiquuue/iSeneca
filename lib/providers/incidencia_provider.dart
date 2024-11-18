import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class IncidenciaProvider extends ChangeNotifier {
  final Dio _dio = Dio(); // Instancia de Dio para hacer las solicitudes HTTP

  // URL del backend (cambia según tu API)
  final String apiUrl = 'http:/localhost:3306/reaktor_issuesserver';

  // Lista de incidencias obtenidas desde el backend
  List<Map<String, dynamic>> incidencias = [];

  IncidenciaProvider() {
    debugPrint("Incidencias Provider inicializado");
  }

  // Método para obtener el historial de incidencias
  Future<void> getIncidencias() async {
    try {
      final response = await _dio.get(apiUrl);
      if (response.statusCode == 200) {
        incidencias = List<Map<String, dynamic>>.from(response.data);
        notifyListeners(); // Notificar a los listeners cuando se actualicen los datos
      } else {
        throw Exception('Error al obtener el historial');
      }
    } catch (e) {
      throw Exception('Error al hacer la solicitud: $e');
    }
  }

  // Método para enviar una incidencia al backend
  Future<void> sendIncidencia(Map<String, dynamic> incidencia) async {
    try {
      final response = await _dio.post(apiUrl, data: incidencia);
      if (response.statusCode == 200) {
        incidencias.insert(
            0, incidencia); // Insertar la incidencia al inicio de la lista
        notifyListeners(); // Notificar a los listeners
      } else {
        throw Exception('Error al enviar la incidencia');
      }
    } catch (e) {
      throw Exception('Error al enviar la incidencia: $e');
    }
  }
}
