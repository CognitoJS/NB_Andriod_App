import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/constants.dart';

class AdminTiles extends StatelessWidget {
  AdminTiles({required this.text, required this.ontap});
  String text;
  void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          width: 400 / MediaQuery.of(context).devicePixelRatio,
          height: 100,
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 10.0,
                spreadRadius: 2.0,
                offset: Offset(
                  7.0, // Move to right 7.0 horizontally
                  8.0, // Move to bottom 8.0 Vertically
                ),
              )
            ],
            color: headerColor,
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.playfairDisplay(fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
