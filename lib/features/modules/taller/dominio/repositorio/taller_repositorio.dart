import '../entidades/motivos.dart';
import '../entidades/tecnicos.dart';
import '../entidades/trabajos.dart';
import '../entidades/operainiciotrabajo.dart';
import '../entidades/operaparalizatrabajo.dart';
import '../entidades/operafintrabajo.dart';
import '../entidades/operareiniciotrabajo.dart';

abstract class TallerRepositorio {
  Future<List<Tecnicos>> informaciontecnicos(
      String codempresa, String idtecnico);

  Future<List<Trabajo>> listatrabajostecnicos(
      String codempresa, String idtecnico);

  Future<List<Motivos>> listarmotivospausa(String codempresa);

  Future<Operainiciotrabajo> registrariniciotrabajo(
      String codempresa, String idprogot, int idzona, String idtecnico1);

  Future<Operaparalizatrabajo> paralizatrabajo(
      String codempresa,
      String idprogot,
      String idtecnico1,
      String itemd,
      int idmotivop,
      String nota);

  Future<Operafintrabajo> finalizartrabajo(
      String codempresa, String idprogot, String idtecnico1, String itemd);
  
    Future<Operareiniciotrabajo> reiniciartrabajo(
    String codempresa, String idprogot, int idzona, String idtecnico1
  );
}
