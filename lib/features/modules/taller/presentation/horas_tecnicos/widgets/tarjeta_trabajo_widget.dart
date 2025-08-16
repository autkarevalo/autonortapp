import 'package:autonort/features/modules/taller/dominio/dominio.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TarjetaTrabajoWidget extends ConsumerWidget {
  final Trabajo trabajo;
  const TarjetaTrabajoWidget({super.key, required this.trabajo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bgColor = _getColorPorEstado(trabajo.statusTrab);
    final textColor = (trabajo.statusTrab?.toUpperCase() == 'PARALIZADO')
        ? Colors.black
        : Colors.white;

    final estado = trabajo.statusTrab?.toUpperCase();

    final bool isPendiente = estado == 'PENDIENTE';
    final bool isIniciado = estado == 'INICIADO';
    final bool isParalizado = estado == 'PARALIZADO';
    final bool isReiniciado = estado == 'REINICIADO';
    final bool isFinalizado = estado == 'FINALIZADO';

    final bool canIniciar = isPendiente || isParalizado;
    final bool canPausar = isIniciado || isReiniciado;
    final bool canFinalizar = isIniciado || isReiniciado;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withAlpha(25),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // OT
            Text(
              trabajo.ot ?? '',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              trabajo.actividad ?? '',
              style: TextStyle(fontSize: 14, color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              'Vehículo: ${trabajo.vh ?? ''} - ${trabajo.modelo ?? ''}',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              'Responsable: ${trabajo.responsable ?? ''}',
              style: TextStyle(color: textColor),
            ),
            const SizedBox(height: 4),
            Text(
              'Inicio: ${_formatearFechaHora(trabajo.fini, trabajo.hini)} | Fin: ${_formatearFechaHora(trabajo.ffin, trabajo.hfin)}',
              style: TextStyle(fontSize: 12, color: textColor.withAlpha(204)),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _BotonAccion(
                  icon: Icons.play_arrow,
                  tooltip: 'Iniciar Trabajo',
                  color: Colors.lightGreen,
                  enabled: canIniciar && !isFinalizado,
                  onPressed: canIniciar && !isFinalizado
                      ? () {
                          showCambioEstadoTrabajoModal(
                            context: context,
                            ref: ref,
                            trabajo: trabajo,
                            accion: 1, // 1 = Iniciar
                          );
                        }
                      : null,
                ),
                _BotonAccion(
                  icon: Icons.pause,
                  tooltip: 'Pausar Trabajo',
                  color: Colors.amber,
                  enabled: canPausar && !isFinalizado,
                  onPressed: canPausar && !isFinalizado
                      ? () {
                          showCambioEstadoTrabajoModal(
                              context: context,
                              ref: ref,
                              trabajo: trabajo,
                              accion: 2);
                        }
                      : null,
                ),
                _BotonAccion(
                  icon: Icons.stop,
                  tooltip: 'Finalizar Trabajo',
                  color: Colors.redAccent,
                  enabled: canFinalizar && !isFinalizado,
                  onPressed: canFinalizar && !isFinalizado
                      ? () {
                          showCambioEstadoTrabajoModal(
                              context: context,
                              ref: ref,
                              trabajo: trabajo,
                              accion: 3);
                        }
                      : null,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Color _getColorPorEstado(String? estado) {
    switch (estado?.toUpperCase()) {
      case 'PENDIENTE':
        return Colors.orange;
      case 'INICIADO':
        return Colors.green;
      case 'PARALIZADO':
        return Colors.yellow;
      case 'FINALIZADO':
        return Colors.red;
      case 'REINICIADO':
        return Colors.lightGreen;
      default:
        return Colors.grey;
    }
  }

  String _formatearFechaHora(DateTime? fecha, String? hora) {
    if (fecha == null || hora == null) return '';
    return '${fecha.day.toString().padLeft(2, '0')}/'
        '${fecha.month.toString().padLeft(2, '0')}/'
        '${fecha.year} $hora';
  }
}

class _BotonAccion extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final Color color;
  final VoidCallback? onPressed;
  final bool enabled;

  const _BotonAccion(
      {required this.icon,
      required this.tooltip,
      required this.color,
      required this.onPressed,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    final displayColor = enabled ? color : Colors.grey;
    return Tooltip(
      message: tooltip,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 4,
              offset: const Offset(1, 2),
            )
          ],
        ),
        child: IconButton(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: displayColor,
              size: 25,
            )),
      ),
    );
  }
}
