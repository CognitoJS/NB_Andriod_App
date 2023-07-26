import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:naveenbotique/AdminUI/AdminAllProducts.dart';
import 'package:naveenbotique/AdminUI/AdminFunctions/AdminFunctions.dart';
import 'package:naveenbotique/AdminUI/AdminOrderPage.dart';
import 'package:naveenbotique/Constants/constants.dart';
import 'package:naveenbotique/Widgets/textfieldwidget.dart';

import '../Widgets/admintiles.dart';
import '../Widgets/buttonwidget.dart';
import '../functions/screensfucntion.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  late String price;
  late String stock;
  late int convertedprice = int.parse(price);
  late int convertedstock = int.parse(stock);
  String _imageUrl = "";

  String selectedFilename = "";
  String filepath = "";
  var file;
  final storage = FirebaseStorage.instance;
  String imageURL = "";
  bool filenameset = false;

  // to pick product image
  void pickPicture() async {
    file = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      selectedFilename = file.name;
      filepath = file.path;
      filenameset = true;
    });
  }

  // to upload picked picture in database
  void uploadFile() async {
    final storageRef = FirebaseStorage.instance.ref();
    final mountainsRef = storageRef
        .child("productpics")
        .child("/${productNameController.text.trim()}")
        .child("/${productNameController.text.trim()}");
    File file = File(filepath);
    mountainsRef
        .putFile(file)
        .whenComplete(() => getImageFromUrl())
        .whenComplete(() => updateUrl());
    try {
      await mountainsRef.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  // get image url from firebase
  getImageFromUrl() async {
    var ref = await FirebaseStorage.instance
        .ref("productpics")
        .child("/${productNameController.text.trim()}")
        .child("${productNameController.text.trim()}");
    String url = (await ref.getDownloadURL()).toString();
    print(url);
    setState(() {
      _imageUrl = url;
    });
  }

  //update imageurl in firestorre databse
  updateUrl() async {
    await FirebaseFirestore.instance
        .collection(productCategoryController.text.trim())
        .doc(
          productNameController.text.trim(),
        )
        .update(
      {"url": _imageUrl},
    );
  }

  clearTextFields() {
    productNameController.clear();
    productPriceController.clear();
    productCategoryController.clear();
    productStockController.clear();
    productColorController.clear();
    productDescriptionController.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: buttonColor,
        centerTitle: true,
        title: Text(
          "Admin Dashboard",
          style: GoogleFonts.playfairDisplay(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 / MediaQuery.of(context).devicePixelRatio,
                    vertical: 30 / MediaQuery.of(context).devicePixelRatio),
                child: Container(
                  decoration: BoxDecoration(color: headerColor),
                  width: double.infinity,
                  height: 100,
                  child: Center(
                    child: Text(
                      "Total Sales:",
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                height: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textfields(
                        text: "Product name",
                        obsecuretext: false,
                        controller: productNameController),
                    textfields(
                        inputtype: TextInputType.number,
                        onchnaged: (value) {
                          price = value;
                        },
                        text: "Product Price",
                        obsecuretext: false,
                        controller: productPriceController),
                    textfields(
                        text: "Product Color",
                        obsecuretext: false,
                        controller: productColorController),
                    textfields(
                        inputtype: TextInputType.number,
                        onchnaged: (value) {
                          stock = value;
                        },
                        text: "Product Stock",
                        obsecuretext: false,
                        controller: productStockController),
                    textfields(
                        text: "Product Categorie",
                        obsecuretext: false,
                        controller: productCategoryController),
                    textfields(
                        text: "Product Description",
                        obsecuretext: false,
                        controller: productDescriptionController),
                    Button(
                      text: 'Add Product',
                      ontap: () {
                        listProduct(
                            productNameController.text.trim(),
                            convertedprice,
                            productCategoryController.text.trim(),
                            convertedstock,
                            productColorController.text.trim(),
                            productDescriptionController.text.trim());
                        uploadFile();
                        updateUrl();
                        ScaffoldMessenger.of(context).showSnackBar(
                          alertmessage(
                              context, "", "Product Listed", buttonColor),
                        );
                        setState(() {
                          filenameset = false;
                        });
                        //clearTextFields();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40 / MediaQuery.of(context).devicePixelRatio,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AdminTiles(
                    text: 'Orders',
                    ontap: () {
                      nextScreen(context, const AdminOrderPage());
                    },
                  ),
                  AdminTiles(
                    text: "Products",
                    ontap: () {
                      nextScreen(
                        context,
                        const AdminAllProducts(),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
