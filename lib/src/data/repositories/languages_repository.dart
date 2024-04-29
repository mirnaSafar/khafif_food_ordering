import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/language_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class LanguageRepository {
  Future<Either<String, bool>> updateLanguage(
      {required String langCode}) async {
    try {
      return NetworkUtil.sendMultipartRequest(
          requestType: RequestType.PUT,
          headers:
              NetworkConfig.getHeaders(needAuth: true, type: RequestType.PUT),
          url: LanguageEndpoints.setLanguage,
          fields: {"lang_code": langCode}).then((response) {
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
