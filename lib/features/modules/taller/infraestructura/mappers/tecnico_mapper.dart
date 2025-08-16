import 'package:autonort/features/modules/taller/dominio/dominio.dart';

class TecnicoMapper {
  static List<Tecnicos> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> dataList = json['data'];
      return dataList.map((item) => Tecnicos.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(List<Tecnicos> tecnicos) {
    return {
      'status': 'success',
      'data' : tecnicos.map((tecnico) => tecnico.toJson()).toList(),
    };
  }
}



