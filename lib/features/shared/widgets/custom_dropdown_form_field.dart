import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class CustomDropdownFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final List<String> items;
  final String? selectedItem;
  final Function(String?) onChanged;
  final IconData? prefixIcon;

  const CustomDropdownFormField(
      {super.key,
      this.hint,
      required this.label,
      required this.items,
      this.selectedItem,
      required this.onChanged,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
     final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.grey),
    );

    return DropdownButtonFormField2<String>(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon,color: Colors.grey,) : null,
       border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),

      ),
      
      isExpanded: true,
      value: selectedItem,
      isDense: true,
        iconStyleData: const IconStyleData(
         icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey,)
        ),
      dropdownStyleData: const DropdownStyleData(
        direction: DropdownDirection.textDirection
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item,style: const TextStyle(fontSize: 12, color: Colors.black),),)).toList(),
      onChanged: onChanged,      
      );
  }
}
