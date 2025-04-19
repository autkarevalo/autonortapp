
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class CheckAuthStatusScreen extends ConsumerWidget {
  const CheckAuthStatusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

   return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
        ),
      ),
    );
   // final authStatus = ref.watch(authProvider).authStatus;

    //USUAMOS FUTURE MICROTASK  para evitar conflictos en el ciclo de constrruccion
    /*WidgetsBinding.instance.addPostFrameCallback((_) {
      if (authStatus == AuthStatus.authenticated) {
        context.go('/home');
      } else if (authStatus == AuthStatus.notAuthenticated) {
        context.go('/login');
      }
       // Si está en "checking", no hacemos nada todavía.
    });*/
 
  }
}
