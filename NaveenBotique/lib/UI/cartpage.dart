import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/UI/paymentdetailscreen.dart';
import 'package:naveenbotique/Widgets/buttonwidget.dart';

import '../../Constants/constants.dart';
import '../AdminUI/AdminModels/CartModel.dart';
import '../Widgets/textfieldwidget.dart';
import '../functions/cartfunction.dart';
import '../functions/firebaseauthenticationfunction.dart';
import '../functions/increasedecreasefucntions.dart';
import '../functions/screensfucntion.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModel> cartmodel = [];
  String orderNumber = "";
  late String postalcode;
  late int convertedpostalcode = int.parse(postalcode);
  late String phonenumber;
  late int convertedphonenumber = int.parse(phonenumber);
  int customerTotal = 0;

  fetchRecords() async {
    var records = await FirebaseFirestore.instance
        .collection("Users")
        .doc(userid)
        .collection("Cart")
        .get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _records = records.docs
        .map(
          (item) => CartModel(
            id: item.id,
            name: item['name'],
            quantity: item['quantity'],
            url: item['url'],
            size: item['size'],
          ),
        )
        .toList();
    setState(
      () {
        cartmodel = _records;
      },
    );
  }

  //random numbers

  void randomNumbers() {
    Random random = new Random();
    int randomNumber = random.nextInt(10); // from 0 to 9 included
    print("Generated Random Number Between 0 to 9: $randomNumber");

    int randomNumber2 = random.nextInt(1000) + 1; // from 1 to 10 included
    print("Generated Random Number Between 1 to 10: $randomNumber2");
    String _ordernumber = "andk${randomNumber}ada${randomNumber2}";
    setState(() {
      orderNumber = _ordernumber;
    });
    print(orderNumber);
  }

  createOrder() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userid)
        .collection("Orders")
        .doc(orderNumber)
        .set({
      "orderNumber": orderNumber,
      "adress": adressController.text.trim(),
      "postalcode": convertedpostalcode,
      "phonenumber": convertedphonenumber,
    });
  }

  createOrderinAdmin() async {
    await FirebaseFirestore.instance
        .collection("Admin")
        .doc("sales")
        .collection("Orders")
        .doc(orderNumber)
        .set({
      "orderNumber": orderNumber,
      "adress": adressController.text.trim(),
      "postalcode": convertedpostalcode,
      "phonenumber": convertedphonenumber,
      "email": FirebaseAuth.instance.currentUser!.email
    });
  }

  void getTotal() async {
    var _adminDetails =
        await FirebaseFirestore.instance.collection("Users").doc(userid).get();
    Map<String, dynamic>? record = _adminDetails.data();
    var customertotal = record!["total"];
    setState(
      () {
        customerTotal = customertotal;
      },
    );
  }

  @override
  void initState() {
    fetchRecords();
    getTotal();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                      text: 'Cart',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                          fontWeight: FontWeight.bold,
                          color: buttonColor),
                    ),
                  ],
                ),
              ),
              Container(
                height: 400,
                child: ListView.builder(
                  itemCount: cartmodel.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 5,
                          vertical:
                              MediaQuery.of(context).devicePixelRatio * 5),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: headerColor1,
                        ),
                        height: 160,
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
                                height: 171,
                                width: 150,
                                child: Image.network(cartmodel[index].url),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cartmodel[index].name,
                                  style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Item Ordered: ${cartmodel[index].quantity}",
                                  style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Size: ${cartmodel[index].size}",
                                  style: GoogleFonts.playfairDisplay(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Total: ',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 10 * MediaQuery.of(context).devicePixelRatio,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: '$customerTotal',
                      style: GoogleFonts.playfairDisplay(
                          fontSize:
                              10 * MediaQuery.of(context).devicePixelRatio,
                          fontWeight: FontWeight.bold,
                          color: buttonColor),
                    ),
                  ],
                ),
              ),
              textfields(
                  text: "Adress",
                  obsecuretext: false,
                  controller: adressController),
              const SizedBox(
                height: 10,
              ),
              textfields(
                  onchnaged: (value) {
                    postalcode = value;
                  },
                  inputtype: TextInputType.number,
                  text: "Postal Code",
                  obsecuretext: false,
                  controller: postalcodeController),
              const SizedBox(
                height: 10,
              ),
              textfields(
                  onchnaged: (value) {
                    phonenumber = value;
                  },
                  inputtype: TextInputType.number,
                  text: "Phone Number",
                  obsecuretext: false,
                  controller: phoneNumController),
              const SizedBox(
                height: 10,
              ),
              Button(
                text: "Place Order",
                ontap: () {
                  randomNumbers();
                  createOrder();
                  createOrderinAdmin();
                  copyDocuments(userid, orderNumber);
                  copyDocumentstoAdmin(userid, orderNumber);
                  alertmessage(context, "Order is placed",
                      "your order number: ${orderNumber}", buttonColor);
                  addTotalinAdmin(customerTotal);
                  updateCustomerTotal();
                  nextScreen(context, const PaymentDetail());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
