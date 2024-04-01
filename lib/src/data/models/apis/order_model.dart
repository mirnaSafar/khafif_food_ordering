class OrderModel {
  int? id;
  String? number;
  int? customerId;
  String? state;
  String? dateOrder;
  double? amount;

  OrderModel(
      {this.id,
      this.number,
      this.customerId,
      this.state,
      this.dateOrder,
      this.amount});

  OrderModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    number = json["number"];
    customerId = json["customer_id"];
    state = json["state"];
    dateOrder = json["date_order"];
    amount = json["amount"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["number"] = number;
    data["customer_id"] = customerId;
    data["state"] = state;
    data["date_order"] = dateOrder;
    data["amount"] = amount;
    return data;
  }
}
