import 'package:autonort/config/router/app_router_notifier.dart';
import 'package:autonort/features/auth/presentation/screens/check_auth_status_screen.dart';
import 'package:autonort/features/auth/presentation/screens/login_screen.dart';
import 'package:autonort/features/home/presentation/screen/screen.dart';
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
          GoRoute(path: '/tutorial',
          builder: (context, state) => TutorialScreen(),),

          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),)
      ]);
});
