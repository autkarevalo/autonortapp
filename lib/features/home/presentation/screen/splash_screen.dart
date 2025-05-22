import 'dart:async';

import 'package:autonort/features/shared/providers/connectivity_provider.dart';
import 'package:autonort/features/shared/providers/server_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    //Temporazidador que espera 3 segundos o condicionando antes de pasar a otra pantalla
    /*Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/tutorial'); // Navega solo si el widget aun esta montado
      } //podemos remplazar con nuestra ruta
    });*/
    _initialize();
  }

  Future<void> _initialize() async {
    await Future.delayed(const Duration(seconds: 2));

    final connectivityRepo = ref.read(connectivityRepoProvider);
    final netEither = await connectivityRepo.checkNetwork();

    await netEither.fold((failure) {
      _showError(failure.message);
    }, (hasNet) async {
      if (!hasNet) {
        //aunque en mi impl siempre vendra left si no hay red,
        //ponemos esta rama por completitud
        _showError('No hay conexion a Internet');
        return;
      }

      //chequeo de salud del servidor
      final serverRepo = ref.read(serverRepoProvider);
      final srvEither = await serverRepo.pingServer();

      srvEither.fold((failure) {
        //mostrarmos el failure.message que viene de mi JSON {message: '...'}
        _showError(failure.message);
      }, (isUp) {
        if (isUp) {
          //si todo esta OK navegamos
          if (mounted) {
            context.go('/tutorial');
          }
        } else {
          // Esta rama saldría si devuelves Right(false),
          // pero en tu impl lo convertimos a Left
          _showError('Respuesta inesperada del servidor');
        }
      });
    });
  }

  void _showError(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Error de conexión'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              // Reintenta todo otra vez
              _initialize();
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //obtener dimensiones de la pantalla
    final size = MediaQuery.of(context).size;
    final dimension = size.width < size.height ? size.width : size.height;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/fondoinicioapp.png'),
                    fit: BoxFit.cover)),
          ),
          //Indicador de Carga
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: height * 0.1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Spacer(),
                  SizedBox(
                    width: dimension * 0.2,
                    height: dimension * 0.2,
                    child: CircularProgressIndicator(
                      strokeWidth: dimension * 0.02,
                      color: Colors.redAccent.shade700,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    "Iniciando.....",
                    style: TextStyle(
                        fontSize: width * 0.05,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey.shade700),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
