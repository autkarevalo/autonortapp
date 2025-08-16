import 'package:autonort/config/config.dart';
import 'package:autonort/features/modules/menu/dominio/dominio.dart';
import 'package:autonort/features/modules/menu/presentation/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutMenuLateralWidget extends ConsumerWidget {
  final List<Menu> menus;
  final void Function(String ruta) onTap;
  // ✅ Nuevo: datos del usuario autenticado
  final String fullName;
  final String email;
  final String? photoUrl;
  final Menu? selectedMenu;

  const AutMenuLateralWidget(
      {super.key,
      required this.menus,
      required this.onTap,
      required this.fullName,
      required this.email,
      required this.photoUrl,
      required this.selectedMenu});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //Encabezado opcional
          _buildDrawerHeader(
            fullName: fullName,
            email: email,
            photoUrl: photoUrl,
          ),

          ...menus.map((menu) => _buildMenuItem(menu,ref)),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader({
    required String fullName,
    required String email,
    String? photoUrl,
  }) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        child: Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [
                  Color(0xFFE53935), // rojo fuerte
                  Color(0xFFD32F2F), // rojo oscuro
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(179, 0, 0, 0)
                          .withAlpha((0.70 * 255).toInt()),
                      offset: const Offset(0, 4),
                      blurRadius: 8)
                ]),
            //padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color.fromARGB(179, 0, 0, 0)
                            .withAlpha((0.70 * 255).toInt()),
                        offset: const Offset(0, 4),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: CircleAvatar(
                    radius: 40,
                    backgroundImage: (photoUrl != null && photoUrl.isNotEmpty)
                        ? NetworkImage(photoUrl)
                        : const AssetImage('assets/images/avatar.png')
                            as ImageProvider,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  fullName,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  email,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                )
              ],
            )));
  }

  Widget _buildMenuItem(Menu menu, WidgetRef ref) {
    final selectedMenu = ref.watch(menuProvider).selectedMenu;
    if (menu.item != null && menu.item!.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Material(
          color: scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          child: Theme(
            data: ThemeData().copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(horizontal: 14),
              leading: Icon(menu.iconData, color: Colors.grey[700]),
              title: Text(
                menu.opcion,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: menu.item!.map((subMenu) {
                if (subMenu.subItem != null && subMenu.subItem!.isNotEmpty) {
                  return Theme(
                    data:
                        ThemeData().copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      backgroundColor: const Color(0xFFF5F5F5),
                      leading: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(left: 10),
                            width: 2,
                            height: 32,
                            color: Colors.grey.shade300,
                          ),
                        ],
                      ),
                      title: Row(
                        children: [
                          Icon(subMenu.iconData, color: Colors.grey[700]),
                          const SizedBox(width: 8),
                          Expanded(child: Text(subMenu.opcion))
                        ],
                      ),
                      children: subMenu.subItem!
                          .map((subsub) => Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      width: 2,
                                      height: 40,
                                      color: Colors.grey.shade300,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(child: _buildMenuTitle(subsub,selectedMenu)),
                                  ],
                                ),
                              ))
                          .toList(),
                    ),
                  );
                } else {
                  return _buildMenuTitle(subMenu,selectedMenu);
                }
              }).toList(),
            ),
          ),
        ),
      );
    } else {
      return _buildMenuTitle(menu,selectedMenu);
    }
  }

  Widget _buildMenuTitle(Menu item,Menu? selectedMenu) {
    final bool isSelected = selectedMenu?.idmenu == item.idmenu;
print('[WIDGET] Dibujando ${item.opcion}, seleccionado: $isSelected');
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      child: InkWell(
        onTap: () => onTap(item.ruta ?? ''),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color.fromRGBO(229, 57, 53, 0.1)
                : scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(item.iconData, color: Colors.grey[700], size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  item.opcion,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? Colors.red : null,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
