import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';

final loginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUser;
  //aqui va el registraruser

  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});

class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String, String, String) loginUserCallback;

  LoginFormNotifier({required this.loginUserCallback})
      : super(LoginFormState());

  onUsuarioChange(String value) {
    final nuevoUsuarionick = Usuarionick.dirty(value);

    state = state.copyWhith(
        usuarionick: nuevoUsuarionick,
        isValid: Formz.validate([nuevoUsuarionick, state.password]));
  }

  onPasswordChanged(String value) {
    final nuevoPassword = Password.dirty(value);

    state = state.copyWhith(
        password: nuevoPassword,
        isValid: Formz.validate([nuevoPassword, state.usuarionick]));
  }

  onFormSubmit(bool isRegistering) async {
    _touchEveryField();
    if (!state.isValid) return;
    //validar
    if (isRegistering) {
      //si es un registro nuevo llamamos al callback de registro
      //TODO : POR IMPLEMENTAR
    } else {
      state = state.copyWhith(isPosting: true);
      //si es un login llamamos al callback de login
      await loginUserCallback(
          '', '', state.usuarionick.value, state.password.value);
      state = state.copyWhith(isPosting: false);
    }
  }

  _touchEveryField() {
    final usuarionick = Usuarionick.dirty(state.usuarionick.value);
    final password = Password.dirty(state.password.value);

    state = state.copyWhith(
        isFormPosted: true,
        usuarionick: usuarionick,
        password: password,
        isValid: Formz.validate([usuarionick, password]));
  }
}

class LoginFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Usuarionick usuarionick;
  final Password password;
  //Numerodocumento
  //nombrecompleto

  LoginFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.usuarionick = const Usuarionick.pure(),
    this.password = const Password.pure(),
  });

  LoginFormState copyWhith(
          {bool? isPosting,
          bool? isFormPosted,
          bool? isValid,
          Usuarionick? usuarionick,
          Password? password}) =>
      LoginFormState(
          isPosting: isPosting ?? this.isPosting,
          isFormPosted: isFormPosted ?? this.isFormPosted,
          isValid: isValid ?? this.isValid,
          usuarionick: usuarionick ?? this.usuarionick,
          password: password ?? this.password);
  @override
  String toString() {
    return '''
      LoginFormState:
      isPosting:$isPosting
      isFormPosted:$isFormPosted
      isValid:$isValid
      usuarionick:$usuarionick
      password:$password
      ''';
  }
}
