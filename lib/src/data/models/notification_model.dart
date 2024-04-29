class NotifictionModel {
  // String? notifctionType;
  String? title;
  String? body;
  // String? subStatus;

  NotifictionModel({
    this.title,
    this.body,
  });

  NotifictionModel.fromJson(Map<String, dynamic> json) {
    // notifctionType = json['notifction_type'];
    title = json['title'];
    body = json['body'];
    // subStatus = json['sub_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    // data['notifction_type'] = notifctionType;
    data['title'] = title;
    data['text'] = body;
    // data['sub_status'] = subStatus;
    return data;
  }
}
