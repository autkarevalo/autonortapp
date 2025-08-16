
import 'package:autonort/features/modules/taller/dominio/dominio.dart';
class OperareiniciotrabajoMapper {
  static Operareiniciotrabajo fromJson(Map<String, dynamic> json) {
    return Operareiniciotrabajo(
      status: json['status'] ?? '',
      message: json['message'],
    );
  }
}