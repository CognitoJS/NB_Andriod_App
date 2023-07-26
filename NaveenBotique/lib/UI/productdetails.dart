import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/AdminUI/AdminModels/ProductModel.dart';
import 'package:naveenbotique/AdminUI/AdminModels/extraimagemodel.dart';
import 'package:naveenbotique/Constants/constants.dart';
import 'package:naveenbotique/UI/sizeguidescreen.dart';
import 'package:naveenbotique/Widgets/buttonwidget.dart';
import 'package:naveenbotique/Widgets/extraimagescontainer.dart';
import 'package:naveenbotique/functions/increasedecreasefucntions.dart';
import 'package:naveenbotique/functions/screensfucntion.dart';

import '../functions/cartfunction.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.productdetailmodel});
  final ProductModel productdetailmodel;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  late String price;
  late String stock;
  bool _selectedsize = false;
  late int convertedprice = int.parse(price);
  late int convertedstock = int.parse(stock);
  String userid = FirebaseAuth.instance.currentUser!.uid;
  int quantity = 1;
  String pname = "";
  String size = "";
  bool xs = false;
  bool s = false;
  bool m = false;
  bool l = false;
  bool xl = false;

  String blue = "";
  String black = "";
  String purple = "";
  String red = "";
  String orange = "";

  Color SelectSize() {
    return _selectedsize ? buttonColor : buttonColorwithopacity;
  }

  void setSize() {
    setState(
      () {
        _selectedsize = true;
      },
    );
  }

