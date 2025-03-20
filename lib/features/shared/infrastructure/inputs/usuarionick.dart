import 'package:formz/formz.dart';

// Define input validation errors
enum UsuarionickError { empty, invalid }

// Extend FormzInput and provide the input type and error type.
class Usuarionick extends FormzInput<String, UsuarionickError> {
  // Expresión regular para aceptar solo letras, incluyendo letras con tilde y ñ
  static final RegExp letrasRegExp = RegExp(
    r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$', // Solo letras con tilde y ñ
  );

  // Call super.pure to represent an unmodified form input.
  const Usuarionick.pure() : super.pure('');

  // Call super.dirty to represent a modified form input.
  const Usuarionick.dirty(super.value) : super.dirty();

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == UsuarionickError.empty) return 'El campo es requerido';
    if (displayError == UsuarionickError.invalid) {
      return 'Solo se permiten letras';
    }

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  UsuarionickError? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return UsuarionickError.empty;
    if (!letrasRegExp.hasMatch(value)) return UsuarionickError.invalid;

    return null;
  }
}
