import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class SlideInfo {
  final String titulo;
  final String mensaje;
  final String urlanimacion;
  final Widget? contenidoPersonalizado;

  SlideInfo(this.titulo, this.mensaje, this.urlanimacion,
      [this.contenidoPersonalizado]);
}

final slides = <SlideInfo>[
  SlideInfo(
    'Bienvenido (a)',
    'En App de Autonort Trujillo S.A.C podras Optimizar y controlar cada proceso en tu área de trabajo. Con nuestra aplicacion podras gestionar revisiones, hacer seguimiento a operaciones en tiempo real y reducir la complejidad de los procesos. Facilitando tu trabajo para que puedas mejorar la eficiencia y ahorrar tiempo en cada tarea.',
    'assets/animations/tutodeeplearning1.json',
  ),
  SlideInfo(
      'Permisos necesarios.',
      'Para ofrecerte la mejor experiencia, nuestra app necesita los siguientes permisos:',
      'assets/animations/tutopermisos2.json',
      Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _PermisoItem(
              icono: Icons.camera_alt,
              titulo: 'Carmara y Almacenamiento: ',
              descripcion: 'Para capturar y guardar imágenes de revisiones'),
          SizedBox(
            height: 10,
          ),
          _PermisoItem(
              icono: Icons.notifications_active,
              titulo: 'Notificaciones: ',
              descripcion: 'Para enviar alertas de las operaciones realizadas')
        ],
      )),
  SlideInfo(
      'Optimiza tu Trabajo',
      'Gestiona revisiones, monitorea procesos y digitaliza cada operación fácilmente. Captura imágenes, lleva un control detallado y reduce tiempos en cada tarea ',
      'assets/animations/fotografo.json',
      Column(
        children: [
          SizedBox(
            height: 20,
          ),
          _PermisoItem(
              icono: Icons.edit_document,
              titulo: 'Gestion de revisiones',
              descripcion: ''),
          SizedBox(
            height: 2,
          ),
          _PermisoItem(
              icono: Icons.camera_alt,
              titulo: 'Captura de imagenes',
              descripcion: ''),
          SizedBox(
            height: 2,
          ),
          _PermisoItem(
              icono: Icons.hourglass_bottom,
              titulo: 'Seguimiento en tiempo real',
              descripcion: ''),
          SizedBox(
            height: 2,
          ),
          _PermisoItem(
              icono: Icons.insert_chart_outlined_outlined,
              titulo: 'Optimizacion de procesos',
              descripcion: '')
        ],
      )),
];

class _PermisoItem extends StatelessWidget {
  final IconData icono;
  final String titulo;
  final String descripcion;

  const _PermisoItem(
      {required this.icono, required this.titulo, required this.descripcion});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final estiloTitulo = textStyle.bodyLarge
        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black87);
    final estiloDescripcion =
        textStyle.bodyMedium?.copyWith(color: Colors.black54);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icono,
            color: Colors.redAccent.shade700,
            size: 28,
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: estiloTitulo,
              ),
              const SizedBox(height: 4),
              Text(
                descripcion,
                style: estiloDescripcion,
              )
            ],
          ))
        ],
      ),
    );
  }
}

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({super.key});

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  late final PageController pageviewController = PageController();
  bool finalalcanzado = false;

  @override
  void initState() {
    super.initState();
    pageviewController.addListener(() {
      final page = pageviewController.page ?? 0;
      if (!finalalcanzado && page >= (slides.length - 1.5)) {
        setState(() {
          finalalcanzado = true;
        });
      }
    });
  }

  @override
  void dispose() {
    pageviewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: pageviewController,
            physics: const BouncingScrollPhysics(),
            children: slides
                .map((slideData) => _Slide(
                      titulo: slideData.titulo,
                      mensaje: slideData.mensaje,
                      urlanimacion: slideData.urlanimacion,
                      contenidoPersonalizado: slideData.contenidoPersonalizado,
                    ))
                .toList(),
          ),
          Positioned(
              right: 20,
              top: 50,
              child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Salir'))),
          finalalcanzado
              ? Positioned(
                  bottom: 30,
                  right: 30,
                  child: FadeInRight(
                    from: 15,
                    delay: const Duration(seconds: 1),
                    child: FilledButton(
                      onPressed: () => context.push('/login'),
                      child: const Text('Comenzar'),
                    ),
                  ))
              : const SizedBox()
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final String titulo;
  final String mensaje;
  final String urlanimacion;
  final Widget? contenidoPersonalizado;

  const _Slide(
      {required this.titulo,
      required this.mensaje,
      required this.urlanimacion,
      this.contenidoPersonalizado});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    String formattedMensaje = mensaje.replaceAll('|', '\n');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset(urlanimacion,
                width: 300, height: 300, fit: BoxFit.fill),
            const SizedBox(
              height: 20,
            ),
            Text(
              titulo,
              style: textStyle.titleMedium,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              formattedMensaje,
              style: textStyle.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            //aqui mostramos contenido personalizado si existe
            if (contenidoPersonalizado != null) contenidoPersonalizado!,
          ],
        ),
      ),
    );
  }
}
