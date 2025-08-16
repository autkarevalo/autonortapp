import 'package:autonort/features/modules/taller/dominio/dominio.dart';

class MotivosMapper {
  static List<Motivos> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> dataList = json['data'];
      return dataList.map((item) => Motivos.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(List<Motivos> motivos) {
    return {
      'status': 'success',
      'data': motivos.map((item) => item.toJson()).toList()
    };
  }
}
