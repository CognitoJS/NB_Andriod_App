import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/UI/Products/festivalcollectionscreen.dart';
import 'package:naveenbotique/UI/Products/modestwearscreen.dart';
import 'package:naveenbotique/UI/Products/readytowearscreen.dart';
import 'package:naveenbotique/UI/Products/stictchscreen.dart';
import 'package:naveenbotique/UI/Products/summersalescreen.dart';
import 'package:naveenbotique/UI/Products/unstitchscreen.dart';
import 'package:naveenbotique/UI/Products/weddingwearscreen.dart';
import 'package:naveenbotique/UI/cartpage.dart';
import 'package:naveenbotique/UI/productdetails.dart';

import '../../AdminUI/AdminModels/ProductModel.dart';
import '../AdminUI/AdminLoginPage.dart';
import '../Constants/constants.dart';
import '../functions/screensfucntion.dart';
import 'Products/newarrivalscreen.dart';
import 'customerorderpage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _imageUrl = "";
  List<ProductModel> productmodel = [];
  List<ProductModel> productmodel1 = [];
  fetchRecords() async {
    var records =
        await FirebaseFirestore.instance.collection("New Arrivals").get();
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

  fetchRecordsfromSale() async {
    var records = await FirebaseFirestore.instance.collection("Sale").get();
    mapRecordsfromSale(records);
  }

  mapRecordsfromSale(QuerySnapshot<Map<String, dynamic>> records) {
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
      productmodel1 = _records;
    });
  }

  @override
  void initState() {
    fetchRecords();
    fetchRecordsfromSale();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: headerColor,
          title: RichText(
            text: TextSpan(
              text: 'Naveen ',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              children: <TextSpan>[
                TextSpan(
                  text: 'Boutique',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                      fontWeight: FontWeight.bold,
                      color: buttonColor),
                ),
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  color: buttonColor,
                  onPressed: () {
                    nextScreen(
                      context,
                      CartPage(),
                    );
                  },
                  icon: const Icon(CupertinoIcons.cart_fill),
                  style: const ButtonStyle(),
                ),
                IconButton(
                  color: buttonColor,
                  onPressed: () {
                    nextScreen(context, const Teams_screen());
                  },
                  icon: const Icon(Icons.fire_truck),
                  style: const ButtonStyle(),
                )
              ],
            )
          ]),
      drawer: Drawer(
        backgroundColor: headerColor,
        width: 200,
        child: Container(
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Image.asset("assets/Naveen Boutique new logo.png"),
                ),
              ),
              ListTile(
                title: const Center(
                  child: Text("Amdin Login"),
                ),
                onTap: () {
                  nextScreen(context, const AdminLoginScreen());
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Festival Collection"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const FestivalCollectionScreen(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("New Arrivals"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const NewArrival(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Modest Wear"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const ModestWear(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Ready to Wear"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const ReadytoWear(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Wedding Wear"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const WeddingWear(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Summer Sale"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const SummerSaleScreen(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Un Stitched"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const UnStitched(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("Stitched"),
                ),
                onTap: () {
                  nextScreen(
                    context,
                    const Stitched(),
                  );
                },
              ),
              ListTile(
                title: const Center(
                  child: Text("My Orders"),
                ),
                onTap: () {
                  nextScreen(context, const Teams_screen());
                },
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: Column(
            children: [
              // image slider
              Stack(
                children: [
                  InkWell(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              10 / MediaQuery.of(context).devicePixelRatio,
                          vertical:
                              20 / MediaQuery.of(context).devicePixelRatio),
                      child: CarouselSlider(
                        items: slider_images
                            .map(
                              (item) => Image.asset(
                                item['image_path'],
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            )
                            .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2,
                          scrollPhysics: const BouncingScrollPhysics(),
                          viewportFraction: 1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // new arrival display section
              SizedBox(
                height: 10 * MediaQuery.of(context).devicePixelRatio,
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    text: 'New  ',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Arrivals',
                        style: GoogleFonts.playfairDisplay(
                            fontSize:
                                7 * MediaQuery.of(context).devicePixelRatio,
                            fontWeight: FontWeight.bold,
                            color: buttonColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 1 * MediaQuery.of(context).devicePixelRatio,
                    vertical: 3 * MediaQuery.of(context).devicePixelRatio),
                child: Container(
                  height: 1 * MediaQuery.of(context).devicePixelRatio,
                  width: double.infinity,
                  color: headerColor,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120 * MediaQuery.of(context).devicePixelRatio,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productmodel.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).devicePixelRatio * 2,
                                vertical:
                                    MediaQuery.of(context).devicePixelRatio *
                                        2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: headerColor,
                                    blurRadius: 6.0,
                                    spreadRadius: 4.0,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                              ),
                              width:
                                  56 * MediaQuery.of(context).devicePixelRatio,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Image.network(
                                      productmodel[1].url,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    productmodel[index].name,
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Available Stock: ${productmodel[index].stock}",
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Rs.${productmodel[index].price}",
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        nextScreen(
                                            context,
                                            ProductDetails(
                                                productdetailmodel:
                                                    productmodel[index]));
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "Shop Now",
                                            style: GoogleFonts.playfairDisplay(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              //summersale display section
              SizedBox(
                height: 10 * MediaQuery.of(context).devicePixelRatio,
              ),
              Container(
                child: RichText(
                  text: TextSpan(
                    text: 'Summer  ',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Sale',
                        style: GoogleFonts.playfairDisplay(
                            fontSize:
                                7 * MediaQuery.of(context).devicePixelRatio,
                            fontWeight: FontWeight.bold,
                            color: buttonColor),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 1 * MediaQuery.of(context).devicePixelRatio,
                    vertical: 3 * MediaQuery.of(context).devicePixelRatio),
                child: Container(
                  height: 1 * MediaQuery.of(context).devicePixelRatio,
                  width: double.infinity,
                  color: headerColor,
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 120 * MediaQuery.of(context).devicePixelRatio,
                      color: Colors.white,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: productmodel1.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).devicePixelRatio * 2,
                                vertical:
                                    MediaQuery.of(context).devicePixelRatio *
                                        2),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: headerColor,
                                    blurRadius: 6.0,
                                    spreadRadius: 4.0,
                                    offset: Offset(0.0, 0.0),
                                  )
                                ],
                              ),
                              width:
                                  56 * MediaQuery.of(context).devicePixelRatio,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30),
                                      ),
                                    ),
                                    child: Image.network(
                                      productmodel1[index].url,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(
                                    productmodel1[index].name,
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Available Stock: ${productmodel1[index].stock}",
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Rs.${productmodel1[index].price}",
                                    style: GoogleFonts.playfairDisplay(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: GestureDetector(
                                      onTap: () {
                                        nextScreen(
                                            context,
                                            ProductDetails(
                                                productdetailmodel:
                                                    productmodel1[index]));
                                      },
                                      child: Container(
                                        height: 25,
                                        width: 110,
                                        decoration: BoxDecoration(
                                            color: buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Center(
                                          child: Text(
                                            "Shop Now",
                                            style: GoogleFonts.playfairDisplay(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
