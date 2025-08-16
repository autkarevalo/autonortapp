import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BusquedaCardWidget extends ConsumerWidget {
  final String fechaActual;
  const BusquedaCardWidget({super.key,required this.fechaActual});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = TextEditingController();
    final screenWidth = MediaQuery.of(context).size.width;

    // Define si es una pantalla pequeña para reducir tamaño de botones
    final bool isSmallScreen = screenWidth < 380;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Buscar Vehículo',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                // El campo ocupa el resto del espacio disponible
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      labelText: 'Placa / Serie',
                      prefixIcon: const Icon(Icons.directions_car),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      isDense: true, // Hace más compacto
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                _buildButton(
                  Icons.search,
                  isSmall: isSmallScreen,
                  onPressed: () {
                    ref
                        .read(ingresosalidavhProvider.notifier)
                        .buscarvhingsalida(
                            codempresa: '004',
                            fecha: fechaActual,
                            codvehiculo: textController.text.trim());
                  },
                ),
                const SizedBox(width: 4),
                _buildButton(Icons.camera_alt, isSmall: isSmallScreen,onPressed: () {
                  //logica para la camara
                },),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Botón reutilizable con tamaño adaptable
  Widget _buildButton(IconData icon,
      {required bool isSmall, required VoidCallback onPressed}) {
    final double size = isSmall ? 42 : 48;
    final double iconSize = isSmall ? 20 : 24;

    return SizedBox(
      width: size,
      height: size,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          backgroundColor: Colors.redAccent,
        ),
        child: Icon(icon, color: Colors.white, size: iconSize),
      ),
    );
  }
}
