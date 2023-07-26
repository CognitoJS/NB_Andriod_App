import 'package:flutter/material.dart';

class ExtraImageContainer extends StatelessWidget {
  ExtraImageContainer({
    required this.ontap,
    required this.imageurl,
    super.key,
  });
  Function()? ontap;
  String imageurl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: 50,
          child: Image.network(imageurl),
        ),
      ),
    );
  }
}
