import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/screen/screen.dart';
import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/screen/screen.dart';
import 'package:flutter/material.dart';

final Map<String, Widget> pantallasDinamicas = {
  //AQUI YA DEBO IR COLOCANDO LAS PANTALLAS QUE SE VAN A CREAR LLAMARLO AQUI.
  /* '/autonortapp/inicio/dashboard': const DashboardScreen(),*/
  '/autonortapp/modulos/taller/horastecnicos': const AutHorasTecnicosScreen(),
  '/autonortapp/modulos/seguridad/ingresovehiculo': const AutIngresosalidaVehiculoScreen()
};
