class Tecnicos {
  String? codigo;
  String? trabajador;
  String? cargo;
  String? sucursal;
  String? taller;
  int? estado;

  Tecnicos({
    this.codigo,
    this.trabajador,
    this.cargo,
    this.sucursal,
    this.taller,
    this.estado,
  });

  factory Tecnicos.fromJson(Map<String, dynamic> json) => Tecnicos(
        codigo: json["CODIGO"],
        trabajador: json["TRABAJADOR"],
        cargo: json["CARGO"],
        sucursal: json["Sucursal"],
        taller: json["TALLER"],
        estado: json["ESTADO"],
      );

  Map<String, dynamic> toJson() => {
        "CODIGO": codigo,
        "TRABAJADOR": trabajador,
        "CARGO": cargo,
        "Sucursal": sucursal,
        "TALLER": taller,
        "ESTADO": estado,
      };
}
