import 'package:autonort/features/modules/taller/dominio/dominio.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final horastecnicosProvider =
    StateNotifierProvider<HorasTecnicosNotifier, HorasTecnicosState>((ref) {
  final horastecnicosRepo = ref.watch(horastecnicosRepositoryProvider);
  return HorasTecnicosNotifier(tallerRepositorio: horastecnicosRepo);
});

class HorasTecnicosNotifier extends StateNotifier<HorasTecnicosState> {
  final TallerRepositorio tallerRepositorio;
  HorasTecnicosNotifier({required this.tallerRepositorio})
      : super(HorasTecnicosState.initial());

  Future<void> cargarinfotecnicos(
      {required String codempresa, required String idtecnico}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);

      final tecnicos =
          await tallerRepositorio.informaciontecnicos(codempresa, idtecnico);
      state = state.copyWith(isLoading: false, tecnicos: tecnicos);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar los tecnicos: $e',
      );
    }
  }

  Future<void> cargarlistatrabajostecnico(
      {required String codempresa, required String idtecnico}) async {
    try {
      state = state.copyWith(isLoading: false, message: null);

      final trabajos =
          await tallerRepositorio.listatrabajostecnicos(codempresa, idtecnico);

      state = state.copyWith(isLoading: false, trabajos: trabajos);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar trabajos del tecnico: $e',
      );
    }
  }

  Future<void> mostrarlistamotivos({required String codempresa}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);

      final motivos = await tallerRepositorio.listarmotivospausa(codempresa);

      state = state.copyWith(isLoading: false, motivos: motivos);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar trabajos del tecnico: $e',
      );
    }
  }

  Future<Operainiciotrabajo?> registrariniciotrabajo(
      {required String codempresa,
      required String idprogot,
      required int idzona,
      required String idtecnico1}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final iniciotrabajo = await tallerRepositorio.registrariniciotrabajo(
          codempresa, idprogot, idzona, idtecnico1);

      state = state.copyWith(isLoading: false);
      return iniciotrabajo;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al guardar el inicio del trabajo: $e',
      );

      return null;
    }
  }

  Future<Operaparalizatrabajo?> paralizartrabajo(
      {required String codempresa,
      required String idprogot,
      required String idtecnico1,
      required String itemd,
      required int idmotivop,
      required String nota}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final paralizatrabajo = await tallerRepositorio.paralizatrabajo(
          codempresa, idprogot, idtecnico1, itemd, idmotivop, nota);
      state = state.copyWith(isLoading: false);
      return paralizatrabajo;
    } catch (e) {
      state = state.copyWith(
          isLoading: false, message: 'Error al paralizar el trabajo: $e');
      return null;
    }
  }

  Future<Operafintrabajo?> finalizartrabajo(
      {required String codempresa,
      required String idprogot,
      required String idtecnico1,
      required String itemd}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final finalizartrabajo = await tallerRepositorio.finalizartrabajo(
          codempresa, idprogot, idtecnico1, itemd);
      state = state.copyWith(isLoading: false);
      return finalizartrabajo;
    } catch (e) {
      state = state.copyWith(
          isLoading: false, message: 'Error en finalizar el trabajo: $e');
      return null;
    }
  }

  Future<Operareiniciotrabajo?> reiniciartrabajo(
      {required String codempresa,
      required String idprogot,
      required int idzona,
      required String idtecnico1}) async {
    try {
      state = state.copyWith(isLoading: true, message: null);
      final reiniciotrabajo = await tallerRepositorio.reiniciartrabajo(
          codempresa, idprogot, idzona, idtecnico1);
      state = state.copyWith(isLoading: false);
      return reiniciotrabajo;
    } catch (e) {
      state = state.copyWith(
          isLoading: false,
          message: 'Error al guardar el reinicio del trabajo: $e');
      return null;
    }
  }

  void cleardatoshorastecnicos() {
    state = state.copyWith(
        tecnicos: [],
        respoperainitrabajo: null,
        resoperaparalizatrab: null,
        resoperareiniciartrab: null,
        resoperafinalizartrab: null,
        message: null,
        trabajos: []);
  }
}

class HorasTecnicosState {
  final bool isLoading;
  final List<Tecnicos> tecnicos;
  final List<Trabajo> trabajos;
  final List<Motivos> motivos;
  final Operainiciotrabajo? respoperainitrabajo;
  final Operaparalizatrabajo? resoperaparalizatrab;
  final Operareiniciotrabajo? resoperareiniciartrab;
  final Operafintrabajo? resoperafinalizartrab;
  final String? message;

  HorasTecnicosState(
      {required this.isLoading,
      required this.tecnicos,
      required this.trabajos,
      required this.motivos,
      this.respoperainitrabajo,
      this.resoperaparalizatrab,
      this.resoperareiniciartrab,
      this.resoperafinalizartrab,
      this.message});

  //Estado inicial por defecto
  factory HorasTecnicosState.initial() => HorasTecnicosState(
      isLoading: false,
      tecnicos: [],
      trabajos: [],
      motivos: [],
      respoperainitrabajo: null,
      resoperaparalizatrab: null,
      resoperareiniciartrab: null,
      resoperafinalizartrab: null,
      message: null);

  HorasTecnicosState copyWith({
    bool? isLoading,
    List<Tecnicos>? tecnicos,
    List<Trabajo>? trabajos,
    List<Motivos>? motivos,
    Operainiciotrabajo? respoperainitrabajo,
    Operaparalizatrabajo? resoperaparalizatrab,
    Operareiniciotrabajo? resoperareiniciartrab,
    Operafintrabajo? resoperafinalizartrab,
    String? message,
  }) =>
      HorasTecnicosState(
          isLoading: isLoading ?? this.isLoading,
          tecnicos: tecnicos ?? this.tecnicos,
          trabajos: trabajos ?? this.trabajos,
          motivos: motivos ?? this.motivos,
          respoperainitrabajo: respoperainitrabajo ?? this.respoperainitrabajo,
          resoperaparalizatrab:
              resoperaparalizatrab ?? this.resoperaparalizatrab,
          resoperareiniciartrab:
              resoperareiniciartrab ?? this.resoperareiniciartrab,
          resoperafinalizartrab:
              resoperafinalizartrab ?? this.resoperafinalizartrab,
          message: message ?? this.message);
}
