import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutMenuPrincipalView extends ConsumerWidget {
  const AutMenuPrincipalView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;

    //accedemos al usuario autenticado
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final nombre = user?.nombre ?? 'Usuario';

    return Scaffold(
      body: Stack(
        children: [
          //FONDO PANTALLA
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.5,
              child: Container(
                decoration: BoxDecoration(
                    image: const DecorationImage(
                        image: AssetImage('assets/images/fondoinicioapp.png'),
                        fit: BoxFit.fill),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
              )),

          //Overlay semi transparante rojo

          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * 0.3,
              child: Container(
                decoration: BoxDecoration(
                    color: const Color(0xB3e30613).withAlpha((0.70 * 255).toInt()),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )),
              )),

          //iconos y texto
          Positioned(
              top: 40,
              left: 20,
              right: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: Colors.white, size: 30),
                  const Icon(Icons.notifications,
                      color: Colors.white, size: 30),
                ],
              )),
          //texto y avatar
          Positioned(
              top: size.height * 0.15,
              left: 20,
              right: 20,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Hola, \n$nombre',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: size.width * 0.05,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  CircleAvatar(
                      radius: 35,
                      backgroundImage:
                          const AssetImage('assets/images/avatar.png')
                              as ImageProvider
                      /*user?.photoUrl != null
                      ? NetworkImage(user!.photoUrl!)
                      : const AssetImage('assets/images/perfil.png')
                          as ImageProvider, */
                      )
                ],
              )),
          // Zona de contenido adicional (cards, etc.)
          Positioned(
              top: size.height * 0.32,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: const [
                    /*aqui colocamos el dashboard de inicio como acceso directos noticias etc  */
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
