class Sucursales {
  String idsucursal;
  String sucursal;

  Sucursales({required this.idsucursal,required this.sucursal});

  factory Sucursales.fromJson(Map<String, dynamic> json) => Sucursales(
        idsucursal: json["IDSUCURSAL"] ?? '',
        sucursal: json["SUCURSAL"] ?? '',
      );

  Map<String, dynamic> toJson() =>
      {"IDSUCURSAL": idsucursal, "SUCURSAL": sucursal};
}
