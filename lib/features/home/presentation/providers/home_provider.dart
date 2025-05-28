import 'package:autonort/features/home/dominio/dominio.dart';
import 'package:autonort/features/home/presentation/providers/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final homeRepo = ref.watch(homeRepositoryProvider);
  return HomeNotifier(homeRepositories: homeRepo);
});

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepositories homeRepositories;
  HomeNotifier({required this.homeRepositories}) : super(HomeState());

  Future<void> tutorial({required String codempresa}) async {
    state = state.copyWith(isLoading: true, message: null);

    try {
      final home = await homeRepositories.tutorial(codempresa);
      state = state.copyWith(isLoading: false, home: home, message: null);
    } catch (e) {
      state = state.copyWith(
          isLoading: false, message: 'Error al cargar el tutorial: $e');
    }
  }
}

class HomeState {
  final bool isLoading;
  final Home? home;
  final String? message;

  HomeState({this.isLoading = false, this.home, this.message});

  HomeState copyWith({
    bool? isLoading,
    Home? home,
    String? message,
  }) =>
      HomeState(
        isLoading: isLoading ?? this.isLoading,
        home: home ?? this.home,
        message: message ?? this.message,
      );
}
