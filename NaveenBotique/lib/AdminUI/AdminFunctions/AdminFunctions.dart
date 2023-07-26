import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naveenbotique/AdminUI/AdminModels/ProductModel.dart';

void listProduct(
    productNameController,
    productPriceController,
    productCategoryController,
    productStockController,
    productColorController,
    productDescriptionController) async {
  await FirebaseFirestore.instance
      .collection(productCategoryController)
      .doc(productNameController)
      .set(
    {
      "name": productNameController,
      "price": productPriceController,
      "cateogrie": productCategoryController,
      "stock": productStockController,
      "color": productColorController,
      "description": productDescriptionController,
      "url": ""
    },
  );
}

//fetching records function

void fetchProducts(collectionname) async {
  await FirebaseFirestore.instance.collection(collectionname).get();
}

//mapping of records
List<ProductModel> productmodel = [];
void mapRecord(QuerySnapshot<Map<String, dynamic>> record) {
  var records = record.docs
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
}

//update products
void AdminUpdateProduct(productid, convertedprice, convertedstock) async {
  await FirebaseFirestore.instance
      .collection("Bridal Wear")
      .doc(productid)
      .update(
    {"price": convertedprice, "stock": convertedstock},
  );
}
