import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/order_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';
import 'package:khafif_food_ordering_application/src/data/models/delivery_options_model.dart';

class OrderOptionsRepository {
  Future<Either<String, List<DeliveryOptionsModel>>> getDeliverOptions() async {
    try {
      return NetworkUtil.sendMultipartRequest(
        requestType: RequestType.GET,
        url: OrderEndPoints.getOrderOptions,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<DeliveryOptionsModel> resultList = [];

          for (var element in commonResponse.data!) {
            resultList.add(
              DeliveryOptionsModel.fromJson(element),
            );
          }
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
