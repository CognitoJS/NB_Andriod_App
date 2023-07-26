import 'package:flutter/material.dart';
import 'package:naveenbotique/Widgets/buttonwidget.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

class SizeGuideScreen extends StatefulWidget {
  const SizeGuideScreen({super.key});

  @override
  State<SizeGuideScreen> createState() => _SizeGuideScreenState();
}

class _SizeGuideScreenState extends State<SizeGuideScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/size guide.PNG"),
            const SizedBox(height: 5,),
            Button(
                text: "Back to Product",
                ontap: () {
                  popupScreen(context);
                })
          ],
        ),
      ),
    );
  }
}
