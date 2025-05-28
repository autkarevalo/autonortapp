import 'package:autonort/config/config.dart';
import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:autonort/features/modules/menu/presentation/providers/provider.dart';
import 'package:autonort/features/modules/menu/presentation/widgets/widgets.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AutScaffoldConDrawer extends ConsumerStatefulWidget {
  final Widget child;
  final String title;
  final bool mostrarAppBar;
  final bool mostrarBottomNavigation;

  const AutScaffoldConDrawer(
      {super.key,
      required this.child,
      this.title = '',
      this.mostrarAppBar = true,
      this.mostrarBottomNavigation = false});

  @override
  ConsumerState<AutScaffoldConDrawer> createState() =>
      _AutScaffoldConDrawerState();
}

class _AutScaffoldConDrawerState extends ConsumerState<AutScaffoldConDrawer> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _getIndexFromPath(String path) {
    if (path.contains('/menu_principal/1')) return 1;
    if (path.contains('/menu_principal/0')) return 0;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final menuState = ref.watch(menuProvider);

    final user = authState.user;
    final currentPath = GoRouterState.of(context).uri.toString();
    final isMenuPrincipal = currentPath == '/autonortapp/menu_principal/0';
    final bodyContent = Stack(
      children: [
        widget.child,
        if (isMenuPrincipal)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                    icon: const Icon(Icons.menu, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {
                      // TODO: NAVEGAR A NOTIFICACIONES
                    },
                    icon: const Icon(Icons.notifications, color: Colors.white),
                  ),
                ],
              ),
            ),
          )
      ],
    );

    return Scaffold(
      key: _scaffoldKey,
      drawer: AutMenuLateralWidget(
        menus: menuState.menus,
        onTap: (ruta) {
          ref.read(menuProvider.notifier).selectMenuPorRuta(ruta);
          context.go(ruta);
          Navigator.of(context).pop();
        },
        fullName: user?.nombre ?? 'Usuario',
        email: user?.id ?? 'User',
        photoUrl: '',
        selectedMenu: menuState.selectedMenu,
      ),
      appBar: (!isMenuPrincipal && widget.mostrarAppBar)
          ? AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: scaffoldBackgroundColor,
              title: Text(
                widget.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    // TODO: NAVEGAR A NOTIFICACIONES
                  },
                  icon: const Icon(Icons.notifications, color: Colors.black),
                )
              ],
              leading: IconButton(
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                icon: const Icon(Icons.menu, color: Colors.black),
              ),
            )
          : null,
      extendBodyBehindAppBar: isMenuPrincipal,
      body: bodyContent,
      bottomNavigationBar: widget.mostrarBottomNavigation
          ? CustomButtonNavigation(currentIndex: _getIndexFromPath(currentPath))
          : null,
    );
  }
}
