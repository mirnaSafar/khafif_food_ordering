class BranchModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? street;
  String? city;
  String? zip;
  double? latitude;
  double? longitude;
  String? workTimeFrom;
  String? workTimeTo;
  String? image;

  BranchModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.street,
      this.city,
      this.zip,
      this.latitude,
      this.longitude,
      this.workTimeFrom,
      this.workTimeTo,
      this.image});

  BranchModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    street = json["street"];
    city = json["city"];
    zip = json["zip"];
    latitude =
        json["longitude"] != '' ? double.parse(json["latitude"]) : -120.0;
    longitude =
        json["longitude"] != '' ? double.parse(json["longitude"]) : -122.0;
    workTimeFrom = json["work_time_from"];
    workTimeTo = json["work_time_to"];
    image = json["image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["street"] = street;
    data["city"] = city;
    data["zip"] = zip;
    data["latitude"] = latitude;
    data["longitude"] = longitude;
    data["work_time_from"] = workTimeFrom;
    data["work_time_to"] = workTimeTo;
    data["image"] = image;
    return data;
  }
}
