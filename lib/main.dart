import 'package:autonort/config/config.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  FlutterNativeSplash.preserve(
      widgetsBinding: WidgetsFlutterBinding.ensureInitialized());

  await Environment.initEnvironment();

  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  // 1) Creamos la key estática
  static final _messengerKey = GlobalKey<ScaffoldMessengerState>();
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: appRouter,
      scaffoldMessengerKey: _messengerKey,
      builder: (context, child) {
        return GlobalConnectionListener(
            messengerKey: _messengerKey,
            child: InactividadWatcher(
                timeoutDuration: Duration(minutes: 2),
                child: child ?? const SizedBox()));
      },
      theme: AppTheme().getTheme(),
      debugShowCheckedModeBanner: false,
      locale: const Locale('es'),
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
    );
  }
}
