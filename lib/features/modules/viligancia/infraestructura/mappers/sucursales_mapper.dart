import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';

class SucursalesMapper {
  static List<Sucursales> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> dataList = json['data'];
      return dataList.map((item) => Sucursales.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(List<Sucursales> sucursales) {
    return {
      'status': 'success',
      'data': sucursales.map((item) => item.toJson()).toList()
    };
  }
}
