import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:naveenbotique/UI/homescreen.dart';

import '../Constants/constants.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
      Duration(seconds: 2),
      () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SpinKitThreeInOut(
          duration: Duration(seconds: 3),
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.red : buttonColor),
            );
          },
        ),
      ),
    );
  }
}
