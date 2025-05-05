import 'dart:async';

import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget global que detecta inactividad del usuario en cualquier parte de la app.
/// Si no se detecta interacción durante [timeoutDuration], se cierra la sesión automáticamente.
class InactividadWatcher extends ConsumerStatefulWidget {
  final Widget child;

  /// Tiempo máximo de inactividad permitido (por defecto: 15 minutos).
  final Duration timeoutDuration;

  const InactividadWatcher(
      {super.key,
      required this.child,
      this.timeoutDuration = const Duration(minutes: 2)});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InactividadWatcherState();
}

class _InactividadWatcherState extends ConsumerState<InactividadWatcher> {
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    _inactivityTimer?.cancel();
    super.dispose();
  }

  /// Reinicia el temporizador cada vez que se detecta actividad del usuario.
  void _resetTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = Timer(widget.timeoutDuration, _handleInactivity);
  }

  /// Acción que se ejecuta cuando hay inactividad.
  void _handleInactivity() async {
    if (!mounted) return;

    final messenger = ScaffoldMessenger.maybeOf(context);

    messenger?.showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        backgroundColor: const Color(0xFFE30613),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        content: Row(
          children: const [
            Icon(Icons.info_outline, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Text(
                'Al no encontrar actividad, hemos cerrado tu sesión por seguridad.',
                style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );

    // Esperamos que el usuario vea el mensaje antes de cerrar sesión
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    // Logout global y redirección automática (controlada por go_router redirect)
    ref
        .read(authProvider.notifier)
        .logout('Autonort S.A.C: Sesión cerrada por inactividad');
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _resetTimer(), //detecta cualquier toque
      child: widget.child,
    );
  }
}
