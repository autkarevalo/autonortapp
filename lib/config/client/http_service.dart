import 'package:autonort/config/config.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio = ApiClient().dio;

  Future<Either<Failure, Response>> get(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, Response>> post(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, Response>> put(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Future<Either<Failure, Response>> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return Right(response);
    } on DioException catch (e) {
      return Left(_handleError(e));
    }
  }

  Failure _handleError(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout) {
      return ConnectionFailure('Sin conexión a Internet');
    }

    if (e.response?.statusCode == 401) {
      return ServerFailure('Token inválido o expirado');
    }

    return ServerFailure(e.response?.data['message'] ?? 'Error desconocido');
  }
}
