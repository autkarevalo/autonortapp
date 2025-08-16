import 'package:autonort/features/modules/taller/dominio/dominio.dart';

class TrabajosMapper {
  static List<Trabajo> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> dataList = json['data'];
      return dataList.map((item) => Trabajo.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(List<Trabajo> trabajos) {
    return {
      'status': 'success',
      'data': trabajos.map((item) => item.toJson()).toList()
    };
  }
}
