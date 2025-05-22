import 'package:autonort/config/router/app_router_notifier.dart';
import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:autonort/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:autonort/features/auth/presentation/screens/login_screen.dart';
import 'package:autonort/features/home/presentation/screen/screen.dart';
import 'package:autonort/features/modules/menu/menu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider((ref) {
  final goRouterNotifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    initialLocation: '/splashscreen',
    refreshListenable: goRouterNotifier,
    routes: [
      //*Splash Screen
      GoRoute(
        path: '/splashscreen',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/splashchecklogin',
        builder: (context, state) => CheckAuthStatusScreen(),
      ),
      GoRoute(
        path: '/tutorial',
        builder: (context, state) => TutorialScreen(),
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/autonortapp/menu_principal/:page',
        builder: (context, state) {
          final pageIndex = (state.pathParameters['page'] ?? 0).toString();
          return AutMenuPrincipal(
            pageIndex: int.parse(pageIndex),
          );
        },
      )
    ],
    redirect: (context, state) {
      //final authState = ref.read(authProvider);
      final authStatus = goRouterNotifier.authStatus;
      // final user = authState.user;
      final isGoinTo = state.matchedLocation;

      if (isGoinTo == '/splashchecklogin' &&
          authStatus == AuthStatus.checking) {
        return null;
      }

      if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoinTo == '/splashscreen' ||
            isGoinTo == '/tutorial' ||
            isGoinTo == '/login' ||
            isGoinTo == '/registrarse') {
          return null;
        }

        // Redirigir primero al Tutorial, y luego al Login
        return '/tutorial';
      }
      /*if (authStatus == AuthStatus.notAuthenticated) {
        if (isGoinTo == '/login' || isGoinTo == '/registrarse') return null;

        return '/login';
      }*/
      //aqaui puedo aplicar validaciones por ROLES y direccionar a otra pantalla o screen
      /*if (authStatus == AuthStatus.authenticated) {
        if (user?.roles.contains('ciudadano') == true) {
          if (isGoinTo == '/menu_administrador/0') {
            return '/menu_principal/0';
          }
        } else if (user?.roles.contains('administrador') == true) {
          if (isGoinTo == '/menu_principal/0') {
            return '/menu_administrador/0';
          }
        }
      }*/
      if (authStatus == AuthStatus.authenticated) {
        if (isGoinTo == '/login' ||
            isGoinTo == '/registrarse' ||
            isGoinTo == '/splashchecklogin' ||
            isGoinTo == '/tutorial') {
          return '/autonortapp/menu_principal/0';
        }
      }

      return null;
    },
  );
});
