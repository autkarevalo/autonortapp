import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/providers/provider.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/widgets/leyenda_estados.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InfoTecnicoCard extends ConsumerWidget {
  const InfoTecnicoCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(horastecnicosProvider);
    final fecha = DateTime.now();

    if (state.tecnicos.isEmpty) {
      return const SizedBox();
    }

    final tecnico = state.tecnicos.first;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Codigo: ${tecnico.codigo ?? '-'}'),
                Text('Fecha: ${fecha.day}-${fecha.month}-${fecha.year}')
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              'Tecnico: ${tecnico.trabajador ?? '--'}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text('Leyenda:',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            const LeyendaEstados(),
          ],
        ),
      ),
    );
  }
}
