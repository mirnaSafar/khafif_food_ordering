class UserPointsModel {
  int? id;
  String? name;
  int? customerId;
  String? code;
  double? point;

  UserPointsModel({this.id, this.name, this.customerId, this.code, this.point});

  UserPointsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    customerId = json["customer_id"];
    code = json["code"];
    point = json["point"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["customer_id"] = customerId;
    data["code"] = code;
    data["point"] = point;
    return data;
  }
}
