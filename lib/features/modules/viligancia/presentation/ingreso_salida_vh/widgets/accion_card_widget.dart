import 'package:flutter/material.dart';

class AccionCardWidget extends StatefulWidget {
  const AccionCardWidget({super.key});

  @override
  State<AccionCardWidget> createState() => _AccionCardWidgetState();
}

class _AccionCardWidgetState extends State<AccionCardWidget> {
  bool esIngreso = true;

  @override
  Widget build(BuildContext context) {
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
              'Acción',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => esIngreso = true),
                    icon: const Icon(Icons.login, size: 20),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Ingreso Vehiculo',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: esIngreso ? Colors.green : Colors.grey.shade300,
                      foregroundColor: esIngreso ? Colors.white : Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => setState(() => esIngreso = false),
                    icon: const Icon(Icons.logout, size: 20),
                    label: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Salida Vehículo',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: !esIngreso ? Colors.green : Colors.grey.shade300,
                      foregroundColor: !esIngreso ? Colors.white : Colors.black87,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
