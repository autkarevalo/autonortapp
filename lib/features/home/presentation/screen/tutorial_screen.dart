import 'package:animate_do/animate_do.dart';
import 'package:autonort/features/home/dominio/dominio.dart';
import 'package:autonort/features/home/presentation/providers/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

BoxFit getBoxFitBySize(Size size) {
  // Si el alto es muy pequeño o está en landscape -> evitar cortes
  if (size.height < 500 || size.width > size.height) {
    return BoxFit.contain;
  }
  // Si es pantalla amplia en portrait -> cubrir mejor
  return BoxFit.cover;
}

class TutorialScreen extends ConsumerStatefulWidget {
  const TutorialScreen({super.key});

  @override
  ConsumerState<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends ConsumerState<TutorialScreen> {
  /*AQUII ME QUEDE */
  late final PageController _pageController = PageController();
  bool finalalcanzado = false;

  @override
  void initState() {
    super.initState();
//cargar datos iniciales
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).tutorial(codempresa: '004');
    });

    _pageController.addListener(() {
      final page = _pageController.page ?? 0;
      final length = ref.read(homeProvider).home?.data?.length ?? 1;
      if (!finalalcanzado && page >= (length - 1.5)) {
        setState(() {
          finalalcanzado = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    final size = MediaQuery.of(context).size;

    if (state.isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.message != null) {
      return Scaffold(
        body: Center(
          child: Text(state.message!),
        ),
      );
    }

    final items = state.home?.data ?? [];
    if (items.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('No hay contenido disponible')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: items.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, index) {
              final item = items[index];
              return _Slide(item: item);
            },
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
  final HomeItem item;

  const _Slide({required this.item});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    final imageUrl = item.ulrimg ?? 'assets/images/noimg.jpg';
    final imageWidget = FadeIn(
      delay: const Duration(milliseconds: 700),
      child: ClipRRect(
        borderRadius: BorderRadiusGeometry.circular(20),
        child: imageUrl.startsWith('http')
            ? FadeInImage.assetNetwork(
                placeholder: 'assets/images/bottle-loader.gif',
                image: imageUrl,
                width: isLandscape ? size.width * 0.4 : size.width * 0.8,
                height: isLandscape ? size.height * 0.8 : size.height * 0.3,
                fit: getBoxFitBySize(size),
                fadeInDuration: const Duration(milliseconds: 200),
                fadeOutDuration: const Duration(milliseconds: 100),
              )
            : Image.asset(
                imageUrl,
                width: isLandscape ? size.width * 0.4 : size.width * 0.8,
                height: isLandscape ? size.height * 0.8 : size.height * 0.3,
                fit: getBoxFitBySize(size),
              ),
      ),
    );

    final contentWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.titulo ?? '',
          style: textStyle.titleMedium?.copyWith(fontSize: size.width * 0.05),
          textAlign: TextAlign.start,
        ),
        SizedBox(
          height: size.height * 0.02,
        ),
        Text(
          item.mensaje ?? '',
          style: textStyle.bodyLarge?.copyWith(fontSize: size.width * 0.04),
          textAlign: TextAlign.justify,
        ),
        if (_buildPermissions(item) != null) ...[
          SizedBox(
            height: size.height * 0.02,
          ),
          _buildPermissions(item)!,
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
                        Expanded(child: imageWidget),
                        SizedBox(
                          width: size.width * 0.05,
                        ),
                        Expanded(child: contentWidget),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        imageWidget,
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        contentWidget
                      ],
                    ))),
    );
  }

  Widget? _buildPermissions(HomeItem item) {
    final widgets = <Widget>[];
    void addPerm(int idx, String? titulo, String? desc, IconData icon) {
      if (titulo?.isNotEmpty == true) {
        widgets.add(_PermisoItem(
          icono: icon,
          titulo: titulo!,
          descripcion: desc ?? '',
        ));
        widgets.add(const SizedBox(height: 10));
      }
    }

    addPerm(1, item.subtitulo1, item.mensajeSubtitulo1, item.icon1);
    addPerm(2, item.subtitulo2, item.mensajeSubtitulo2, item.icon2);
    addPerm(3, item.subtitulo3, item.mensajeSubtitulo3, item.icon3);
    addPerm(4, item.subtitulo4, item.mensajeSubtitulo4, item.icon4);

    if (widgets.isEmpty) return null;
    return Column(children: widgets);
  }
}

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
              if (descripcion.isNotEmpty) ...[
                SizedBox(height: size.height * 0.005),
                Text(descripcion, style: estiloDescripcion),
              ],
            ],
          ))
        ],
      ),
    );
  }
}
