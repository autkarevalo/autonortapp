import 'package:autonort/features/modules/taller/dominio/dominio.dart';
class OperainiciotrabajoMapper {
  static Operainiciotrabajo fromJson(Map<String, dynamic> json) {
    return Operainiciotrabajo(
      status: json['status'] ?? '',
      message: json['message'],
    );
  }
}