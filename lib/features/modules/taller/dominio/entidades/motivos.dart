class Motivos {
  int? idmotivop;
  String? descripcion;
  int? esManual;

  Motivos({
    this.idmotivop,
    this.descripcion,
    this.esManual,
  });

  factory Motivos.fromJson(Map<String, dynamic> json) => Motivos(
        idmotivop: json["IDMOTIVOP"],
        descripcion: json["DESCRIPCION"],
        esManual: json["ES_MANUAL"],
      );

  Map<String, dynamic> toJson() => {
        "IDMOTIVOP": idmotivop,
        "DESCRIPCION": descripcion,
        "ES_MANUAL": esManual,
      };
}
