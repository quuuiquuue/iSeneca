import 'dart:convert';

class IncidenciaResponse {
  IncidenciaResponse({
    required this.results,
  });

  List<ResultIncidencia> results;

  factory IncidenciaResponse.fromJson(String str) =>
      IncidenciaResponse.fromMap(json.decode(str));

  factory IncidenciaResponse.fromMap(Map<String, dynamic> json) =>
      IncidenciaResponse(
        results: List<ResultIncidencia>.from(
            json["results"].map((x) => ResultIncidencia.fromJson(x))),
      );
}

class ResultIncidencia {
  final String aula;
  final String correo;
  final DateTime fechaDeteccion;
  final String descripcionIncidencia;
  final String estado;
  final DateTime fechaSolucion;
  final String finalizadaPor;
  final String solucion;

  ResultIncidencia({
    required this.aula,
    required this.correo,
    required this.fechaDeteccion,
    required this.descripcionIncidencia,
    required this.estado,
    required this.fechaSolucion,
    required this.finalizadaPor,
    required this.solucion,
  });

  factory ResultIncidencia.fromJson(Map<String, dynamic> json) =>
      ResultIncidencia(
        aula: json["aua"],
        correo: json["correo"],
        fechaDeteccion: DateTime.parse(json["fecha_deteccion"]),
        descripcionIncidencia: json["descripcion_incidencia"],
        estado: json["Estado"],
        fechaSolucion: DateTime.parse(json["fecha_solucion"]),
        finalizadaPor: json["finalizada_por"],
        solucion: json["solucion"],
      );

  Map<String, dynamic> toJson() => {
        "aula": aula,
        "correo": correo,
        "fecha_deteccion": fechaDeteccion.toIso8601String(),
        "descripcion_incidencia": descripcionIncidencia,
        "Estado": estado,
        "fecha_solucion": fechaSolucion.toIso8601String(),
        "finalizada_por": finalizadaPor,
        "solucion": solucion,
      };
}
