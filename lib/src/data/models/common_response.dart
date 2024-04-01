import 'package:khafif_food_ordering_application/src/data/models/apis/pagination_model.dart';

class CommonResponse<T> {
  int? statusCode;
  T? data;
  String? message;
  PaginationModel? pagination;
  CommonResponse.fromJson(dynamic json) {
    this.statusCode = json['statusCode'];

    if (statusCode == 200) {
      this.data = json['response']['data'];
      this.pagination =
          PaginationModel.fromJson(json['response']['pagination']);
    } else {
      if (json['response'] != null && json['response'] is Map) {
        this.message = json['response']['massage'];
      } else {
        switch (statusCode) {
          case 400:
            this.message = ' 400 bad request';
            break;
          case 401:
            this.message = ' 401 unauthorized';
            break;
          case 403:
            this.message = ' 403 forbidden';
            break;
          case 404:
            this.message = ' 404 page not found';
            break;
          case 500:
            this.message = ' 500  internal server error';
            break;
          case 503:
            this.message = ' 503  server unavailable';
            break;
        }
      }
    }
  }
  bool get getStatus => statusCode.toString().startsWith('2');
}
