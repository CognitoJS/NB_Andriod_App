import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class adminproductcategorietile extends StatelessWidget {
  adminproductcategorietile({required this.text,this.ontap});
  final String text;
  void Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 20 / MediaQuery.of(context).devicePixelRatio,
          horizontal: 20 / MediaQuery.of(context).devicePixelRatio),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          decoration: BoxDecoration(boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 10.0,
              spreadRadius: 2.0,
              offset: Offset(
                7.0, // Move to right 7.0 horizontally
                8.0, // Move to bottom 8.0 Vertically
              ),
            )
          ], color: Color(0xff83B735), borderRadius: BorderRadius.circular(20)),
          height: 60,
          width: double.infinity / MediaQuery.of(context).devicePixelRatio,
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
