import 'package:autonort/features/modules/menu/dominio/dominio.dart';
import 'package:autonort/features/modules/menu/presentation/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final menuProvider = StateNotifierProvider<MenuNotifier, MenuState>((ref) {
  final menuRepo = ref.watch(menuRepositoryProvider);
  return MenuNotifier(menuRepositorio: menuRepo);
});

class MenuNotifier extends StateNotifier<MenuState> {
  final MenuRepositorio menuRepositorio;
  MenuNotifier({required this.menuRepositorio}) : super(MenuState());

  Future<void> cargaMenu(
      {required String codempresa,
      required String idusuario,
      required String aplicativo}) async {
    state = state.copyWith(isLoading: true, message: null);

    try {
      final menus =
          await menuRepositorio.menugeneral(codempresa, idusuario, aplicativo);
      state = state.copyWith(isLoading: false, menus: menus, message: null);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        message: 'Error al cargar el menú: $e',
      );
    }
  }

  void clearMenus() {
    state = state.copyWith(menus: [], message: null);
  }

  void selectMenu(Menu? menu) {
    state = state.copyWith(selectedMenu: menu);
  }
}

class MenuState {
  final bool isLoading;
  final List<Menu> menus;
  final String? message;
  final Menu? selectedMenu;

  MenuState(
      {this.isLoading = false,
      this.menus = const [],
      this.message,
      this.selectedMenu});

  MenuState copyWith(
          {bool? isLoading,
          List<Menu>? menus,
          String? message,
          Menu? selectedMenu}) =>
      MenuState(
          isLoading: isLoading ?? this.isLoading,
          menus: menus ?? this.menus,
          message: message ?? this.message,
          selectedMenu: selectedMenu ?? this.selectedMenu);
}
