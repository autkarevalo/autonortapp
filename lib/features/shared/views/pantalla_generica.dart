import 'package:autonort/features/shared/views/pantallas_dinamicas.dart';
import 'package:autonort/features/shared/widgets/aut_scaffold_con_drawer.dart';
import 'package:flutter/material.dart';

class PantallaGenerica extends StatelessWidget {
  final String ruta;
  final String modulo;
  final String? seccion;
  final String pagina;
  const PantallaGenerica(
      {super.key,
      required this.ruta,
      required this.modulo,
      this.seccion,
      required this.pagina});

  @override
  Widget build(BuildContext context) {
    final Widget? contenido = pantallasDinamicas[ruta];
    if (contenido == null) {
      debugPrint('[PantallaGenerica] Ruta no encontrada: $ruta');
    }
    return AutScaffoldConDrawer(
      title: pagina,
      mostrarBottomNavigation: true,
      key: GlobalKey<ScaffoldState>(),
      child: contenido ??
          const Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.warning_amber_rounded, color: Colors.red, size: 48),
                SizedBox(height: 8),
                Text('Pantalla no implementada aún')
              ],
            ),
          ),
    );
  }
}
