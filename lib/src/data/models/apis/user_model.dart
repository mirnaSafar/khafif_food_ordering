class UserModel {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? token;
  double? timeOtpMinutes;
  String? top;
  String? image;

  UserModel(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.token,
      this.timeOtpMinutes,
      this.top,
      this.image});

  UserModel.fromJson(Map<String, dynamic> json) {
    String imageIndex = json.keys.last;
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    token = json["token"];
    timeOtpMinutes = json["time_otp_minutes"];
    top = json["top"];
    image = json[imageIndex];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["name"] = name;
    data["email"] = email;
    data["phone"] = phone;
    data["token"] = token;
    data["time_otp_minutes"] = timeOtpMinutes;
    data["top"] = top;
    data["image"] = image;
    return data;
  }
}
