import 'dart:convert';

CartModel productModelFromJson(String str) =>
    CartModel.fromJson(json.decode(str));

String productModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String id;
  String name;
  int quantity;
  String url;
  String size;

  CartModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.url,
    required this.size,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json["id"],
        name: json["name"],
        quantity: json["stock"],
        url: json["url"],
        size: json["color"],
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "stock": quantity, "url": url, "color": size};
}
