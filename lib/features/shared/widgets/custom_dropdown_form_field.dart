import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?>? onChanged;
  final IconData? prefixIcon;

  const CustomDropdownFormField(
      {super.key,
      this.hint,
      required this.label,
      required this.items,
      this.selectedItem,
      this.onChanged,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    );
    // Nota: si selectedItem no está en items, es mejor pasar null para evitar asserts internos
    final String? safeValue =
        (selectedItem != null && items.contains(selectedItem))
            ? selectedItem
            : null;
    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.grey,
              )
            : null,
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      ),
      // 👇 MUY IMPORTANTE: esto muestra el placeholder cuando value == null
      hint: hint != null
          ? Text(hint!,
              style: const TextStyle(fontSize: 12, color: Colors.grey))
          : null,

      isExpanded: true,
      value: safeValue,
      isDense: true,
      iconStyleData: const IconStyleData(
          icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.grey,
      )),
      dropdownStyleData: DropdownStyleData(
          direction: DropdownDirection.textDirection,
          maxHeight: 200,
          padding: EdgeInsets.zero,
          elevation: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white)),
      items: items
          .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 12, color: Colors.black),
                ),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}
