import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:autonort/features/modules/menu/presentation/providers/provider.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/providers/horas_tecnicos_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomButtonNavigation extends ConsumerWidget {
  final int currentIndex;
  const CustomButtonNavigation({super.key, required this.currentIndex});

  void onItemTapped(BuildContext context, int index, WidgetRef ref) {
    switch (index) {
      case 0:
        // ✅ Primero limpia el menú antes de redibujar la pantalla
        Future.microtask(() {
          ref.read(menuProvider.notifier).clearSelectedMenu();
        });
        context.go('/autonortapp/menu_principal/0');
        break;

      case 1:
        context.go('/autonortapp/menu_principal/1');
        break;
      case 2:
        // Limpiar la lista de detecciones
        ref.read(authProvider.notifier).clearResults();
        ref.read(menuProvider.notifier).clearMenus();
        ref.read(horastecnicosProvider.notifier).cleardatoshorastecnicos();
        ref.read(authProvider.notifier).logout();

        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value, ref),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'Mi Perfil'),
          BottomNavigationBarItem(
              icon: Icon(Icons.exit_to_app_outlined), label: 'Salir')
        ]);
  }
}
