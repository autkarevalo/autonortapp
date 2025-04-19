import 'package:autonort/features/auth/dominio/dominio.dart';

class UsuarioMapper {
  /// Mapea la respuesta del login
  static Usuario usuarioJsonToEntity(Map<String, dynamic> json) {
    final data = json['data'];

    return Usuario(
      id: data['id'],
      nombre: data['nombre'],
      idempresa: data['idempresa'],
      esinvitado: data['esinvitado'],
      token: data['token'],
    );
  }

  /// Mapea la respuesta del checkAuthStatus
  static Usuario usuarioFromToken(Map<String, dynamic> json) {
    final data = json['user'];

    return Usuario(
      id: data['id'],
      nombre: data['nombre'],
      idempresa: data['idempresa'],
      iat: data['iat'],
      exp: data['exp'],
    );
  }
}
