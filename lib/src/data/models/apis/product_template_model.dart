class ProductTemplateModel {
  int? id;
  String? description;
  String? name;
  double? price;
  dynamic calories;
  String? image;
  List<VariantValue>? variantValue;

  ProductTemplateModel(
      {this.id,
      this.description,
      this.name,
      this.price,
      this.image,
      this.calories,
      this.variantValue});

  ProductTemplateModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    name = json["name"];
    price = double.parse(json["price"].toString());
    calories = double.parse(json["calories"].toString());

    image = json["image"];
    variantValue = json["variant_value"] == null
        ? null
        : (json["variant_value"] as List)
            .map((e) => VariantValue.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["description"] = description;
    data["name"] = name;
    data["price"] = price;
    data["calories"] = calories;
    data["image"] = image;
    if (variantValue != null) {
      data["variant_value"] = variantValue?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class VariantValue {
  AttributeId? attributeId;
  List<ValueIds>? valueIds;

  VariantValue({this.attributeId, this.valueIds});

  VariantValue.fromJson(Map<String, dynamic> json) {
    attributeId = json["attribute_id"] == null
        ? null
        : AttributeId.fromJson(json["attribute_id"]);
    valueIds = json["value_ids"] == null
        ? null
        : (json["value_ids"] as List).map((e) => ValueIds.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attributeId != null) {
      data["attribute_id"] = attributeId?.toJson();
    }
    if (valueIds != null) {
      data["value_ids"] = valueIds?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class ValueIds {
  int? id;
  String? name;
  double? priceExtra;
  bool? htmlColor;

  ValueIds({this.id, this.name, this.priceExtra, this.htmlColor});

  ValueIds.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    priceExtra = json["price_extra"];
    htmlColor = json["html_color"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["price_extra"] = priceExtra;
    data["html_color"] = htmlColor;
    return data;
  }
}

class AttributeId {
  int? id;
  String? name;

  AttributeId({this.id, this.name});

  AttributeId.fromJson(Map<String, dynamic> json) {
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
