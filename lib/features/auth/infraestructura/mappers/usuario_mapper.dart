import 'package:autonort/features/auth/dominio/dominio.dart';

class UsuarioMapper {
  static Usuario usuarioJsonToEntity(Map<String, dynamic> json) => Usuario(
      usuario: json['usuario'],
      nombre: json['nombre'],
      idempresa: json['idempresa'],
      esinvitado: json['esinvitado'],
      token: json['token']);
}
