import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../AdminUI/AdminModels/OrderInfoModel.dart';
import '../AdminUI/AdminModels/OrderModel.dart';
import '../Constants/constants.dart';

class AdminOrderInfoPage extends StatefulWidget {
  final Team team;
  const AdminOrderInfoPage({Key? key, required this.team}) : super(key: key);

  @override
  State<AdminOrderInfoPage> createState() => _AdminOrderInfoPageState();
}

class _AdminOrderInfoPageState extends State<AdminOrderInfoPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // for real time we use stream builder
              Container(
                height: MediaQuery.of(context).size.height * 0.58,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Admin")
                      .doc("sales")
                      .collection("Orders")
                      .doc(widget.team.id)
                      .collection(widget.team.id)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              Today today = Today.fromJson(
                                  snapshot.data!.docs[index].data()!
                                      as Map<String, dynamic>);
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.015,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: buttonColorwithopacity,
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black,
                                                spreadRadius: 1,
                                                blurRadius: 5,
                                                offset: Offset(0,
                                                    1), // changes position of shadow
                                              ),
                                            ],
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: ListTile(
                                            focusColor: Colors.red,
                                            title: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    "Product name: ${today.name.toString()}",
                                                    style: GoogleFonts
                                                        .playfairDisplay(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    "size: ${today.size}",
                                                    style: GoogleFonts
                                                        .playfairDisplay(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    "quantity: ${today.quantity.toString()}",
                                                    style: GoogleFonts
                                                        .playfairDisplay(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.white),
                                                  ),
                                                )
                                              ],
                                            ),
                                            onTap: () {}),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
// floating action button to add new team to the firebase// This trailing comma makes auto-formatting nicer for build methods.
            ],
          ),
        ),
      ),
    ));
  }
}
