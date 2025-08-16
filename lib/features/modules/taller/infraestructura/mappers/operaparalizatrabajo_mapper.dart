import 'package:autonort/features/modules/taller/dominio/dominio.dart';

class OperaparalizatrabajoMapper {
  static Operaparalizatrabajo fromJson(Map<String, dynamic> json) {
    return Operaparalizatrabajo(
      status: json['status'] ?? '',
      message: json['message'],
    );
  }
}