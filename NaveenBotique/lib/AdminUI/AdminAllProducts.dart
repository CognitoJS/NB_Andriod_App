import 'package:flutter/material.dart';
import 'package:naveenbotique/AdminUI/AdminCategryProducts/AdminNewArrival.dart';
import 'package:naveenbotique/AdminUI/AdminCategryProducts/AdminSale.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

import '../Widgets/adminproductcategorietile.dart';

class AdminAllProducts extends StatefulWidget {
  const AdminAllProducts({super.key});

  @override
  State<AdminAllProducts> createState() => _AdminAllProductsState();
}

class _AdminAllProductsState extends State<AdminAllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              adminproductcategorietile(
                ontap: () {
                  nextScreen(context, const AdminNewArrival());
                },
                text: 'New Arrivals',
              ),
              adminproductcategorietile(
                ontap: () {
                  nextScreen(context, const AdminSale());
                },
                text: 'Sale ',
              ),
              adminproductcategorietile(
                text: 'Festival Collection',
              ),
              adminproductcategorietile(
                text: 'Unstictched Fabrics',
              ),
              adminproductcategorietile(
                text: 'Wedding Wears',
              ),
              adminproductcategorietile(
                text: 'Modest Wears',
              ),
              adminproductcategorietile(
                text: 'Party Wear',
              ),
              adminproductcategorietile(
                text: 'Celebrity Wear',
              )
            ],
          ),
        ),
      ),
    );
  }
}
