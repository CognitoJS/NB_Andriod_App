import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naveenbotique/Constants/constants.dart';

addToCart(userid, productname, quantity, size, url) async {
  await FirebaseFirestore.instance
      .collection("Users")
      .doc(userid)
      .collection("Cart")
      .doc(productname)
      .set(
    {"name": productname, "quantity": quantity, "size": size, "url": url},
  );
}
// deletecart

deletcart() async {
  var collection = FirebaseFirestore.instance
      .collection('Users')
      .doc(userid)
      .collection("Cart");
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }
}
updateCustomerTotal(){
  var customertotal = FirebaseFirestore.instance
      .collection('Users')
      .doc(userid);
  customertotal.update({
    "total":0
  });

}

