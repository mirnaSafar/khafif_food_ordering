class PaymentModel {
  int? id;
  String? name;
  String? mobileCode;
  bool? active;
  String? image;

  PaymentModel({this.id, this.name, this.mobileCode, this.active, this.image});

  PaymentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    mobileCode = json["mobile_code"];
    active = json["active"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["mobile_code"] = mobileCode;
    data["active"] = active;
    data["image"] = image;
    return data;
  }
}
