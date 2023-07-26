class Today {
  String? name;
  int? quantity;
  String? size;
  String? url;
  Today({this.name, this.quantity, this.size, this.url});

  Today.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    quantity = json["quantity"];
    size = json["size"];
    url = json["url"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["name"] = this.name;
    data["quantity"] = this.quantity;
    data["userid"] = this.size;
    data["url"] = this.size;

    return data;
  }
}
