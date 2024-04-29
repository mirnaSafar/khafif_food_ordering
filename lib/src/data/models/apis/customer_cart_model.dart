class CustomerCartModel {
  int? id;
  String? number;
  int? customerId;
  String? state;
  int? companyId;
  String? deliveryOrderId;
  String? deliveryStatus;
  String? dateOrder;
  String? pickUpDatetime;
  List<Line>? line;
  double? amountUntaxed;
  double? amountTax;
  double? amountUndiscounted;
  double? amountTotal;
  TaxTotals? taxTotals;

  CustomerCartModel(
      {this.id,
      this.number,
      this.customerId,
      this.state,
      this.companyId,
      this.deliveryOrderId,
      this.deliveryStatus,
      this.dateOrder,
      this.pickUpDatetime,
      this.line,
      this.amountUntaxed,
      this.amountTax,
      this.amountUndiscounted,
      this.amountTotal,
      this.taxTotals});

  CustomerCartModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    number = json["number"];
    customerId = json["customer_id"];
    state = json["state"];
    companyId = json["company_id"];
    deliveryOrderId = json["delivery_order_id"];
    deliveryStatus = json["delivery_status"];
    dateOrder = json["date_order"];
    pickUpDatetime = json["pickUp_datetime"];
    line = json["line"] == null
        ? null
        : (json["line"] as List).map((e) => Line.fromJson(e)).toList();
    amountUntaxed = json["amount_untaxed"];
    amountTax = json["amount_tax"];
    amountUndiscounted = json["amount_undiscounted"];
    amountTotal = json["amount_total"];
    taxTotals = json["tax_totals"] == null
        ? null
        : TaxTotals.fromJson(json["tax_totals"]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["number"] = number;
    data["customer_id"] = customerId;
    data["state"] = state;
    data["company_id"] = companyId;
    data["delivery_order_id"] = deliveryOrderId;
    data["delivery_status"] = deliveryStatus;
    data["date_order"] = dateOrder;
    data["pickUp_datetime"] = pickUpDatetime;
    if (line != null) {
      data["line"] = line?.map((e) => e.toJson()).toList();
    }
    data["amount_untaxed"] = amountUntaxed;
    data["amount_tax"] = amountTax;
    data["amount_undiscounted"] = amountUndiscounted;
    data["amount_total"] = amountTotal;
    if (taxTotals != null) {
      data["tax_totals"] = taxTotals?.toJson();
    }
    return data;
  }
}

class TaxTotals {
  double? amountUntaxed;
  double? amountTotal;
  String? formattedAmountTotal;
  String? formattedAmountUntaxed;
  GroupsBySubtotal? groupsBySubtotal;
  List<Subtotals>? subtotals;
  List<String>? subtotalsOrder;
  bool? displayTaxBase;

  TaxTotals(
      {this.amountUntaxed,
      this.amountTotal,
      this.formattedAmountTotal,
      this.formattedAmountUntaxed,
      this.groupsBySubtotal,
      this.subtotals,
      this.subtotalsOrder,
      this.displayTaxBase});

  TaxTotals.fromJson(Map<String, dynamic> json) {
    amountUntaxed = json["amount_untaxed"];
    amountTotal = json["amount_total"];
    formattedAmountTotal = json["formatted_amount_total"];
    formattedAmountUntaxed = json["formatted_amount_untaxed"];
    groupsBySubtotal = json["groups_by_subtotal"] == null
        ? null
        : GroupsBySubtotal.fromJson(json["groups_by_subtotal"]);
    subtotals = json["subtotals"] == null
        ? null
        : (json["subtotals"] as List)
            .map((e) => Subtotals.fromJson(e))
            .toList();
    subtotalsOrder = json["subtotals_order"] == null
        ? null
        : List<String>.from(json["subtotals_order"]);
    displayTaxBase = json["display_tax_base"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["amount_untaxed"] = amountUntaxed;
    data["amount_total"] = amountTotal;
    data["formatted_amount_total"] = formattedAmountTotal;
    data["formatted_amount_untaxed"] = formattedAmountUntaxed;
    if (groupsBySubtotal != null) {
      data["groups_by_subtotal"] = groupsBySubtotal?.toJson();
    }
    if (subtotals != null) {
      data["subtotals"] = subtotals?.map((e) => e.toJson()).toList();
    }
    if (subtotalsOrder != null) {
      data["subtotals_order"] = subtotalsOrder;
    }
    data["display_tax_base"] = displayTaxBase;
    return data;
  }
}

class Subtotals {
  String? name;
  double? amount;
  String? formattedAmount;

