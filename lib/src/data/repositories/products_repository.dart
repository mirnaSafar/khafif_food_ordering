import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/products_endpoint.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/pagination_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class ProductsRepository {
  Future<Either<String, List<dynamic>>> getProductsTemplates(
      {String? id = '', int? perPage = 4, required int page}) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        requestType: RequestType.GET,
        url: ProductsEndPoints.getProductTemplates + id!,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
        fields: {
          "per_page": perPage!.toString(),
          "page": page.toString(),
        },
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<ProductTemplateModel> resultList = [];

          for (var element in commonResponse.data!) {
            resultList.add(
              ProductTemplateModel.fromJson(element),
            );
          }
          PaginationModel paginationModel = commonResponse.pagination!;
          return Right([resultList, paginationModel]);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<dynamic>>> getProductsTemplatesByCategory(
      {required int id, int? perPage = 4, required int page}) async {
    try {
      return NetworkUtil.sendMultipartRequest(
        requestType: RequestType.GET,
        url: ProductsEndPoints.getProductTemplatesByCategory + id.toString(),
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
        fields: {
          "per_page": perPage!.toString(),
          "page": page.toString(),
        },
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<ProductTemplateModel> resultList = [];

          for (var element in commonResponse.data!) {
            resultList.add(
              ProductTemplateModel.fromJson(element),
            );
          }
          PaginationModel paginationModel = commonResponse.pagination!;
          return Right([resultList, paginationModel]);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
