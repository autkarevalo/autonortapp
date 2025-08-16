import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';
import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/providers/provider.dart';
import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/widgets/widgets.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AutIngresosalidaVehiculoScreen extends ConsumerStatefulWidget {
  const AutIngresosalidaVehiculoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AutIngresosalidaVehiculoScreenState();
}

class _AutIngresosalidaVehiculoScreenState
    extends ConsumerState<AutIngresosalidaVehiculoScreen> {
  bool _dialogoLanzado = false;
  Sucursales? _sucursalSel;
  DateTime? _fechaSel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_dialogoLanzado) {
        _dialogoLanzado = true;
        _mostrarDialogoInicial();
      }
    });

    Future.microtask(() {
      ref.read(ingresosalidavhProvider.notifier).listarareas(codempresa: '004');
    });
  }

  Future<void> _mostrarDialogoInicial() async {
    final result = await showDialog<_SeleccionInicial>(
        context: context,
        barrierDismissible: false,
        builder: (_) => DialogoInicialSucfechaWidget(onConfirm: (suc, fecha) {
              Navigator.of(context).pop(_SeleccionInicial(suc, fecha));
            }));

    if (result != null) {
      setState(() {
        _sucursalSel = result.sucursal;
        _fechaSel = result.fecha;
      });
    } else {
      // opcional: volver a mostrar el diálogo o dejar valores por defecto
      // _mostrarDialogoInicial();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nombreSucursal = _sucursalSel?.sucursal ?? '- Selecciona sucursal -';
    final fechaActual = _fechaSel != null
        ? DateFormat('yyyy-MM-dd').format(_fechaSel!)
        : '-Seleccione fecha-';

    return AutScaffoldConDrawer(
      title: 'Ingreso / Salida Vehículo',
      mostrarAppBar: false,
      mostrarBottomNavigation: false,
      child: _ContenidoIngresoVehiculos(
        nombreSucursal: nombreSucursal,
        fechaActual: fechaActual,
      ),
    );
  }
}

class _SeleccionInicial {
  final Sucursales sucursal;
  final DateTime fecha;
  _SeleccionInicial(this.sucursal, this.fecha);
}

class _ContenidoIngresoVehiculos extends ConsumerWidget {
  final String nombreSucursal;
  final String fechaActual;
  const _ContenidoIngresoVehiculos(
      {required this.nombreSucursal, required this.fechaActual});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
              delegate: SliverChildListDelegate([
            SucursalFechaCardWidget(
                nombreSucursal: nombreSucursal, fechaActual: fechaActual),
            BusquedaCardWidget(fechaActual: fechaActual,),
            const SizedBox(height: 12),
            AccionCardWidget(),
            const SizedBox(height: 12),
            InformacionVehiculoCardWidget(),
            const SizedBox(height: 12),
            IngresoSalidavhCardWidget(),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {
                    //TODO : ACCION DE REGISTRAR
                  },
                  child: const Text(
                    'Registrar',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )),
            )
          ])),
        )
      ],
    );
  }
}
