import 'package:flutter/material.dart';

class SucursalFechaCardWidget extends StatelessWidget {
  final String nombreSucursal;
  final String fechaActual;

  const SucursalFechaCardWidget({
    super.key,
    required this.nombreSucursal,
    required this.fechaActual,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Wrap(
          alignment: WrapAlignment.spaceBetween,
          runSpacing: 8,
          spacing: 16,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.location_on_outlined, size: 20),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    nombreSucursal,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 6),
                Text(
                  fechaActual,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
