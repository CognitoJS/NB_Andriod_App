import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:naveenbotique/AdminUI/AdminModels/ProductModel.dart';

import 'AdminFunctions/AdminFunctions.dart';

class AdminProductDetails extends StatefulWidget {
  const AdminProductDetails({super.key, required this.productdetailmodel});
  final ProductModel productdetailmodel;

  @override
  State<AdminProductDetails> createState() => _AdminProductDetailsState();
}

class _AdminProductDetailsState extends State<AdminProductDetails> {
  TextEditingController productNameUpdateController = TextEditingController();
  TextEditingController productPriceUpdateController = TextEditingController();
  TextEditingController productStockUpdateController = TextEditingController();
  late String price;
  late String stock;
  late int convertedprice = int.parse(price);
  late int convertedstock = int.parse(stock);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  height: 250,
                  width: 240,
                  child: Center(
                    child: Image.network(widget.productdetailmodel.url),
                  ),
                ),
              ),
              productdetailtile(
                  t1: "Product Name", t2: widget.productdetailmodel.name),
              productdetailtile(
                t1: "Product Price",
                t2: "Rs.${widget.productdetailmodel.price}",
              ),
              productdetailtile(
                t1: "Product Stock",
                t2: widget.productdetailmodel.stock,
              ),
              ProductUpdateFields(
                text: "ProductPrice",
                inputtype: TextInputType.number,
                controller: productPriceUpdateController,
                onchnaged: (value) {
                  price = value;
                },
              ),
              ProductUpdateFields(
                text: "ProductStock",
                inputtype: TextInputType.number,
                controller: productStockUpdateController,
                onchnaged: (value) {
                  stock = value;
                },
              ),
              AdminUpdateButton(
                ontap: () {
                  AdminUpdateProduct(
                    widget.productdetailmodel.id,
                    convertedprice,
                    convertedstock,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      duration: Duration(seconds: 3),
                      content: Container(
                        height: 80,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  20 / MediaQuery.of(context).devicePixelRatio),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("",
                                  style: GoogleFonts.playfairDisplay(
                                      color: Colors.white, fontSize: 15)),
                              SizedBox(
                                height: 20 /
                                    MediaQuery.of(context).devicePixelRatio,
                              ),
                              Text("Updated",
                                  style: GoogleFonts.playfairDisplay(
                                      color: Colors.white, fontSize: 15))
                            ],
                          ),
                        ),
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AdminUpdateButton extends StatelessWidget {
  const AdminUpdateButton({
    super.key,
    required this.ontap,
  });
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Color(0xff83B735),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              "Update",
              style: GoogleFonts.playfairDisplay(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductUpdateFields extends StatelessWidget {
  ProductUpdateFields(
      {required this.text,
      this.onchnaged,
      required this.inputtype,
      required this.controller});
  String text;
  void Function(String)? onchnaged;
  late TextInputType? inputtype;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: TextFormField(
        controller: controller,
        keyboardType: inputtype,
        onChanged: onchnaged,
        validator: (val) {
          if (val!.isEmpty) {
            return "Required";
          } else {
            null;
          }
        },
        style: GoogleFonts.lato(),
        decoration: InputDecoration(
          label: Text(text,
              style:
                  GoogleFonts.playfairDisplaySc(fontWeight: FontWeight.bold)),
          filled: true,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(),
          ),
          fillColor: Color(0xffffffff),
        ),
      ),
    );
  }
}

class productdetailtile extends StatelessWidget {
  productdetailtile({
    required this.t1,
    required this.t2,
  });

  var t2;
  String t1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              20,
            ),
            color: const Color(0xffD9D9D9)),
        child: ListTile(
          title: Text(
            t1,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 20,
                color: Colors.black),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              "$t2",
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
