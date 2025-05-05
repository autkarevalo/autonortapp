import '../entidades/menu.dart';

abstract class MenuRepositorio {
    Future<List<Menu>> menugeneral(
      String codempresa, String idusuario, String aplicativo);
}