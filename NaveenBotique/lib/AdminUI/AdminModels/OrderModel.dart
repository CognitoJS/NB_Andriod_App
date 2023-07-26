class Team {
  late String id;
  late String? adress;
  late String? email;
  late int? phonenumber;
  late int? postalcode;

  Team({
    required this.id,
    this.adress,
    this.email,
    this.phonenumber,
    this.postalcode,
  });

  Team.fromJson(Map<String, dynamic> json) {
    id = json["orderNumber"];
    adress = json["adress"];
    email = json["email"];
    phonenumber = json["phonenumber"];
    postalcode = json["postalcode"];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["orderNumber"] = this.id;
    data["adress"] = this.adress;
    data["email"] = this.email;
    data["phonenumber"] = this.phonenumber;
    data["postalcode"] = this.postalcode;

    return data;
  }
}
