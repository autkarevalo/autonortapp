import 'package:autonort/features/modules/menu/presentation/views/views.dart';
import 'package:autonort/features/modules/menu/presentation/widgets/widgets.dart';
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
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomButtonNavigation(currentIndex: pageIndex),
    );
  }
}
