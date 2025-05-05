import 'package:autonort/config/config.dart';
import 'package:autonort/features/modules/menu/dominio/dominio.dart';
import 'package:autonort/features/modules/menu/infraestructura/infraestructura.dart';

class MenuDatasourceImpl extends MenuDatasource {
  final HttpService http = HttpService();

  @override
  Future<List<Menu>> menugeneral(
      String codempresa, String idusuario, String aplicativo) async {
    final response =
        await http.get('/app/menuapp/$codempresa/$idusuario/$aplicativo');

    return response.fold((failure) => throw CustomError(failure.message),
        (response) => MenuMapper.fromJsonList(response.data));
  }
}
