import 'dart:convert';

ExtraImageModle productModelFromJson(String str) =>
    ExtraImageModle.fromJson(json.decode(str));

String productModelToJson(ExtraImageModle data) => json.encode(data.toJson());

class ExtraImageModle {
  String id;
  String url;

  ExtraImageModle({
    required this.id,
    required this.url,
  });

  factory ExtraImageModle.fromJson(Map<String, dynamic> json) =>
      ExtraImageModle(
        id: json["id"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
      };
}
