import 'package:autonort/config/client/failure.dart';
import 'package:autonort/features/shared/dominio/dominio.dart';
import 'package:autonort/features/shared/services/connectivity_services.dart';
import 'package:dartz/dartz.dart';

class ConnectivityRepositoriesImpl implements ConnectivityRepository {
  final ConnectivityServices _service = ConnectivityServices();

  @override
  Future<Either<Failure, bool>> checkNetwork() async {
    final ok = await _service.hasNetwork();
    return ok ? Right(true) : Left(ConnectionFailure("Sin conexión"));
  }
}
