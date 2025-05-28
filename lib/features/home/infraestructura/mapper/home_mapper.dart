import 'package:autonort/features/home/dominio/entidades/home.dart';

class HomeMapper {
  /// Mapea el JSON raíz {"status": "...", "data": […]} a un Home
  static Home fromJson(Map<String, dynamic> json) {
    return Home.fromJson(json);
  }

  /// (Opcional) Convierte un Home a JSON
  static Map<String, dynamic> toJson(Home home) {
    return home.toJson();
  }
}
