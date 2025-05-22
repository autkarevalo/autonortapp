import 'package:autonort/config/config.dart';
import 'package:dartz/dartz.dart';

abstract class ConnectivityRepository {
  Future<Either<Failure, bool>> checkNetwork();
}
