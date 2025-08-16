import 'package:flutter/material.dart';

class LeyendaEstados extends StatelessWidget {
  const LeyendaEstados({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> estados = [
      {'label': 'PENDIENTE', 'color': Colors.orange, 'icon': Icons.access_time},
      {'label': 'INICIADO', 'color': Colors.green, 'icon': Icons.play_arrow},
      {'label': 'PARALIZADO', 'color': Colors.yellow, 'icon': Icons.pause},
      {'label': 'FINALIZADO', 'color': Colors.red, 'icon': Icons.stop}
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        spacing: 8,
        children: estados.map((estado) {
          final String label = estado['label'] as String;
          final Color color = estado['color'] as Color;
          final IconData icon = estado['icon'] as IconData;
          return Chip(
            labelPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            backgroundColor: color,
            label: Row(
              mainAxisSize: MainAxisSize.min,

              children: [
                Icon(icon,size: 14, color: Colors.black,),
                const SizedBox(width: 4),
                Text(
                  label,
                  style: const TextStyle(fontSize: 10,fontWeight: FontWeight.bold,color: Colors.black
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20)
            ),
          );
        }).toList(),
      ),
    );
  }
}
