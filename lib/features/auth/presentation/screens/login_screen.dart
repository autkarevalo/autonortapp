import 'package:autonort/features/auth/presentation/providers/auth_provider.dart';
import 'package:autonort/features/auth/presentation/providers/providers.dart';
import 'package:autonort/features/shared/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    // final textStyles = Theme.of(context).textTheme;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/fondoinicioapp.png',
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height * 0.6,
            ),
          ),
          //Cuadrado/rectangulo semitransparente encima de la imagen

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: size.height * 0.4,
              color: const Color(0xB3e30613),
            ),
          ),
          //0x80FF0000
          Positioned(
            top: size.width * 0.25,
            left: 0,
            right: 0,
            child: Center(
                child: Image.asset(
              'assets/images/logoblaco.png',
              width: size.width * 0.5,
              fit: BoxFit.contain,
            )),
          ),

          Positioned(
              top: size.width * 0.6,
              left: 0,
              right: 0,
              child: Container(
                height: size.height * 0.6,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: scaffoldBackgroundColor,
                  borderRadius:
                      const BorderRadius.only(topLeft: Radius.circular(100)),
                ),
                child: const _LoginForm(),
              ))
        ],
      ),
    );
  }
}

class _LoginForm extends ConsumerWidget {
  const _LoginForm();

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loginForm = ref.watch(loginFormProvider);

    ref.listen(authProvider, (previous, next) {
      if (next.errorMessage.isEmpty) return;
      showSnackbar(context, next.errorMessage);
    });

    final textStyle = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          
          Text(
            'Bienvenido',
            style: textStyle.titleMedium,
          ),
          const SizedBox(
            height: 10.0,
          ),
          Text(
            'Para continuar debe Iniciar Sesión',
            style: textStyle.bodyMedium,
          ),
          const SizedBox(
            height: 20,
          ),
        
            
            CustomDropdownFormField(
                label: 'Seleccione Empresa',
                items: ['Autonort Trujillo S.A.C', 'Autonort Cajamarca S.A.C'],
                prefixIcon: Icons.business,
                onChanged: (value) {
                  print('Empresa seleccionada : $value');
                }),
          
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            label: 'Usuario Nisira',
            prefixIcon: Icons.person,
            keyboardType: TextInputType.text,
            onChanged: ref.read(loginFormProvider.notifier).onUsuarioChange,
            errorMessage: loginForm.isFormPosted
                ? loginForm.usuarionick.errorMessage
                : null,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomTextFormField(
            label: 'Contraseña',
            prefixIcon: Icons.lock,
            obscureText: true,
            onChanged: ref.read(loginFormProvider.notifier).onPasswordChanged,
            onFieldSubmitted: (_) =>
                ref.read(loginFormProvider.notifier).onFormSubmit(false),
            errorMessage:
                loginForm.isFormPosted ? loginForm.password.errorMessage : null,
          ),
          const SizedBox(height: 5),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () => context.push('/register'),
                  child: const Text('Registrate ')),
              TextButton(
                  onPressed: () => context.push('/Olvidastes'),
                  child: const Text('Olvidastes tu Clave ?'))
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: CustomFilledButton(
              text: 'Iniciar Sesión',
              buttonColor: const Color(0xffe30613),
              onPressed: loginForm.isPosting
                  ? null
                  : () =>
                      ref.read(loginFormProvider.notifier).onFormSubmit(false),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'o iniciar por',
            style: const TextStyle(fontSize: 16, color: Colors.black45),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          GestureDetector(
            onTap: () {
              print('Iniciar sesion con Gmail');
            },
            child: Image.asset(
              'assets/icon/gmail.png',
              height: 40,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