  Subtotals({this.name, this.amount, this.formattedAmount});

  Subtotals.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    amount = json["amount"];
    formattedAmount = json["formatted_amount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["amount"] = amount;
    data["formatted_amount"] = formattedAmount;
    return data;
  }
}

class GroupsBySubtotal {
  List<UntaxedAmount>? untaxedAmount;

  GroupsBySubtotal({this.untaxedAmount});

  GroupsBySubtotal.fromJson(Map<String, dynamic> json) {
    untaxedAmount = json["Untaxed Amount"] == null
        ? null
        : (json["Untaxed Amount"] as List)
            .map((e) => UntaxedAmount.fromJson(e))
            .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (untaxedAmount != null) {
      data["Untaxed Amount"] = untaxedAmount?.map((e) => e.toJson()).toList();
    }
    return data;
  }
}

class UntaxedAmount {
  int? groupKey;
  int? taxGroupId;
  String? taxGroupName;
  double? taxGroupAmount;
  double? taxGroupBaseAmount;
  String? formattedTaxGroupAmount;
  String? formattedTaxGroupBaseAmount;

  UntaxedAmount(
      {this.groupKey,
      this.taxGroupId,
      this.taxGroupName,
      this.taxGroupAmount,
      this.taxGroupBaseAmount,
      this.formattedTaxGroupAmount,
      this.formattedTaxGroupBaseAmount});

  UntaxedAmount.fromJson(Map<String, dynamic> json) {
    groupKey = json["group_key"];
    taxGroupId = json["tax_group_id"];
    taxGroupName = json["tax_group_name"];
    taxGroupAmount = json["tax_group_amount"];
    taxGroupBaseAmount = json["tax_group_base_amount"];
    formattedTaxGroupAmount = json["formatted_tax_group_amount"];
    formattedTaxGroupBaseAmount = json["formatted_tax_group_base_amount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["group_key"] = groupKey;
    data["tax_group_id"] = taxGroupId;
    data["tax_group_name"] = taxGroupName;
    data["tax_group_amount"] = taxGroupAmount;
    data["tax_group_base_amount"] = taxGroupBaseAmount;
    data["formatted_tax_group_amount"] = formattedTaxGroupAmount;
    data["formatted_tax_group_base_amount"] = formattedTaxGroupBaseAmount;
    return data;
  }
}

class Line {
  int? lineId;
  int? productTemplateId;
  ProductId? productId;
  double? productUomQty;
  double? priceUnit;
  List<String>? taxId;
  double? discount;
  double? priceSubtotal;
  double? priceTotal;

  Line(
      {this.lineId,
      this.productTemplateId,
      this.productId,
      this.productUomQty,
      this.priceUnit,
      this.taxId,
      this.discount,
      this.priceSubtotal,
      this.priceTotal});

  Line.fromJson(Map<String, dynamic> json) {
    lineId = json["line_id"];
    productTemplateId = json["product_template_id"];
    productId = json["product_id"] == null
        ? null
        : ProductId.fromJson(json["product_id"]);
    productUomQty = json["product_uom_qty"];
    priceUnit = json["price_unit"];
    taxId = json["tax_id"] == null ? null : List<String>.from(json["tax_id"]);
    discount = json["discount"];
    priceSubtotal = json["price_subtotal"];
    priceTotal = json["price_total"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["line_id"] = lineId;
    data["product_template_id"] = productTemplateId;
    if (productId != null) {
      data["product_id"] = productId?.toJson();
    }
    data["product_uom_qty"] = productUomQty;
    data["price_unit"] = priceUnit;
    if (taxId != null) {
      data["tax_id"] = taxId;
    }
    data["discount"] = discount;
    data["price_subtotal"] = priceSubtotal;
    data["price_total"] = priceTotal;
    return data;
  }
}

class ProductId {
  int? id;
  String? description;
  String? name;
  double? price;
  String? image;

  ProductId({this.id, this.description, this.name, this.price, this.image});

  ProductId.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    description = json["description"];
    name = json["name"];
    price = json["price"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["description"] = description;
    data["name"] = name;
    data["price"] = price;
    data["image"] = image;
    return data;
  }
}
