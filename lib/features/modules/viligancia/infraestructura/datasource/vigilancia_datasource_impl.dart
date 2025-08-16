import 'package:autonort/config/config.dart';
import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';
import 'package:autonort/features/modules/viligancia/infraestructura/infraestructura.dart';

class VigilanciaDatasourceImpl extends VigilanciaDatasource {
  final HttpService http = HttpService();

  @override
  Future<List<Sucursales>> listarsucursales(String codempresa) async {
    final response = await http.get('/app/seguridad/lisuc/$codempresa');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => SucursalesMapper.fromJsonList(response.data));
  }

  @override
  Future<List<Areas>> listarareas(String codempresa) async {
    final response = await http.get('/app/seguridad/areas/$codempresa');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => AreasMapper.fromJsonList(response.data));
  }

  @override
  Future<List<Motivos>> listarmotivosporarea(
      String codempresa, String area) async {
    final response =
        await http.get('/app/seguridad/motivoxarea/$codempresa/$area');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => MotivosMapper.fromJsonList(response.data));
  }

  @override
  Future<List<VehiculoIngsalida>> busquedavhingsalida(
      String codempresa, String fecha, String codvehiculo) async {
    final response = await http
        .get('/app/seguridad/lvhingreso/$codempresa/$fecha/$codvehiculo');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => VehiculoIngsalidaMapper.fromJsonList(response.data));
  }
}
