class ProductVariantsModel {
  int? id;
  String? name;
  String? description;
  double? price;
  String? image;

  ProductVariantsModel(
      {this.id, this.name, this.description, this.price, this.image});

  ProductVariantsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    description = json["description"];
    price = double.parse(json["price"].toString());
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["description"] = description;
    data["price"] = price;
    data["image"] = image;
    return data;
  }
}
