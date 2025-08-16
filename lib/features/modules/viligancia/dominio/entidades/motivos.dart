class Motivos {
  final String? motivo;

  Motivos({this.motivo});

  factory Motivos.fromJson(Map<String, dynamic> json) => Motivos(
        motivo: json["MOTIVO_INGRESO"] as String?, // acepta null directamente
      );

  Map<String, dynamic> toJson() => {
        "MOTIVO_INGRESO": motivo,
      };
}
