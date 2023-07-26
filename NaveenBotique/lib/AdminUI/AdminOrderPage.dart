import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:naveenbotique/AdminUI/AdminOrderInfoPage.dart';
import 'package:naveenbotique/Constants/constants.dart';

import '../AdminUI/AdminModels/OrderModel.dart';

class AdminOrderPage extends StatefulWidget {
  const AdminOrderPage({Key? key}) : super(key: key);
  @override
  State<AdminOrderPage> createState() => _AdminOrderPageState();
}

class _AdminOrderPageState extends State<AdminOrderPage> {
  TextEditingController teamnamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SingleChildScrollView(
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
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            Team team = Team.fromJson(snapshot.data!.docs[index]
                                .data()! as Map<String, dynamic>);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
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
                                              spreadRadius: 5,
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    team.id.toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 20),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    "Email Id: ${team.email}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    "Phone Number: ${team.phonenumber}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    "Address: ${team.adress}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Center(
                                                  child: Text(
                                                    "Postal Code: ${team.postalcode}",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminOrderInfoPage(
                                                          team: team)),
                                            );
                                          }),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  } else {
                    return Container(
                      child: Center(
                        child: Text("No details"),
                      ),
                    );
                  }
                },
              ),
            ),
// floating action button to add new team to the firebase// This trailing comma makes auto-formatting nicer for build methods.
          ],
        ),
      ),
    );
  }
}
