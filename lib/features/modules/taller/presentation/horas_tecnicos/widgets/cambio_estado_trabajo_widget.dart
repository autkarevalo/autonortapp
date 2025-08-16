import 'package:autonort/features/modules/taller/dominio/dominio.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/providers/provider.dart';
import 'package:autonort/features/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

Future<void> showCambioEstadoTrabajoModal(
    {required BuildContext context,
    required WidgetRef ref,
    required Trabajo trabajo,
    required int accion}) async {
  if (accion == 2) {
    await ref
        .read(horastecnicosProvider.notifier)
        .mostrarlistamotivos(codempresa: '004');
  }
  String textAccion = switch (accion) {
    1 => (trabajo.statusTrab?.toUpperCase() == 'PARALIZADO')
        ? 'REINICIAR'
        : 'INICIAR',
    2 => 'PAUSAR',
    3 => 'FINALIZAR',
    _ => 'ACCION DESCONOCIDA',
  };

  final mensaje =
      'Autonort S.A.C Dice: Desea $textAccion el trabajo de ${trabajo.trabajo ?? ''} de la ${trabajo.ot ?? ''}';

  String? motivoSeleccionado;
  final TextEditingController descripcionController = TextEditingController();

  // 👉 Ahora sí puedes mostrar el modal
  if (!context.mounted) return;
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
    backgroundColor: const Color(0xFFEFEFEF),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Consumer(
            builder: (context, ref, _) {
              final motivos = ref
                  .watch(horastecnicosProvider)
                  .motivos
                  .map((m) => m.descripcion)
                  .whereType<String>()
                  .toList();

              return StatefulBuilder(
                builder: (context, setState) => SingleChildScrollView(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Dialogo cambio de estado trabajo: ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Lottie.asset(
                        'assets/animations/tecnico.json',
                        height: 200,
                        repeat: true,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        mensaje,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87),
                      ),
                      if (accion == 2) ...[
                        const SizedBox(height: 20),
                        CustomDropdownFormField(
                            label: 'Motivo de pausa',
                            hint: 'Seleccione Motivo',
                            items: motivos,
                            selectedItem: motivoSeleccionado,
                            onChanged: (value) {
                              setState(
                                () {
                                  motivoSeleccionado = value;
                                },
                              );
                            }),
                        const SizedBox(height: 12),
                        TextFormField(
                          controller: descripcionController,
                          maxLines: 2,
                          decoration: const InputDecoration(
                            hintText: 'Descripción',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: () async {
                                if (accion == 1) {
                                  if (trabajo.statusTrab?.toUpperCase() ==
                                      'PENDIENTE') {
                                    final response = await ref
                                        .read(horastecnicosProvider.notifier)
                                        .registrariniciotrabajo(
                                            codempresa: '004',
                                            idprogot:
                                                trabajo.idprogot.toString(),
                                            idzona: trabajo.idzona ?? 0,
                                            idtecnico1: '70222667');
                                    if (response != null &&
                                        response.status == 'success') {
                                      //refrescamos trabajos
                                      await ref
                                          .read(horastecnicosProvider.notifier)
                                          .cargarlistatrabajostecnico(
                                              codempresa: '004',
                                              idtecnico: '70222667');
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Error al Iniciar el trabajo')));
                                      }
                                    }
                                  } else if (trabajo.statusTrab
                                          ?.toUpperCase() ==
                                      'PARALIZADO') {
                                    final response = await ref
                                        .read(horastecnicosProvider.notifier)
                                        .reiniciartrabajo(
                                            codempresa: '004',
                                            idprogot:
                                                trabajo.idprogot.toString(),
                                            idzona: trabajo.idzona ?? 0,
                                            idtecnico1: '70222667');
                                    if (response != null &&
                                        response.status == 'success') {
                                      await ref
                                          .read(horastecnicosProvider.notifier)
                                          .cargarlistatrabajostecnico(
                                              codempresa: '004',
                                              idtecnico: '70222667');
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Error al Reiniciar el trabajo')));
                                      }
                                    }
                                  } else {
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Solo se puede iniciar un trabajo pendiente')));
                                    }
                                  }
                                } else if (accion == 2) {
                                  if (trabajo.statusTrab?.toUpperCase() ==
                                      'INICIADO') {
                                    if (motivoSeleccionado == null) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Debe seleccionar un motivo')),
                                      );
                                      return;
                                    }
                                    final motivo = ref
                                        .read(horastecnicosProvider)
                                        .motivos
                                        .firstWhere((m) =>
                                            m.descripcion ==
                                            motivoSeleccionado);
                                    final response = await ref
                                        .read(horastecnicosProvider.notifier)
                                        .paralizartrabajo(
                                          codempresa: '004',
                                          idprogot: trabajo.idprogot.toString(),
                                          idtecnico1: '70222667',
                                          itemd: trabajo.itemd ?? '',
                                          idmotivop: motivo.idmotivop ?? 0,
                                          nota:
                                              descripcionController.text.trim(),
                                        );

                                    if (response != null &&
                                        response.status == 'success') {
                                      await ref
                                          .read(horastecnicosProvider.notifier)
                                          .cargarlistatrabajostecnico(
                                            codempresa: '004',
                                            idtecnico: '70222667',
                                          );
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    } else {
                                      if (context.mounted) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                content: Text(
                                                    'Error al paralizar el trabajo')));
                                      }
                                    }
                                  }
                                } else if (accion == 3) {
                                  final response = await ref
                                      .read(horastecnicosProvider.notifier)
                                      .finalizartrabajo(
                                          codempresa: '004',
                                          idprogot: trabajo.idprogot.toString(),
                                          idtecnico1: '70222667',
                                          itemd: trabajo.itemd ?? '');
                                  if (response != null &&
                                      response.status == 'success') {
                                    await ref
                                        .read(horastecnicosProvider.notifier)
                                        .cargarlistatrabajostecnico(
                                          codempresa: '004',
                                          idtecnico: '70222667',
                                        );
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  } else {
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  'Error al finalizar el trabajo')));
                                    }
                                  }
                                }
                              },
                              icon: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                              label: const Text('Confirmar',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                              style: FilledButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14)),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => Navigator.of(context).pop(),
                              icon: const Icon(
                                Icons.logout,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Salir',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  side: const BorderSide(color: Colors.red),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14)),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
