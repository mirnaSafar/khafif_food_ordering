import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/fcm_token_endpoint.dart';

import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class FcmTokenRepository {
  Future<Either<String, bool>> saveFcmToken({required String fcmToken}) async {
    try {
      return NetworkUtil.sendMultipartRequest(
          requestType: RequestType.POST,
          headers:
              NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
          url: FcmTokenEndpoints.saveFcmToken,
          params: {"fcm_token": fcmToken},
          fields: {"fcm_token": fcmToken}).then((response) {
        CommonResponse commonResponse = CommonResponse.fromJson(response);
        if (commonResponse.getStatus) {
          return const Right(true);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
