import 'package:autonort/config/config.dart';
import 'package:autonort/features/modules/taller/dominio/dominio.dart';
import 'package:autonort/features/modules/taller/infraestructura/infraestructura.dart';

class TallerDatasourceImpl extends TallerDatasource {
  final HttpService http = HttpService();

  @override
  Future<List<Tecnicos>> informaciontecnicos(
      String codempresa, String idtecnico) async {
    final response =
        await http.get('/app/kodawari/listtec/$codempresa/$idtecnico');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => TecnicoMapper.fromJsonList(response.data));
  }

  @override
  Future<List<Trabajo>> listatrabajostecnicos(
      String codempresa, String idtecnico) async {
    final response =
        await http.get('/app/kodawari/listtrabajos/$codempresa/$idtecnico');

    return response.fold((failure) => throw CustomError(failure.message),
        (response) => TrabajosMapper.fromJsonList(response.data));
  }

  @override
  Future<List<Motivos>> listarmotivospausa(String codempresa) async {
    final response = await http.get('/app/kodawari/lsmotp/$codempresa');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => MotivosMapper.fromJsonList(response.data));
  }

  @override
  Future<Operainiciotrabajo> registrariniciotrabajo(
      String codempresa, String idprogot, int idzona, String idtecnico1) async {
    final body = {
      'IDPROGOT': idprogot,
      'IDZONA': idzona,
      'IDTECNICO1': idtecnico1
    };
    final response =
        await http.post('/app/kodawari/regit/$codempresa', data: body);

    return response.fold((failure) => throw CustomError(failure.message),
        (response) => OperainiciotrabajoMapper.fromJson(response.data));
  }

  @override
  Future<Operaparalizatrabajo> paralizatrabajo(
      String codempresa,
      String idprogot,
      String idtecnico1,
      String itemd,
      int idmotivop,
      String nota) async {
    final response = await http.get(
        '/app/kodawari/uptpt/$codempresa/$idprogot/$idtecnico1/$itemd/$idmotivop/$nota');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => OperaparalizatrabajoMapper.fromJson(response.data));
  }

  @override
  Future<Operafintrabajo> finalizartrabajo(String codempresa, String idprogot,
      String idtecnico1, String itemd) async {
    final response = await http
        .get('/app/kodawari/uptft/$codempresa/$idprogot/$idtecnico1/$itemd');
    return response.fold((failure) => throw CustomError(failure.message),
        (response) => OperafintrabajoMapper.fromJson(response.data));
  }

  @override
  Future<Operareiniciotrabajo> reiniciartrabajo(
      String codempresa, String idprogot, int idzona, String idtecnico1) async {
    final body = {
      'IDPROGOT': idprogot,
      'IDZONA': idzona,
      'IDTECNICO1': idtecnico1
    };

    final response =
        await http.post('/app/kodawari/regrei/$codempresa', data: body);

    return response.fold((failue) => throw CustomError(failue.message),
        (response) => OperareiniciotrabajoMapper.fromJson(response.data));
  }
}
