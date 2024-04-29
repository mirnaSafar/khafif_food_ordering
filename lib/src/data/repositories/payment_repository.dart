import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/payment_endpoint.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/payment_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

import '../../core/network/network_utils.dart';

class PaymentRepository {
  Future<Either<String, List<PaymentModel>>> getPaymentMethods() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: PaymentEndPoints.getPaymentMethods,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        List<PaymentModel> resultList = [];
        if (commonResponse.getStatus) {
          for (var element in commonResponse.data!) {
            resultList.add(PaymentModel.fromJson(element));
          }
          return Right(
            resultList,
          );
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
