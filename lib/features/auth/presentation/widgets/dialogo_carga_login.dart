import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum DialogoCargaLoginEstado {
  cargando,
  credencialesIncorrectas,
  errorDesconocido
}

class DialogoCargaLogin extends StatelessWidget {
  final DialogoCargaLoginEstado estado;

  const DialogoCargaLogin({super.key, required this.estado});

  @override
  Widget build(BuildContext context) {
    String mensaje = '';
    String lottieAsset = '';
    switch (estado) {
      case DialogoCargaLoginEstado.cargando:
        mensaje =
            'Autonort S.A.C dice: Se esta validando susu credenciales, espere un momento ....';
        lottieAsset = 'assets/animations/loadinglogin.json'; //cambiar
        break;
      case DialogoCargaLoginEstado.credencialesIncorrectas:
        mensaje = 'Credenciales incorrectas, verifique su usuario o clave';
        lottieAsset = 'assets/animations/olvidoclave.json'; //cargar
        break;
      case DialogoCargaLoginEstado.errorDesconocido:
        mensaje =
            'Ocurrio un error inesperado, verifique su conexion o contacte soporte';
        lottieAsset = 'assets/animations/errordesconocido.json';
        break;
    }
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(
            lottieAsset,
            width: 150,
            height: 150,
            fit: BoxFit.contain,
            repeat: estado == DialogoCargaLoginEstado.cargando,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
