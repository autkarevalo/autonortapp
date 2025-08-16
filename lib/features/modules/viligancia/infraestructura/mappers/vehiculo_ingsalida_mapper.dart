import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';

class VehiculoIngsalidaMapper {
  static List<VehiculoIngsalida> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> datalist = json['data'];
      return datalist.map((item) => VehiculoIngsalida.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(
      List<VehiculoIngsalida> vehiculoingsalida) {
    return {
      'status': 'success',
      'data': vehiculoingsalida.map((item) => item.toJson()).toList()
    };
  }
}
