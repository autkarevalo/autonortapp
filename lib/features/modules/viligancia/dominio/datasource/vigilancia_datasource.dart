import '../entidades/sucursales.dart';
import '../entidades/areas.dart';
import '../entidades/motivos.dart';
import '../entidades/vehiculo_ingsalida.dart';

abstract class VigilanciaDatasource {
  Future<List<Sucursales>> listarsucursales(String codempresa);

  Future<List<Areas>> listarareas(String codempresa);

  Future<List<Motivos>> listarmotivosporarea(String codempresa, String area);

  Future<List<VehiculoIngsalida>> busquedavhingsalida(
      String codempresa, String fecha, String codvehiculo);
}
