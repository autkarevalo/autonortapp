import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const colorsLista = [
  Colors.blue,
  Colors.teal,
  Colors.green,
  Colors.red,
  Colors.purple,
  Colors.deepPurple,
  Colors.green,
  Colors.pink,
  Colors.pinkAccent,
];

const scaffoldBackgroundColor = Color(0xFFF8F7F7);

class AppTheme {
  final int selectedColor;
  final bool isDarkmode;
  AppTheme({this.selectedColor = 0, this.isDarkmode = false})
      : assert(
            selectedColor >= 0, 'El color seleccionado debe ser mayor que 0'),
        assert(selectedColor < colorsLista.length,
            'El color seleccionado debe ser menor o igual que${colorsLista.length - 1}');

  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorsLista[selectedColor],
      brightness: isDarkmode ? Brightness.dark : Brightness.light,
      //Text
      textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall:
              GoogleFonts.montserratAlternates().copyWith(fontSize: 20)),
      //color del fondo
      scaffoldBackgroundColor: scaffoldBackgroundColor,

      //AppBar
      appBarTheme: AppBarTheme(
          color: scaffoldBackgroundColor,
          titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red)));

  AppTheme copyWith({int? selectedColor, bool? isDarkmode}) => AppTheme(
    selectedColor: selectedColor ?? this.selectedColor,
    isDarkmode: isDarkmode ?? this.isDarkmode
  );
}
