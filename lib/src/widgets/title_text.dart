import 'package:flutter/material.dart';
import 'package:flutter_ecommerce_apps/src/themes/light_color.dart';
import 'package:google_fonts/google_fonts.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const TitleText({
    Key? key, // Nullable key for null safety
    required this.text, // Make text required (it shouldn't be nullable)
    this.fontSize = 18,
    this.color = LightColor.titleTextColor,
    this.fontWeight = FontWeight.w800,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.mulish(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
