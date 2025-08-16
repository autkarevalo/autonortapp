import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';
import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/providers/provider.dart';
import 'package:autonort/features/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class DialogoInicialSucfechaWidget extends ConsumerStatefulWidget {
  final void Function(Sucursales sucursal, DateTime fecha) onConfirm;

  const DialogoInicialSucfechaWidget({super.key, required this.onConfirm});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DialogoInicialSucFechaState();
}

class _DialogoInicialSucFechaState
    extends ConsumerState<DialogoInicialSucfechaWidget> {
  DateTime _fecha = DateTime.now();
  String? _sucursalNombre; // para guardar la descripcion para el dropdown

  @override
  void initState() {
    super.initState();
    //cargar sucursales al abrir el dialogo
    Future.microtask(() async {
      final notifier = ref.read(ingresosalidavhProvider.notifier);
      await notifier.listarSucursales(codempresa: '004');
      //2 si cargo y no hay seleccion preselecciona la primera
      final state = ref.read(ingresosalidavhProvider);
      if (!state.isLoading &&
          state.message == null &&
          state.sucursales.isNotEmpty) {
        setState(() {
          _sucursalNombre = state.sucursales.first.sucursal;
        });
      }
    });
  }

  Future<void> _pickFecha() async {
    final f = await showDatePicker(
      context: context,
      initialDate: _fecha,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (f != null) setState(() => _fecha = f);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(ingresosalidavhProvider);

    //3 escuchar errores y muestra snackBar
    ref.listen(ingresosalidavhProvider, (prev, next) {
      if (prev?.message != next.message && next.message != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(next.message!)));
        });
      }
    });

    final fechaTexto = DateFormat('dd-MM-yyyy').format(_fecha);

    final itemsSucursal = state.sucursales.map((s) => s.sucursal).toList();

    final cargando = state.isLoading;
    final hayerror = state.message != null;
    final haydatos = state.sucursales.isNotEmpty;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: const Text('Seleccione sucursal y fecha'),
      content: SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              dense: true,
              leading: const Icon(Icons.calendar_today),
              title: Text('Fecha: $fechaTexto'),
              onTap: _pickFecha,
            ),
            const SizedBox(
              height: 12,
            ),

            //Sucursal loading / error / dropdown
            if (cargando)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (hayerror)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  state.message!,
                  style: const TextStyle(color: Colors.red),
                ),
              )
            else if (haydatos)
              CustomDropdownFormField(
                label: 'Sucursal',
                prefixIcon: Icons.location_on,
                items: itemsSucursal,
                selectedItem: _sucursalNombre,
                onChanged: (value) => setState(() => _sucursalNombre = value),
              )
            else
              const Text('No se encontraron suscursales')
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
            onPressed: (!haydatos || _sucursalNombre == null)
                ? null
                : () {
                    final suc = state.sucursales.firstWhere(
                      (s) => s.sucursal == _sucursalNombre,
                      orElse: () => state.sucursales.first,
                    );
                    widget.onConfirm(suc, _fecha);
                  //  Navigator.of(context).pop();
                  },
            child: const Text('Aceptar'))
      ],
    );
  }
}
