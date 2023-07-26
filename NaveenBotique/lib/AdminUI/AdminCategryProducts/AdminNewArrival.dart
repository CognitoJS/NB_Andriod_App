import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naveenbotique/AdminUI/AdminModels/ProductModel.dart';

import '../../functions/screensfucntion.dart';
import '../AdminProductDetails.dart';

class AdminNewArrival extends StatefulWidget {
  const AdminNewArrival({super.key});

  @override
  State<AdminNewArrival> createState() => _AdminNewArrivalState();
}

class _AdminNewArrivalState extends State<AdminNewArrival> {
  List<ProductModel> productmodel = [];
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

  @override
  void initState() {
    // TODO: implement initState
    fetchRecords();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: ListView.builder(
        itemCount: productmodel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  color: Color(0xffD9D9D9)),
              child: ListTile(
                onTap: () {
                  nextScreen(
                      context,
                      AdminProductDetails(
                        productdetailmodel: productmodel[index],
                      ));
                },
                title: Text(
                  productmodel[index].name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      fontSize: 20,
                      color: Colors.black),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Text(
                    "Available Stock: ${productmodel[index].stock}",
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
        },
      ),
    );
  }
}
