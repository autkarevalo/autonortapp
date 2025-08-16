import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';

class AreasMapper {
  static List<Areas> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> dataList = json['data'];
      return dataList.map((item) => Areas.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(List<Areas> areas) {
    return {
      'status': 'success',
      'data': areas.map((item) => item.toJson()).toList()
    };
  }
}
