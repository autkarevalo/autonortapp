import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InformacionVehiculoCardWidget extends ConsumerWidget {
  const InformacionVehiculoCardWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ingresosalidavhProvider);

    //si no hay resultados
    if (state.vehiculoingsalida.isEmpty) {
      return const SizedBox.shrink();
    }

    final vh = state.vehiculoingsalida.first;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: const Text(
              'Informacion del Vehículo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:  [
                _FilaDoble(
                    label1: 'Vehículo:',
                    valor1: vh.vehiculo ?? '',
                    label2: 'Id:',
                    valor2: vh.idvehiculo ?? ''),
                SizedBox(height: 10),
                _DatoLabelValor(label: 'Placa:', valor: vh.placa ?? ''),
                SizedBox(height: 10),
                _DatoLabelValor(
                    label: 'Modelo:', valor: vh.modelo ?? ''),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _FilaDoble extends StatelessWidget {
  final String label1;
  final String valor1;
  final String label2;
  final String valor2;

  const _FilaDoble({
    required this.label1,
    required this.valor1,
    required this.label2,
    required this.valor2,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label1,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(
          width: 90,
          child: Text(valor1),
        ),
        SizedBox(
          width: 30,
          child: Text(
            label2,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(valor2),
        ),
      ],
    );
  }
}

class _DatoLabelValor extends StatelessWidget {
  final String label;
  final String valor;
  const _DatoLabelValor({required this.label, required this.valor});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: Text(
            valor,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }
}
