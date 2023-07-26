import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String id;
  String name;
  int price;
  int stock;
  String url;
  String color;
  String cateogrie;
  String description;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.url,
    required this.color,
    required this.cateogrie,
    required this.description,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        stock: json["stock"],
        url: json["url"],
        color: json["color"],
        cateogrie: json["cateogrie"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "stock": stock,
        "url": url,
        "color": color,
        "cateogrie": cateogrie,
        "description": description
      };
}
