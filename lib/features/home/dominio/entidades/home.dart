// entities/home.dart

import 'package:flutter/material.dart';

class Home {
  final String? status;
  final List<HomeItem>? data;

  Home({
    this.status,
    this.data,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<HomeItem>.from(
                json["data"]!.map((x) => HomeItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class HomeItem {
  //MAPA DE CLAVES DE ICONOS (EL NOMBRE TRAS EL PUNTO) A ICONDATA
  static const Map<String, IconData> _iconMap = {
    'camera_alt': Icons.camera_alt,
    'notifications_active': Icons.notifications_active,
    'edit_document': Icons.edit_document,
    'hourglass_bottom': Icons.hourglass_bottom,
    'insert_chart_outlined_outlined': Icons.insert_chart_outlined_outlined,
  };

  final String? titulo;
  final String? mensaje;
  final String? subtitulo1;
  final String? mensajeSubtitulo1;
  final String? iconsSubtitulo1;
  final String? subtitulo2;
  final String? mensajeSubtitulo2;
  final String? iconsSubtitulo2;
  final String? subtitulo3;
  final String? mensajeSubtitulo3;
  final String? iconsSubtitulo3;
  final String? subtitulo4;
  final String? mensajeSubtitulo4;
  final String? iconsSubtitulo4;
  final String? ulrimg;

  HomeItem(
      {this.titulo,
      this.mensaje,
      this.subtitulo1,
      this.mensajeSubtitulo1,
      this.iconsSubtitulo1,
      this.subtitulo2,
      this.mensajeSubtitulo2,
      this.iconsSubtitulo2,
      this.subtitulo3,
      this.mensajeSubtitulo3,
      this.iconsSubtitulo3,
      this.subtitulo4,
      this.mensajeSubtitulo4,
      this.iconsSubtitulo4,
      this.ulrimg});

  factory HomeItem.fromJson(Map<String, dynamic> json) {
    //si no viene URL de imagen  usamos una pór defecto
    final rawUrl = json['ULRIMG'] as String?;
    final imageUrl = (rawUrl == null || rawUrl.isEmpty) ? 'assets/images/noimg.jpg' : rawUrl;

    return HomeItem(
      titulo: json['TITULO'] as String?,
      mensaje: json['MENSAJE'] as String?,
      subtitulo1: json['SUBTITULO1'] as String?,
      mensajeSubtitulo1: json['MENSAJE_SUBTITULO1'] as String?,
      iconsSubtitulo1: json['ICONS_SUBTITULO1'] as String?,
      subtitulo2: json['SUBTITULO2'] as String?,
      mensajeSubtitulo2: json['MENSAJE_SUBTITULO2'] as String?,
      iconsSubtitulo2: json['ICONS_SUBTITULO2'] as String?,
      subtitulo3: json['SUBTITULO3'] as String?,
      mensajeSubtitulo3: json['MENSAJE_SUBTITULO3'] as String?,
      iconsSubtitulo3: json['ICONS_SUBTITULO3'] as String?,
      subtitulo4: json['SUBTITULO4'] as String?,
      mensajeSubtitulo4: json['MENSAJE_SUBTITULO4'] as String?,
      iconsSubtitulo4: json['ICONS_SUBTITULO4'] as String?,
      ulrimg: imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        'TITULO': titulo,
        'MENSAJE': mensaje,
        'SUBTITULO1': subtitulo1,
        'MENSAJE_SUBTITULO1': mensajeSubtitulo1,
        'ICONS_SUBTITULO1': iconsSubtitulo1,
        'SUBTITULO2': subtitulo2,
        'MENSAJE_SUBTITULO2': mensajeSubtitulo2,
        'ICONS_SUBTITULO2': iconsSubtitulo2,
        'SUBTITULO3': subtitulo3,
        'MENSAJE_SUBTITULO3': mensajeSubtitulo3,
        'ICONS_SUBTITULO3': iconsSubtitulo3,
        'SUBTITULO4': subtitulo4,
        'MENSAJE_SUBTITULO4': mensajeSubtitulo4,
        'ICONS_SUBTITULO4': iconsSubtitulo4,
        "ULRIMG": ulrimg,
      };

  // Extraemos la parte del nombre tras el punto: e.g. 'Icons.camera_alt' -> 'camera_alt'
  String _iconKey(String? iconString) => iconString?.split('.').last ?? '';

  // Getters que exponen IconData listos para usar en la UI
  IconData get icon1 =>
      _iconMap[_iconKey(iconsSubtitulo1)] ?? Icons.help_outline;
  IconData get icon2 =>
      _iconMap[_iconKey(iconsSubtitulo2)] ?? Icons.help_outline;
  IconData get icon3 =>
      _iconMap[_iconKey(iconsSubtitulo3)] ?? Icons.help_outline;
  IconData get icon4 =>
      _iconMap[_iconKey(iconsSubtitulo4)] ?? Icons.help_outline;
}
