class ShortestPathModel {
  String? shortestCompany;
  int? shortestDistance;
  int? shortestDuration;
  String? shortestText;
  String? destinationAddresses;
  String? originAddresses;
  int? deliveryCompanyId;
  int? orderId;

  ShortestPathModel(
      {this.shortestCompany,
      this.shortestDistance,
      this.shortestDuration,
      this.shortestText,
      this.destinationAddresses,
      this.originAddresses,
      this.deliveryCompanyId,
      this.orderId});

  ShortestPathModel.fromJson(Map<String, dynamic> json) {
    shortestCompany = json["shortest_company"];
    shortestDistance = json["shortest_distance"];
    shortestDuration = json["shortest_duration"];
    shortestText = json["shortest_text"];
    destinationAddresses = json["destination_addresses"];
    originAddresses = json["origin_addresses"];
    deliveryCompanyId = json["delivery_company_id"];
    orderId = json["order_id"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["shortest_company"] = shortestCompany;
    data["shortest_distance"] = shortestDistance;
    data["shortest_duration"] = shortestDuration;
    data["shortest_text"] = shortestText;
    data["destination_addresses"] = destinationAddresses;
    data["origin_addresses"] = originAddresses;
    data["delivery_company_id"] = deliveryCompanyId;
    data["order_id"] = orderId;
    return data;
  }
}
