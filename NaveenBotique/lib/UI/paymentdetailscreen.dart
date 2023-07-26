import 'package:flutter/material.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

import '../functions/cartfunction.dart';

class PaymentDetail extends StatefulWidget {
  const PaymentDetail({super.key});

  @override
  State<PaymentDetail> createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  deletcart();
                  popupScreen(context);
                  popupScreen(context);
                },
                child: const Text("OK"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
