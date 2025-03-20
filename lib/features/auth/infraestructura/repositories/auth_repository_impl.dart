import 'package:autonort/features/auth/dominio/dominio.dart';
import '../infraestructura.dart';

class AuthRepositoryImpl extends AuthRepositorio {
  final AuthDatasource dataSource;

  AuthRepositoryImpl({AuthDatasource? dataSource})
      : dataSource = dataSource ?? AuthDatasourceImpl();

  @override
  Future<Usuario> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<Usuario> login(
      String codempresa, String esinvitado, String usuario, String pass) {
    return dataSource.login(codempresa, esinvitado, usuario, pass);
  }
}
