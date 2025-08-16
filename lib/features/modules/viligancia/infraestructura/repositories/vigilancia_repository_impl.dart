import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';

import '../infraestructura.dart';

class VigilanciaRepositoryImpl extends VigilanciaRepositorio {
  final VigilanciaDatasource vigilanciaSource;

  VigilanciaRepositoryImpl({VigilanciaDatasource? vigilanciaSource})
      : vigilanciaSource = vigilanciaSource ?? VigilanciaDatasourceImpl();

  @override
  Future<List<Sucursales>> listarsucursales(String codempresa) {
    return vigilanciaSource.listarsucursales(codempresa);
  }

  @override
  Future<List<Areas>> listarareas(String codempresa) {
    return vigilanciaSource.listarareas(codempresa);
  }

  @override
  Future<List<Motivos>> listarmotivosporarea(String codempresa, String area) {
    return vigilanciaSource.listarmotivosporarea(codempresa, area);
  }

  @override
  Future<List<VehiculoIngsalida>> busquedavhingsalida(
      String codempresa, String fecha, String codvehiculo) {
    return vigilanciaSource.busquedavhingsalida(codempresa, fecha, codvehiculo);
  }
}
