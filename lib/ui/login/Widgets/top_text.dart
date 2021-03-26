import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopText extends StatelessWidget {
  TopText({required String text}) : _text = text;
  final String _text;
  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: GoogleFonts.poppins(
          fontWeight: FontWeight.w800,
          fontSize: 27,
          color: const Color(0xFF3F4863)),
    );
  }
}
