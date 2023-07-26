import 'package:cloud_firestore/cloud_firestore.dart';

//collection=>doc
//product categorie => productname
void decreseStock(productcategorie, productname, quantity) async {
  final stock = await FirebaseFirestore.instance
      .collection(productcategorie)
      .doc(productname);
  stock.update({"stock": FieldValue.increment(-quantity)});
}

//Collection//doc//coleection//doc
//Users => userid => Cart =>total
void addTotal(userid, productprice, quantity) async {
  final total =
      await FirebaseFirestore.instance.collection("Users").doc(userid);
  total.update({"total": FieldValue.increment(quantity * productprice)});
}

void addTotalinAdmin(customerTotal) async {
  final total =
      await FirebaseFirestore.instance.collection("Admin").doc("sales");
  total.update(
    {
      "sales": FieldValue.increment(customerTotal),
    },
  );
}
