import 'package:autonort/features/modules/menu/dominio/dominio.dart';

class MenuMapper {
  static List<Menu> fromJsonList(Map<String, dynamic> json) {
    if (json['status'] == 'success' && json['data'] != null) {
      final List<dynamic> dataList = json['data'];
      return dataList.map((item) => Menu.fromJson(item)).toList();
    }
    return [];
  }

  static Map<String, dynamic> toJsonList(List<Menu> menus) {
    return {
      'status': 'success',
      'data' : menus.map((menu) => menu.toJson()).toList(),
    };
  }
}
