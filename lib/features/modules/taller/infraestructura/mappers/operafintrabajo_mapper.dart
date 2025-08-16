import 'package:autonort/features/modules/taller/dominio/dominio.dart';
class OperafintrabajoMapper {
  static Operafintrabajo fromJson(Map<String, dynamic> json) {
    return Operafintrabajo(
      status: json['status'] ?? '',
      message: json['message'],
    );
  }

}