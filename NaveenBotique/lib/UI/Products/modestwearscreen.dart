import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/UI/productdetails.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

import '../../AdminUI/AdminModels/ProductModel.dart';
import '../../Constants/constants.dart';

class ModestWear extends StatefulWidget {
  const ModestWear({super.key});

  @override
  State<ModestWear> createState() => _ModestWearState();
}

class _ModestWearState extends State<ModestWear> {
  List<ProductModel> productmodel = [];
  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection("Modest Wear").get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _records = records.docs
        .map(
          (item) => ProductModel(
            id: item.id,
            name: item['name'],
            price: item['price'],
            stock: item['stock'],
            url: item['url'],
            color: item['color'],
            cateogrie: item['cateogrie'],
            description: item['description'],
          ),
        )
        .toList();
    setState(() {
      productmodel = _records;
    });
  }

  @override
  void initState() {
    fetchRecords();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            RichText(
              text: TextSpan(
                text: 'Home / ',
                style: GoogleFonts.playfairDisplay(
                    fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Modest Wear',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                        fontWeight: FontWeight.bold,
                        color: buttonColor),
                  ),
                ],
              ),
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: productmodel.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).devicePixelRatio * 5,
                      vertical: MediaQuery.of(context).devicePixelRatio * 5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: headerColor1,
                    ),
                    height: 171,
                    width: 330,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).devicePixelRatio *
                                      2.1),
                          child: SizedBox(
                            height: 161,
                            width: 150,
                            child: Image.network(productmodel[index].url),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              productmodel[index].name,
                              style: GoogleFonts.playfairDisplay(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Available Stock: ${productmodel[index].stock}",
                              style: GoogleFonts.playfairDisplay(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Rs.${productmodel[index].price}",
                              style: GoogleFonts.playfairDisplay(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: GestureDetector(
                                onTap: () {
                                  nextScreen(
                                      context,
                                      ProductDetails(
                                          productdetailmodel:
                                              productmodel[index]));
                                },
                                child: Container(
                                  height: 32,
                                  width: 127,
                                  decoration: BoxDecoration(
                                    color: buttonColor,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Shop Now",
                                      style: GoogleFonts.playfairDisplay(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
