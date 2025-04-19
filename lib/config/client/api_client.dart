import 'package:autonort/config/config.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:dio/dio.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();

  late final Dio dio;

  factory ApiClient() => _instance;

  ApiClient._internal() {
    final keyValueStorage = KeyValueStorageServiceImpl();

    dio = Dio(BaseOptions(
        baseUrl: Environment.apiUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10)));

    dio.interceptors.addAll([
      //log en consola
      LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
          responseHeader: true),
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await keyValueStorage.getValue<String>('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          return handler.next(options);
        },
        onError: (e, handler) async {
          // Puedes manejar errores globales aquí si deseas
          if (e.response?.statusCode == 401) {
            //eliminar token y manerjar redireccion si es necesario
            await keyValueStorage.removeKey('token');
            //AQUI PODRIAS EMITIR UN EVENTO, REDIRIGIR O FORZAR LOGOUT
            print('Token invalido o expirado, se ah cerrado la sesion');
          }
          return handler.next(e);
        },
      ),
    ]);
  }
}
