import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/providers/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:autonort/features/shared/widgets/widgets.dart';

class IngresoSalidavhCardWidget extends ConsumerStatefulWidget {
  const IngresoSalidavhCardWidget({super.key});

  @override
  ConsumerState<IngresoSalidavhCardWidget> createState() =>
      _IngresoSalidavhCardState();
}

class _IngresoSalidavhCardState
    extends ConsumerState<IngresoSalidavhCardWidget> {
  bool tieneCita = true;
  DateTime fecha = DateTime.now();
  TimeOfDay hora = TimeOfDay.now();
  String? areaSeleccionada;
  String? motivoSeleccionado;

  //final List<String> areas = ['Seminuevos', 'Postventa', 'Mecánica'];
  //final List<String> motivos = ['Diagnóstico', 'Entrega', 'Prueba'];

  bool _cargandoMotivos = false;

  Future<void> _seleccionarHora() async {
    final TimeOfDay? horaSeleccionada = await showTimePicker(
      context: context,
      initialTime: hora,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );
    if (horaSeleccionada != null) {
      setState(() => hora = horaSeleccionada);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ingresosalidavhProvider);
    final vh = state.vehiculoingsalida.isNotEmpty
        ? state.vehiculoingsalida.first
        : null;
    final bool tieneCita = (vh?.idcita != null && vh!.idcita!.isNotEmpty);
    final String horaTexto = hora.format(context);
    final String fechaTexto = DateFormat('dd-MM-yyyy').format(fecha);

    //construir el listado de areas desde el provider (asegurando String no-nulo)
    final List<String> areasItems =
        state.areas.map((a) => a.area).where((s) => s.isNotEmpty).toList();

    //Motivos desde provider
    final List<String> motivosItems = state.motivos
        .map((m) => m.motivo ?? '')
        .where((s) => s.isNotEmpty)
        .toList();

    final bool cargandoAreas = state.isLoading && state.areas.isEmpty;
    final bool hayErroresAreas = state.message != null && state.areas.isEmpty;

    //si no hay seleccion y ya cargharon las areas, preselecciona la primera
    /*if (areaSeleccionada == null && areasItems.isNotEmpty) {
      // Nota: esto se ejecuta en build; si no quieres que pase en cada build,
      // puedes envolverlo en un microtask/flag.
      areaSeleccionada = areasItems.first;
    }*/

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
              'Información Ingreso / Salida',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '¿Tiene Cita?',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: tieneCita ? Colors.green : Colors.grey,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Colors.white, size: 16),
                              const SizedBox(width: 6),
                              Text(
                                tieneCita ? 'SI' : 'NO',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Fecha:',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(width: 6),
                            Text(fechaTexto),
                          ],
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: _seleccionarHora,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Hora:',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(width: 8),
                                Text(horaTexto),
                                const SizedBox(width: 10),
                                const Icon(Icons.access_time, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // ====AREA DESDE EL PROVIDER====
                if (cargandoAreas)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else if (hayErroresAreas && areasItems.isEmpty)
                  Text(
                    state.message!,
                    style: const TextStyle(color: Colors.red),
                  )
                else
                  CustomDropdownFormField(
                    label: 'Área',
                    hint: 'Seleccione área',
                    items: areasItems,
                    selectedItem: areaSeleccionada,
                    prefixIcon: Icons.settings,
                    onChanged: (value) async {
                      setState(() {
                        areaSeleccionada = value;
                        motivoSeleccionado = null;
                        _cargandoMotivos = true;
                      });

                      if (value != null && value.isNotEmpty) {
                        await ref
                            .read(ingresosalidavhProvider.notifier)
                            .listarmotivosxarea(codempresa: '004', area: value);
                      } else {
                        //si el usuario borra la seleccion (si lo permito), limpias motivos
                        // ref.read(ingresosalidavhProvider.notifier)
                        //    .limpiarMotivos(); // si creas ese método
                      }
                      if (mounted) {
                        setState(() {
                          _cargandoMotivos = false;
                        });
                      }
                    },
                  ),

                const SizedBox(height: 16),

                // ==== Motivos ====
                if (_cargandoMotivos)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  CustomDropdownFormField(
                    label: 'Motivo',
                    hint: motivosItems.isEmpty
                        ? 'No hay Motivos'
                        : 'Seleccione motivo',
                    items: motivosItems,
                    selectedItem: motivoSeleccionado,
                    prefixIcon: Icons.settings,
                    onChanged: motivosItems.isEmpty
                        ? null
                        : (value) => setState(() => motivoSeleccionado = value),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
