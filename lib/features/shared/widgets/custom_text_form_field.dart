import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final IconData? prefixIcon;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.obscureText = false,
      this.keyboardType,
      this.onChanged,
      this.validator,
      this.onFieldSubmitted,
      this.prefixIcon});

  @override
  Widget build(BuildContext context) {
    //final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    );

    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 18,color: Colors.black87),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: Colors.grey,)
                  : null,
                  labelText: label,
                  hintText: hint,
                  errorText: errorMessage,
                  enabledBorder: border,
                  focusedBorder: border.copyWith(
                    borderSide: const BorderSide(color: Colors.blue, width: 1.5)
                  ),
                  errorBorder: border.copyWith(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5)
                  ),
                  focusedErrorBorder: border.copyWith(
                    borderSide: const BorderSide(color: Colors.red, width: 1.5)
                  )
      ),
    );
  }
}
