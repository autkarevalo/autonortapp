
import 'package:autonort/config/config.dart';
import 'package:autonort/features/auth/dominio/dominio.dart';
import 'package:autonort/features/auth/infraestructura/infraestructura.dart';
import 'package:dio/dio.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

  @override
  Future<Usuario> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/prindatosacceso',
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = UsuarioMapper.usuarioJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      //throw WrongCredentials();
      if (e.response?.statusCode == 401) {
        throw CustomError('Token incorrecto');
      }

      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Usuario> login(
      String codempresa, String esinvitado, String usuario, String pass) async {
    try {
      final response = await dio.post('/acceso', data: {
        'codempresa': codempresa,
        'ES_INVITADO': esinvitado,
        'usuario': usuario,
        'pass': pass
      });

      final user = UsuarioMapper.usuarioJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw CustomError(
            e.response?.data['message'] ?? 'credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexion a Internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
