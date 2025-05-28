import 'package:autonort/features/modules/menu/presentation/views/views.dart';
import 'package:autonort/features/shared/shared.dart';

import 'package:flutter/material.dart';

class AutMenuPrincipal extends StatelessWidget {
  final int pageIndex;

  const AutMenuPrincipal({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    AutMenuPrincipalView(),
    AutMenuPerfilView()
    //AQUI LLAMAREMOS AL AUT_MENU_PERFIL
    //LLAMAREMOS A AUT_MENU_NOTIFICACION_VIEW
  ];

  @override
  Widget build(BuildContext context) {
    return AutScaffoldConDrawer(
      title: '',
      mostrarAppBar: true, // AppBar oculto en esta vista
      mostrarBottomNavigation: true, // Barra de navegación visible
      child: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
  
    );
  }
}
