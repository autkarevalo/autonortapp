import 'package:autonort/features/auth/dominio/dominio.dart';
import 'package:autonort/features/auth/infraestructura/infraestructura.dart';
import 'package:autonort/features/shared/services/key_value_storage_service.dart';
import 'package:autonort/features/shared/services/key_value_storage_service_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
      authRepositorio: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepositorio authRepositorio;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier(
      {required this.authRepositorio, required this.keyValueStorageService})
      : super(AuthState()) {
    checkAuthStatus();
  }
  //METODO LOGIN
  Future<void> loginUser(
      String codempresa, String esinvitado, String usuario, String pass) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user =
          await authRepositorio.login(codempresa, esinvitado, usuario, pass);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
    //final user = await authRepository.login(email, password);
    //state = state.copyWith(user: user,authStatus: AuthStatus.authenticated);
  }

  void checkAuthStatus() async {
  // ✅ se especifica el tipo <String> al obtener el token
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout();
    try {
      final user = await authRepositorio.checkAuthStatus(token);
      final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      if (user.exp != null && now >= user.exp!) {
        return logout('Sesion expirada');
      }
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(Usuario user) async {
   if (user.token != null && user.token is String) {
    await keyValueStorageService.setKeyValue<String>('token', user.token!);
  }

    state = state.copyWith(
        user: user, authStatus: AuthStatus.authenticated, errorMessage: '');
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
        authStatus: AuthStatus.notAuthenticated,
        user: null,
        errorMessage: errorMessage);
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final Usuario? user;
  final String errorMessage;

  AuthState(
      {this.authStatus = AuthStatus.checking,
      this.user,
      this.errorMessage = ''});

  AuthState copyWith({
    AuthStatus? authStatus,
    Usuario? user,
    String? errorMessage,
  }) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMessage: errorMessage ?? this.errorMessage);
}
