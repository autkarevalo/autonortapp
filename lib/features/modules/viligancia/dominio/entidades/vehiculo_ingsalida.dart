class VehiculoIngsalida {
  DateTime? fIngreso;
  String? vehiculo;
  String? idvehiculo;
  String? placa;
  String? modelo;
  String? cliente;
  String? motivoIngreso;
  String? idcita;

  VehiculoIngsalida({
    this.fIngreso,
    this.vehiculo,
    this.idvehiculo,
    this.placa,
    this.modelo,
    this.cliente,
    this.motivoIngreso,
    this.idcita,
  });

  factory VehiculoIngsalida.fromJson(Map<String, dynamic> json) {
    return VehiculoIngsalida(
      fIngreso: json["F_INGRESO"] != null && json["F_INGRESO"].toString().isNotEmpty
          ? DateTime.parse(json["F_INGRESO"])
          : null,
      vehiculo: json["VEHICULO"] ?? '',
      idvehiculo: json["IDVEHICULO"] ?? '',
      placa: json["PLACA"] ?? '',
      modelo: json["MODELO"] ?? '',
      cliente: json["CLIENTE"] ?? '',
      motivoIngreso: json["MOTIVO_INGRESO"] ?? '',
      idcita: json["IDCITA"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "F_INGRESO": fIngreso?.toIso8601String(),
        "VEHICULO": vehiculo,
        "IDVEHICULO": idvehiculo,
        "PLACA": placa,
        "MODELO": modelo,
        "CLIENTE": cliente,
        "MOTIVO_INGRESO": motivoIngreso,
        "IDCITA": idcita,
      };
}
