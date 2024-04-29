class FavoriteProductModel {
  int? id;
  int? partnerId;
  ProductId? productId;

  FavoriteProductModel({this.id, this.partnerId, this.productId});

  FavoriteProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    partnerId = json["partner_id"];
    productId = json["product_id"] == null
        ? null
        : ProductId.fromJson(json["product_id"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["partner_id"] = partnerId;
    if (productId != null) {
      data["product_id"] = productId?.toJson();
    }
    return data;
  }
}

class ProductId {
  int? id;
  String? description;
  String? name;
  double? calories;
  double? price;
  String? image;

  ProductId(
      {this.id,
      this.description,
      this.name,
      this.calories,
      this.price,
      this.image});

  ProductId.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    name = json["name"];
    calories = json["calories"];
    price = json["price"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["description"] = description;
    data["name"] = name;
    data["calories"] = calories;
    data["price"] = price;
    data["image"] = image;
    return data;
  }
}
