import 'package:autonort/config/config.dart';
import 'package:dartz/dartz.dart';

abstract class ServerRepository {
  Future<Either<Failure,bool>> pingServer();
}