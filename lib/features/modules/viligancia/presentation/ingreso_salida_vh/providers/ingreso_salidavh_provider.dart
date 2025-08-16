import 'package:autonort/features/modules/viligancia/dominio/dominio.dart';
import 'package:autonort/features/modules/viligancia/presentation/ingreso_salida_vh/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ingresosalidavhProvider =
    StateNotifierProvider<IngresoSalidavhNotifier, IngresoSalidavhState>((ref) {
  final ingresosalidavhRepo = ref.watch(ingresosalidavhRepositoryProvider);
  return IngresoSalidavhNotifier(vigilanciaRepositorio: ingresosalidavhRepo);
});

class IngresoSalidavhNotifier extends StateNotifier<IngresoSalidavhState> {
  final VigilanciaRepositorio vigilanciaRepositorio;
  IngresoSalidavhNotifier({required this.vigilanciaRepositorio})
      : super(IngresoSalidavhState.initial());

  Future<void> listarSucursales({required String codempresa}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final sucursales =
          await vigilanciaRepositorio.listarsucursales(codempresa);

      state = state.copyWith(isLoading: false, sucursales: sucursales);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar los sucursales: $e',
      );
    }
  }

  Future<void> listarareas({required String codempresa}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final areas = await vigilanciaRepositorio.listarareas(codempresa);

      state = state.copyWith(isLoading: false, areas: areas);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar las areas: $e',
      );
    }
  }

  Future<void> listarmotivosxarea(
      {required String codempresa, required String area}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final motivos =
          await vigilanciaRepositorio.listarmotivosporarea(codempresa, area);
      state = state.copyWith(isLoading: false, motivos: motivos);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar los motivos: $e',
      );
    }
  }

  Future<void> buscarvhingsalida(
      {required String codempresa,
      required String fecha,
      required String codvehiculo}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final vehiculoingsalida = await vigilanciaRepositorio.busquedavhingsalida(
          codempresa, fecha, codvehiculo);
      state = state.copyWith(
          isLoading: false, vehiculoingsalida: vehiculoingsalida);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al buscar el vehiculo: $e',
      );
    }
  }

  void cleardatosingresosalidavh() {
    state = state.copyWith(
      sucursales: [],
      areas: [],
      motivos: [],
      message: null,
    );
  }

  void clearbusquedavhingsalida() {
    state = state.copyWith(vehiculoingsalida: [], message: null);
  }
}

class IngresoSalidavhState {
  final bool isLoading;
  final List<Sucursales> sucursales;
  final List<Areas> areas;
  final List<Motivos> motivos;
  final List<VehiculoIngsalida> vehiculoingsalida;
  final String? message;

  IngresoSalidavhState(
      {required this.isLoading,
      required this.sucursales,
      required this.areas,
      required this.motivos,
      required this.vehiculoingsalida,
      required this.message});

  factory IngresoSalidavhState.initial() => IngresoSalidavhState(
      isLoading: false,
      sucursales: [],
      areas: [],
      motivos: [],
      vehiculoingsalida: [],
      message: null);

  IngresoSalidavhState copyWith(
          {bool? isLoading,
          List<Sucursales>? sucursales,
          List<Areas>? areas,
          List<Motivos>? motivos,
          List<VehiculoIngsalida>? vehiculoingsalida,
          String? message}) =>
      IngresoSalidavhState(
          isLoading: isLoading ?? this.isLoading,
          sucursales: sucursales ?? this.sucursales,
          areas: areas ?? this.areas,
          motivos: motivos ?? this.motivos,
          vehiculoingsalida: vehiculoingsalida ?? this.vehiculoingsalida,
          message: message ?? this.message);
}
