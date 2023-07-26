import 'dart:convert';

ProductDeatilModel productModelFromJson(String str) =>
    ProductDeatilModel.fromJson(json.decode(str));

String productModelToJson(ProductDeatilModel data) => json.encode(data.toJson());

class ProductDeatilModel {
  String id;
  String name;
  String description;
  int price;
  int stock;

  ProductDeatilModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
  });

  factory ProductDeatilModel.fromJson(Map<String, dynamic> json) => ProductDeatilModel(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    price: json["price"],
    stock: json["stock"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "price": price,
    "stock": stock,
  };
}
