import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/search_product_endpoint.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class SearchProductsRepository {
  Future<Either<String, List<ProductTemplateModel>>> getAll(
      {required String query}) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        requestType: RequestType.GET,
        url: SearchEndpoints.search,
        fields: {'query': query},
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        if (response['data'] is Map<String, dynamic>) {
          response = [];
        }
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<ProductTemplateModel> resultList = [];

          for (var element in commonResponse.data!) {
            resultList.add(
              ProductTemplateModel.fromJson(element),
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
