import 'package:autonort/features/modules/taller/dominio/dominio.dart';
import '../infraestructura.dart';

class TallerRepositoryImpl extends TallerRepositorio {
  final TallerDatasource tallerSource;

  TallerRepositoryImpl({TallerDatasource? tallerSource})
      : tallerSource = tallerSource ?? TallerDatasourceImpl();

  @override
  Future<List<Tecnicos>> informaciontecnicos(
      String codempresa, String idtecnico) {
    return tallerSource.informaciontecnicos(codempresa, idtecnico);
  }

  @override
  Future<List<Trabajo>> listatrabajostecnicos(
      String codempresa, String idtecnico) {
    return tallerSource.listatrabajostecnicos(codempresa, idtecnico);
  }

  @override
  Future<List<Motivos>> listarmotivospausa(String codempresa) {
    return tallerSource.listarmotivospausa(codempresa);
  }

  @override
  Future<Operainiciotrabajo> registrariniciotrabajo(
      String codempresa, String idprogot, int idzona, String idtecnico1) {
    return tallerSource.registrariniciotrabajo(
        codempresa, idprogot, idzona, idtecnico1);
  }

  @override
  Future<Operaparalizatrabajo> paralizatrabajo(
      String codempresa,
      String idprogot,
      String idtecnico1,
      String itemd,
      int idmotivop,
      String nota) {
    return tallerSource.paralizatrabajo(
        codempresa, idprogot, idtecnico1, itemd, idmotivop, nota);
  }

  @override
  Future<Operafintrabajo> finalizartrabajo(
      String codempresa, String idprogot, String idtecnico1, String itemd) {
    return tallerSource.finalizartrabajo(
        codempresa, idprogot, idtecnico1, itemd);
  }

  @override
  Future<Operareiniciotrabajo> reiniciartrabajo(
      String codempresa, String idprogot, int idzona, String idtecnico1) {
    return tallerSource.reiniciartrabajo(
        codempresa, idprogot, idzona, idtecnico1);
  }
}
