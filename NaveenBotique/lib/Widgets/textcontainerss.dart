import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/constants.dart';

class textheadingcontainer extends StatelessWidget {
  const textheadingcontainer({
    super.key,
    required this.text,
    required this.fontsize,
  });
  final String text;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20 / MediaQuery.of(context).devicePixelRatio),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: GoogleFonts.playfairDisplaySc(
                color: buttonColor,
                fontWeight: FontWeight.bold,
                fontSize: fontsize),
          ),
        ],
      ),
    );
  }
}

class textcontainer extends StatelessWidget {
  const textcontainer({
    super.key,
    required this.text,
    required this.fontsize,
  });
  final String text;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 20 / MediaQuery.of(context).devicePixelRatio,
          vertical: 20 / MediaQuery.of(context).devicePixelRatio),
      child: Text(
        text,
        style: GoogleFonts.lato(color: bgColor, fontSize: fontsize),
      ),
    );
  }
}
