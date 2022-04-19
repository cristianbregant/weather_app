import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static ThemeData light = ThemeData(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      primarySwatch: Colors.teal,
      backgroundColor: Colors.grey[100]);
  static ThemeData dark = ThemeData(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      backgroundColor: Colors.grey[900],
      brightness: Brightness.dark);
}