// radio size buttons
  void setSizeXS() {
    setState(() {
      size = "XS";
      xs = true;
      s = false;
      m = false;
      l = false;
      xl = false;
    });
  }

  void setSizeS() {
    setState(() {
      size = "S";
      xs = false;
      s = true;
      m = false;
      l = false;
      xl = false;
    });
  }

  void setSizeM() {
    setState(() {
      size = "M";
      xs = false;
      s = false;
      m = true;
      l = false;
      xl = false;
    });
  }

  void setSizeL() {
    setState(() {
      size = "L";
      xs = false;
      s = false;
      m = false;
      l = true;
      xl = false;
    });
  }

  void setSizeXL() {
    setState(() {
      size = "XL";
      xs = false;
      s = false;
      m = false;
      l = false;
      xl = true;
    });
  }

  // radio colors buttons
  void setBlue() {
    setState(() {
      blue = "Blue";
    });
  }

  void setBlack() {
    setState(() {
      blue = "Black";
    });
  }

  void setPurple() {
    setState(() {
      purple = "Purple";
    });
  }

  void setRed() {
    setState(() {
      red = "Red";
    });
  }

  void setOrange() {
    setState(() {
      orange = "Orange";
    });
  }

  // imageselection for product
  String selectedimage = "";

  // fetching extra images from collecion
  List<ExtraImageModle> extraimagemodel = [];
  fetchExtraImages() async {
    var records = await FirebaseFirestore.instance
        .collection(widget.productdetailmodel.cateogrie)
        .doc(widget.productdetailmodel.name)
        .collection("imageURLs")
        .get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var _records = records.docs
        .map((item) => ExtraImageModle(id: item.id, url: item['url']))
        .toList();
    setState(() {
      extraimagemodel = _records;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchExtraImages();
    setState(() {
      pname = widget.productdetailmodel.name;
    });
    selectedimage = widget.productdetailmodel.url;
    print(pname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Home  /',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' ${widget.productdetailmodel.cateogrie}',
                      style: GoogleFonts.playfairDisplay(
                          fontSize: 7 * MediaQuery.of(context).devicePixelRatio,
                          fontWeight: FontWeight.bold,
                          color: buttonColor),
                    ),
                  ],
                ),
              ),
              // product image
              Center(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  height: 300,
                  width: 240,
                  child: Center(
                    child: Image.network(selectedimage),
                  ),
                ),
              ),

              SizedBox(
                height: 100,
                width: 250,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: extraimagemodel.length,
                  itemBuilder: (context, index) {
                    return ExtraImageContainer(
                        ontap: () {
                          setState(() {
                            selectedimage = extraimagemodel[index].url;
                          });
                        },
                        imageurl: extraimagemodel[index].url);
                  },
                ),
              ),

              // row for extra images
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              //     ExtraImageContainer(
              //       ontap: () {
              //         setState(() {
              //           selectedimage =
              //               "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F2.png?alt=media&token=61a42343-9fc3-4462-9742-c93543c7db95";
              //         });
              //       },
              //       imageurl:
              //           "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F2.png?alt=media&token=61a42343-9fc3-4462-9742-c93543c7db95",
              //     ),
              //     ExtraImageContainer(
              //       ontap: () {
              //         setState(() {
              //           selectedimage =
              //               "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F4.png?alt=media&token=0c414634-f942-44cc-afab-52f277b965eb";
              //         });
              //       },
              //       imageurl:
              //           "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F4.png?alt=media&token=0c414634-f942-44cc-afab-52f277b965eb",
              //     ),
              //     ExtraImageContainer(
              //       ontap: () {
              //         setState(() {
              //           selectedimage =
              //               "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F1.png?alt=media&token=7363994f-da57-4c37-b3e0-bdc480e04eca";
              //         });
              //       },
              //       imageurl:
              //           "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F1.png?alt=media&token=7363994f-da57-4c37-b3e0-bdc480e04eca",
              //     ),
              //     ExtraImageContainer(
              //       ontap: () {
              //         setState(() {
              //           selectedimage =
              //               "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F5.png?alt=media&token=b1db50c5-5091-4908-9408-35ba9ce65e73";
              //         });
              //       },
              //       imageurl:
              //           "https://firebasestorage.googleapis.com/v0/b/naveenbotique.appspot.com/o/images%2F5.png?alt=media&token=b1db50c5-5091-4908-9408-35ba9ce65e73",
              //     ),
              //   ],
              // ),

              // product detail container
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: 20 / MediaQuery.of(context).devicePixelRatio,
                    vertical: 10 / MediaQuery.of(context).devicePixelRatio),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey, // Change color of the shadow
                          blurRadius: 15.0,
                          spreadRadius: 1.0,
                          offset: Offset(0, 5.0))
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      detailrow(
                        text: "Product Name",
                        text2: widget.productdetailmodel.name,
                      ),
                      detailrow(
                        text: "Availability",
                        text2: "${widget.productdetailmodel.stock} in stock",
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).devicePixelRatio * 10,
                            vertical:
                                MediaQuery.of(context).devicePixelRatio * 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quantity",
                              style: txtstyle,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            quantity--;
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        CupertinoIcons.minus,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: buttonColor, width: 3),
                                      bottom: BorderSide(
                                          color: buttonColor, width: 3),
                                    ),
                                  ),
                                  child: Center(child: Text("${quantity}")),
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey)),
                                  child: Center(
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          quantity++;
                                        });
                                      },
                                      icon: Icon(CupertinoIcons.plus, size: 10),
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      //sizs show radio buttons
                      const rowalignleft(text: "Size"),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 10,
                          vertical: MediaQuery.of(context).devicePixelRatio * 2,
                        ),
                        child: Row(
                          children: [
                            RoundSizeButtons(
                                ontap: setSizeXS,
                                text: "XS",
                                color: xs
                                    ? Colors.lightGreen
                                    : Colors.grey.shade400),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setSizeS,
                                text: "S",
                                color: s
                                    ? Colors.lightGreen
                                    : Colors.grey.shade400),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setSizeM,
                                text: "M",
                                color: m
                                    ? Colors.lightGreen
                                    : Colors.grey.shade400),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setSizeL,
                                text: "L",
                                color: l
                                    ? Colors.lightGreen
                                    : Colors.grey.shade400),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setSizeXL,
                                text: "XL",
                                color: xl
                                    ? Colors.lightGreen
                                    : Colors.grey.shade400),
                            SizedBox(
                              width:
                                  8 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            SizeGuideButton(),
                          ],
                        ),
                      ),

                      //Colors radio button
                      const rowalignleft(text: "Colors"),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).devicePixelRatio * 10,
                          vertical: MediaQuery.of(context).devicePixelRatio * 2,
                        ),
                        child: Row(
                          children: [
                            RoundSizeButtons(
                                ontap: setBlue, text: "", color: Colors.blue),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setBlack, text: "", color: Colors.black),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setPurple,
                                text: "",
                                color: Colors.deepPurpleAccent),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setRed,
                                text: "",
                                color: Colors.redAccent),
                            SizedBox(
                              width:
                                  2 * MediaQuery.of(context).devicePixelRatio,
                            ),
                            RoundSizeButtons(
                                ontap: setOrange,
                                text: "",
                                color: Colors.orangeAccent),
                          ],
                        ),
                      ),
                      //addto cart button
                      Button(
                        text: "Add to Cart",
                        ontap: () {
                          addToCart(
                            userid,
                            (widget.productdetailmodel.name).toString(),
                            quantity,
                            size,
                            (widget.productdetailmodel.url).toString(),
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text('Product is added to Cart!',
                                  style: txtstyle),
                              content: Text(
                                'Check Your cart for placing order',
                                style: txtstyle,
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                          print(size);
                          decreseStock(widget.productdetailmodel.cateogrie,
                              widget.productdetailmodel.name, quantity);
                          addTotal(userid, widget.productdetailmodel.price,
                              quantity);
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SizeGuideButton extends StatelessWidget {
  const SizeGuideButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(context, const SizeGuideScreen());
      },
      child: Container(
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(10)),
        height: 40,
        width: 70,
        child: Center(
          child: Text(
            "Size Guide",
            style: GoogleFonts.playfairDisplay(
                fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class RoundSizeButtons extends StatelessWidget {
  RoundSizeButtons({required this.text, required this.color, this.ontap});
  final String text;
  final Color color;
  Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        height: 33,
        width: 33,
        decoration: BoxDecoration(color: color),
        child: Text(
          text,
          style: txtstyle,
        ),
      ),
    );
  }
}

class detailrow extends StatelessWidget {
  detailrow({super.key, this.text, this.text2});
  var text;
  var text2;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 10,
          vertical: MediaQuery.of(context).devicePixelRatio * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: txtstyle,
          ),
          Text(
            text2,
            style: txtstyle,
          ),
        ],
      ),
    );
  }
}

class rowalignleft extends StatelessWidget {
  const rowalignleft({
    super.key,
    required this.text,
    this.color,
  });
  final String text;
  final color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).devicePixelRatio * 10,
          vertical: MediaQuery.of(context).devicePixelRatio * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: GoogleFonts.playfairDisplay(fontSize: 15, color: color),
          ),
        ],
      ),
    );
  }
}
