import '../entidades/usuario.dart';

abstract class AuthRepositorio {
  Future<Usuario> login(
      String codempresa, String esinvitado, String usuario, String pass);

  Future<Usuario> checkAuthStatus(String token);
}
