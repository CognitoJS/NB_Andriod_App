class OrderModelCustomer {
  late String id;

  OrderModelCustomer({
    required this.id,
  });

  OrderModelCustomer.fromJson(Map<String, dynamic> json) {
    id = json["orderNumber"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["orderNumber"] = this.id;
    return data;
  }
}
