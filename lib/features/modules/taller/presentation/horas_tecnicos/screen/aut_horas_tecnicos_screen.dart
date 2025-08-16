import 'package:animate_do/animate_do.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/providers/provider.dart';
import 'package:autonort/features/modules/taller/presentation/horas_tecnicos/widgets/widgets.dart';
import 'package:autonort/features/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutHorasTecnicosScreen extends ConsumerStatefulWidget {
  const AutHorasTecnicosScreen({super.key});

  @override
  ConsumerState<AutHorasTecnicosScreen> createState() =>
      _AutHorasTecnicosScreenState();
}

class _AutHorasTecnicosScreenState
    extends ConsumerState<AutHorasTecnicosScreen> {
  final GlobalKey _infoCardKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();
  double _infoCardHeight = 220;
  bool _fabVisible = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          _fabVisible) {
        setState(() => _fabVisible = false);
      } else if (_scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          !_fabVisible) {
        setState(() => _fabVisible = true);
      }
    });
    Future.microtask(() async {
      final notifier = ref.read(horastecnicosProvider.notifier);
      await notifier.cargarinfotecnicos(
        codempresa: '004',
        idtecnico: '70222667',
      );

      final tecnico = ref.read(horastecnicosProvider).tecnicos.firstOrNull;
      await notifier.cargarlistatrabajostecnico(
          codempresa: '004', idtecnico: tecnico?.codigo ?? '');

      WidgetsBinding.instance.addPostFrameCallback((_) {
        final renderBox =
            _infoCardKey.currentContext?.findRenderObject() as RenderBox?;
        if (renderBox != null) {
          setState(() {
            _infoCardHeight = renderBox.size.height;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: AnimatedSlide(
        duration: const Duration(milliseconds: 300),
        offset: _fabVisible ? Offset.zero : const Offset(0, 2),
        child: AnimatedOpacity(
          opacity: _fabVisible ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: FloatingActionButton(
            onPressed: () async {
              final notifier = ref.read(horastecnicosProvider.notifier);
              await notifier.cargarinfotecnicos(
                  codempresa: '004', idtecnico: '70222667');

              final tecnico =
                  ref.read(horastecnicosProvider).tecnicos.firstOrNull;
              await notifier.cargarlistatrabajostecnico(
                  codempresa: '004', idtecnico: tecnico?.codigo ?? '');
            },
            backgroundColor: Colors.red,
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: AutScaffoldConDrawer(
        title: 'Horas Tecnicos',
        mostrarAppBar: false,
        mostrarBottomNavigation: false,
        child: _ContenidoHorasTenicos(
          infoCardKey: _infoCardKey,
          infoCardHeight: _infoCardHeight,
          scrollController: _scrollController,
        ),
      ),
    );
  }
}

class _ContenidoHorasTenicos extends ConsumerWidget {
  final GlobalKey infoCardKey;
  final double infoCardHeight;
  final ScrollController scrollController;
  const _ContenidoHorasTenicos(
      {required this.infoCardKey,
      required this.infoCardHeight,
      required this.scrollController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(horastecnicosProvider);
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: constraints.maxHeight,
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverPersistentHeader(
                pinned: false,
                delegate: _InfoTecnicoSliverHeader(
                  key: infoCardKey,
                  maxHeight: infoCardHeight,
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _HeaderTrabajosAsignados(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final trabajo = state.trabajos[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 6.0),
                      child: FadeInRight(
                        delay: Duration(milliseconds: 100 * index),
                        duration:const Duration(milliseconds: 400),
                        child:  TarjetaTrabajoWidget(trabajo: trabajo),
                      ) 
                     
                    );
                  },
                  childCount: state.trabajos.length,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoTecnicoSliverHeader extends SliverPersistentHeaderDelegate {
  final GlobalKey key;
  final double maxHeight;

  _InfoTecnicoSliverHeader({required this.key, required this.maxHeight});

  @override
  double get minExtent => 0;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final opacity =
        (1.0 - shrinkOffset / (maxExtent == 0 ? 1 : maxExtent)).clamp(0.0, 1.0);
    final offsetY = -shrinkOffset.clamp(0.0, maxExtent);

    return Transform.translate(
      offset: Offset(0, offsetY * 0.2),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        opacity: opacity,
        child: InfoTecnicoCard(key: key),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _InfoTecnicoSliverHeader oldDelegate) {
    return oldDelegate.maxHeight != maxHeight || oldDelegate.key != key;
  }
}

class _HeaderTrabajosAsignados extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 60;

  @override
  double get maxExtent => 60;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.center,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build,
              size: 18,
              color: Colors.deepPurple,
            ),
            SizedBox(
              width: 8,
            ),
            Text(
              'Trabajos Asignados',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
