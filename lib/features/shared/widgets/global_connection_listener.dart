import 'package:autonort/features/shared/shared.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';


class GlobalConnectionListener extends ConsumerStatefulWidget {
  final Widget child;
  final GlobalKey<ScaffoldMessengerState> messengerKey;
  const GlobalConnectionListener(
      {super.key, required this.child, required this.messengerKey});

  @override
  ConsumerState<GlobalConnectionListener> createState() =>
      _GlobalConnectionListenerState();
}

class _GlobalConnectionListenerState
    extends ConsumerState<GlobalConnectionListener> {
  // Para no spamear SnackBar si ya está mostrado
  bool _networkSnackShowing = false;
  bool _serverSnackShowing = false;
  bool _didListen = false;

  @override
  Widget build(BuildContext context) {
    if (!_didListen) {
      _didListen = true;
      //Escuchar cambios de red local
      ref.listen<AsyncValue<List<ConnectivityResult>>>(
        connectivityStreamProvider,
        (prev, next) => next.whenData(_onConnectivityChanged),
      );

      //Escuchar cambios de salud del servidor
      ref.listen<AsyncValue<bool>>(serverHealthStreamProvider,
          (prev, next) => next.whenData(_onServerHealthChanged));
    }
    // Sólo devolvemos el child; la lógica de snackbars ya corre sobre esos listeners
    return widget.child;
  }

  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
       final anyInterface =
        results.any((r) => r != ConnectivityResult.none);

      final hasInternet = anyInterface
        ? await InternetConnectionChecker.instance.hasConnection
        : false;

    final messenger = widget.messengerKey.currentState!;

    if (!hasInternet) {
      if (!_networkSnackShowing) {
        _networkSnackShowing = true;
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Sin conexion a Internet'),
            backgroundColor: Colors.red,
            duration: Duration(days: 1),
          ),
        );
      }
    } else {
      if (_networkSnackShowing) {
        messenger.hideCurrentSnackBar();
        _networkSnackShowing = false;
        // Luego muestro mensaje verde de recuperación
        messenger.showSnackBar(
          const SnackBar(
            content: Text('De nuevo en línea'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _onServerHealthChanged(bool isUp) {
 final messenger = widget.messengerKey.currentState!;
    if (!isUp) {
      if (!_serverSnackShowing) {
        _serverSnackShowing = true;
        messenger.showSnackBar(SnackBar(
          content: const Text('Servidor no disponible'),
          backgroundColor: Colors.amber,
          action: SnackBarAction(
            label: 'Reintentar',
            textColor: Colors.black,
            onPressed: () => ref.invalidate(serverHealthStreamProvider),
          ),
          duration: const Duration(days: 1),
        ));
      }
    } else {
      if (_serverSnackShowing) {
        // Oculta el snackbar de servidor si vuelve a estar UP
        messenger.hideCurrentSnackBar();
        _serverSnackShowing = false;
        //mostramos el mensaje verde de recuperacion
        messenger.showSnackBar(const SnackBar(
          content: Text('Servidor disponible'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ));
      }
    }
  }
}
