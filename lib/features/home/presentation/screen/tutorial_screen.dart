import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

BoxFit getBoxFitBySize(Size size) {
  // Si el alto es muy pequeño o está en landscape -> evitar cortes
  if (size.height < 500 || size.width > size.height) {
    return BoxFit.contain;
  }
  // Si es pantalla amplia en portrait -> cubrir mejor
  return BoxFit.cover;
}

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
    'assets/images/inicio.JPG',
  ),
  SlideInfo(
      'Permisos necesarios.',
      'Para ofrecerte la mejor experiencia, nuestra app necesita los siguientes permisos:',
      'assets/images/permisos2.PNG',
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
      'assets/images/funciones.JPG',
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
    final size = MediaQuery.of(context).size;
    final estiloTitulo = textStyle.bodyLarge?.copyWith(
        fontWeight: FontWeight.bold,
        color: Colors.black87,
        fontSize: size.width * 0.04);
    final estiloDescripcion = textStyle.bodyMedium
        ?.copyWith(color: Colors.black54, fontSize: size.width * 0.035);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.width * 0.008),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icono,
            color: Colors.redAccent.shade700,
            size: size.width * 0.07,
          ),
          SizedBox(
            width: size.width * 0.03,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                titulo,
                style: estiloTitulo,
              ),
              if (descripcion.isNotEmpty) SizedBox(height: size.height * 0.005),
              if (descripcion.isNotEmpty)
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
    final size = MediaQuery.of(context).size;

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
              top: 20,
              child: TextButton(
                  onPressed: () => context.go('/login'),
                  child: const Text('Salir'))),
          if (finalalcanzado)
            Positioned(
              bottom: 30,
              right: 30,
              child: FadeInRight(
                from: 15,
                delay: const Duration(seconds: 1),
                child: SizedBox(
                  width: size.width * 0.4,
                  child: FilledButton(
                    onPressed: () => context.push('/login'),
                    child: const Text('Comenzar'),
                  ),
                ),
              ),
            )
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
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    String formattedMensaje = mensaje.replaceAll('|', '\n');

    final animationWidget = FadeIn(
      delay: const Duration(milliseconds: 700),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          urlanimacion,
          width: isLandscape ? size.width * 0.4 : size.width * 0.8,
          height: isLandscape ? size.height * 0.8 : size.height * 0.3,
          fit:getBoxFitBySize(size),
          ),
      )
      );
    /*Lottie.asset(urlanimacion,
        width: isLandscape ? size.width * 0.4 : size.width * 0.8,
        height: isLandscape ? size.height * 0.8 : size.height * 0.3,
        fit: BoxFit.contain);*/

    final contentWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          titulo,
          style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          formattedMensaje,
          style: textStyle.bodyLarge?.copyWith(fontSize: size.width * 0.04),
          textAlign: TextAlign.justify,
        ),
        if (contenidoPersonalizado != null) ...[
          SizedBox(
            height: size.height * 0.02,
          ),
          contenidoPersonalizado!,
        ]
      ],
    );

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Center(
          child: SingleChildScrollView(
              child: isLandscape
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: animationWidget),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Expanded(child: contentWidget),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        animationWidget,
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        contentWidget
                      ],
                    ))),
    );
  }
}
