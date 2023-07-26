import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Constants/constants.dart';

class textfields extends StatelessWidget {
  textfields(
      {required this.text,
      required this.obsecuretext,
      required this.controller,
      this.onchnaged,
      this.inputtype});
  final String text;
  final bool obsecuretext;
  void Function(String)? onchnaged;
  late TextInputType? inputtype;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 40,
        child: TextFormField(
          keyboardType: inputtype,
          onChanged: onchnaged,
          validator: (val) {
            if (val!.isEmpty) {
              return "Required";
            } else {
              null;
            }
          },
          obscureText: obsecuretext,
          style: GoogleFonts.lato(color: textColor),
          controller: controller,
          decoration: InputDecoration(
              label: Text(text,
                  style: GoogleFonts.playfairDisplaySc(color: textColor)),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: textFieldBorderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: textFieldBorderColor),
                borderRadius: BorderRadius.circular(10.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: textFieldBorderColor),
              ),
              fillColor: bgColor),
        ),
      ),
    );
  }
}
