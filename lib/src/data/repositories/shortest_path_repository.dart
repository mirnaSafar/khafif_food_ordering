import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/shortest_path_endpoint.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/order_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class ShortestPathRepository {
  Future<Either<String, OrderModel>> get({required LatLng location}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: ShortestPathEndpoints.getShortestPath,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);
//?--- should reconsider this code when the response get clear ----
        if (commonResponse.getStatus) {
          return Right(commonResponse.data!);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
