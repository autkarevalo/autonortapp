import 'package:flutter/material.dart';

class Menu {
  final int idmenu;
  final int? idPadre;
  final String opcion;
  final String? ruta;
  final String? icomenus;
  final dynamic funciona;
  final int estado;
  final int menuGeneral;
  final String nivel;
  final String? nivelpadre;
  final String subnivel;
  final List<Menu>? item;
  final List<Menu>? subItem;

  Menu({
    required this.idmenu,
    this.idPadre,
    required this.opcion,
    this.ruta,
    this.icomenus,
    this.funciona,
    required this.estado,
    required this.menuGeneral,
    required this.nivel,
    this.nivelpadre,
    required this.subnivel,
    this.item,
    this.subItem,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      idmenu: json["IDMENU"],
      idPadre: json["ID_PADRE"],
      opcion: json["OPCION"] ?? '',
      ruta: json["RUTA"],
      icomenus: json["ICOMENUS"],
      funciona: json["FUNCIONA"],
      estado: json["ESTADO"],
      menuGeneral: json["MENU_GENERAL"],
      nivel: json["NIVEL"] ?? '',
      nivelpadre: json["NIVELPADRE"],
      subnivel: json["SUBNIVEL"] ?? '',
      item: json["ITEM"] != null
          ? List<Menu>.from(json["ITEM"]!.map((x) => Menu.fromJson(x)))
          : null,
      subItem: json["SUB_ITEM"] != null
          ? List<Menu>.from(json["SUB_ITEM"]!.map((x) => Menu.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "IDMENU": idmenu,
        "ID_PADRE": idPadre,
        "OPCION": opcion,
        "RUTA": ruta,
        "ICOMENUS": icomenus,
        "FUNCIONA": funciona,
        "ESTADO": estado,
        "MENU_GENERAL": menuGeneral,
        "NIVEL": nivel,
        "NIVELPADRE": nivelpadre,
        "SUBNIVEL": subnivel,
        "ITEM": item?.map((x) => x.toJson()).toList(),
        "SUB_ITEM": subItem?.map((x) => x.toJson()).toList(),
      };

  IconData get iconData {
    const iconMap = {
      'home': Icons.home,
      'dashboard': Icons.dashboard,
      'edit_document': Icons.edit_document,
      'person': Icons.person,
      'security': Icons.security,
      'notifications': Icons.notifications,
      'settings': Icons.settings,
      'folder': Icons.folder,
      'camera': Icons.camera_alt,
      'calendar': Icons.calendar_today,
      'build': Icons.build,
      'car_rental': Icons.car_rental,
      'engineering': Icons.engineering,
      'ingreso': Icons.login,
      'perfil': Icons.account_circle,
      'view_module': Icons.view_module,
      // 🔧 agrega más según tu backend
    };
    if (icomenus == null) return Icons.circle_outlined;

    final cleaned = icomenus!.toLowerCase().replaceAll('icons.', '');

    return iconMap[cleaned] ?? Icons.circle_outlined;
  }
}
