class AddressModel {
  int? id;
  String? name;
  String? email;
  String? street;
  String? street2;
  String? zip;
  String? city;
  String? mobile;
  double? latitude;
  double? longitude;

  AddressModel(
      {this.id,
      this.name,
      this.email,
      this.street,
      this.street2,
      this.zip,
      this.city,
      this.mobile,
      this.latitude,
      this.longitude});

  AddressModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    street = json["street"];
    street2 = json["street2"];
    zip = json["zip"];
    city = json["city"];
    mobile = json["mobile"];
    latitude = json["latitude"] is String
        ? double.parse(json["latitude"])
        : json["latitude"];
    longitude = json["longitude"] is String
        ? double.parse(json["longitude"])
        : json["longitude"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["street"] = street;
    data["street2"] = street2;
    data["zip"] = zip;
    data["city"] = city;
    data["mobile"] = mobile;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    return data;
  }
}
