class DeliveryOptionsModel {
  int? id;
  String? name;
  String? deliveryType;
  double? fixedPrice;
  bool? isPickup;
  ProductId? productId;
  List<dynamic>? branchs;

  DeliveryOptionsModel(
      {this.id,
      this.name,
      this.deliveryType,
      this.fixedPrice,
      this.isPickup,
      this.productId,
      this.branchs});

  DeliveryOptionsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    deliveryType = json["delivery_type"];
    fixedPrice = json["fixed_price"];
    isPickup = json["is_pickup"];
    productId = json["product_id"] == null
        ? null
        : ProductId.fromJson(json["product_id"]);
    branchs = json["branchs"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["delivery_type"] = deliveryType;
    data["fixed_price"] = fixedPrice;
    data["is_pickup"] = isPickup;
    if (productId != null) {
      data["product_id"] = productId?.toJson();
    }
    if (branchs != null) {
      data["branchs"] = branchs;
    }
    return data;
  }
}

class ProductId {
  int? id;
  String? name;

  ProductId({this.id, this.name});

  ProductId.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    return data;
  }
}
