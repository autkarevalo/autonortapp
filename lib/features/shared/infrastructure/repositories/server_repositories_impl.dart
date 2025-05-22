import 'package:autonort/config/config.dart';
import 'package:autonort/features/shared/dominio/dominio.dart';
import 'package:dartz/dartz.dart';

class ServerRepositoriesImpl implements ServerRepository {
  final HttpService _http = HttpService();

  @override
  Future<Either<Failure, bool>> pingServer() async {
    final result = await _http.get('/app/ping');

    return result.fold(
      // Si el HTTP lanza un failure (timeout, 401, etc.)
     (failure) {
    
      return Left(failure);
    },

      // Si llega respuesta del servidor:
      (response) {
        final statusCode = response.statusCode;
        final data = response.data;
      
        // Caso exitoso: 200 + { status: 'ok' }
        if (statusCode == 200 &&
            data is Map<String, dynamic> &&
            data['status'] == 'ok') {
          return Right(true);
        }

        // Si no es 200 o el body no es { status: 'ok' }, extraemos el mensaje
        String mensajeError = 'Servicio no disponible';
        if (data is Map<String, dynamic> && data['message'] is String) {
          mensajeError = data['message'] as String;
        }

        return Left(ServerFailure(mensajeError));
      },
    );
  }
}
