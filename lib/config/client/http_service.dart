import 'dart:io';

import 'package:autonort/config/config.dart';
import 'package:autonort/features/shared/services/connectivity_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HttpService {
  final Dio _dio = ApiClient().dio;
  final _net = ConnectivityServices();

  Future<Either<Failure, Response>> get(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParams);
      return Right(response);
    } on DioException catch (e) {
      return Left(await _handleError(e));
    }
  }

  Future<Either<Failure, Response>> post(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.post(path, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(await _handleError(e));
    }
  }

  Future<Either<Failure, Response>> put(String path,
      {Map<String, dynamic>? data}) async {
    try {
      final response = await _dio.put(path, data: data);
      return Right(response);
    } on DioException catch (e) {
      return Left(await _handleError(e));
    }
  }

  Future<Either<Failure, Response>> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return Right(response);
    } on DioException catch (e) {
      return Left(await _handleError(e));
    }
  }

  Future<Failure> _handleError(DioException e) async {
  // 1) ¿Sin red local?
  if (!await _net.hasNetwork()) {
      return ConnectionFailure('Sin conexión a Internet');
    }

  // 2) Error de socket (host unreachable) → probablemente sin MB
  if (e.error is SocketException) {
    return ConnectionFailure('Sin conexión a Internet');
  }


   // 2) Hay red, pero la petición falló por timeout o host unreachable:
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return ServerFailure('Servidor no disponible, inténtalo más tarde');
    }

    if (e.response?.statusCode == 401) {
      return ServerFailure('Token inválido o expirado');
    }

  final data = e.response?.data;
    final msg = (data is Map && data['message'] is String)
      ? data['message'] as String
      : 'Error desconocido';
    return ServerFailure(msg);
  }
}
