class ProductModel {
  int? id;
  String? description;
  String? name;
  double? price;
  String? image;
  List<dynamic>? productTemplateVariantValueIds;
  List<dynamic>? optionalProductIds;

  ProductModel(
      {this.id,
      this.description,
      this.name,
      this.price,
      this.image,
      this.productTemplateVariantValueIds,
      this.optionalProductIds});

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    name = json["name"];
    price = double.parse(json["price"].toString());
    image = json["image"];
    productTemplateVariantValueIds =
        json["product_template_variant_value_ids"] ?? [];
    optionalProductIds = json["optional_product_ids"] ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["description"] = description;
    data["name"] = name;
    data["price"] = price?.toDouble();
    data["image"] = image;
    if (productTemplateVariantValueIds != null) {
      data["product_template_variant_value_ids"] =
          productTemplateVariantValueIds;
    }
    if (optionalProductIds != null) {
      data["optional_product_ids"] = optionalProductIds;
    }
    return data;
  }
}
