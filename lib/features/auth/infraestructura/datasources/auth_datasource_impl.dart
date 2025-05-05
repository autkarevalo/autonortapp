import 'package:autonort/config/config.dart';
import 'package:autonort/features/auth/dominio/dominio.dart';
import 'package:autonort/features/auth/infraestructura/mappers/usuario_mapper.dart';


class AuthDatasourceImpl extends AuthDatasource {
  final HttpService http = HttpService();

  @override
  Future<Usuario> checkAuthStatus(String token) async {
    final result = await http.get('/app/prindatosacceso');
    return result.fold((failure) => throw CustomError(failure.message),
        (response) => UsuarioMapper.usuarioFromToken(response.data));
  }

  @override
  Future<Usuario> login(
      String codempresa, String esinvitado, String usuario, String pass) async {
    final result = await http.post('/app/acceso', data: {
      'codempresa': codempresa,
      'ES_INVITADO': esinvitado,
      'usuario': usuario,
      'pass': pass
    });

    return result.fold((failure) => throw CustomError(failure.message),
        (response) => UsuarioMapper.usuarioJsonToEntity(response.data));
  }
}
