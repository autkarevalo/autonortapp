import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    FlutterNativeSplash.remove();
    //Temporazidador que espera 3 segundos o condicionando antes de pasar a otra pantalla
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        context.go('/tutorial'); // Navega solo si el widget aun esta montado
      } //podemos remplazar con nuestra ruta
    });
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
                image:
                    DecorationImage(image: AssetImage('assets/images/fondoinicioapp.png'), fit: BoxFit.cover)),
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
