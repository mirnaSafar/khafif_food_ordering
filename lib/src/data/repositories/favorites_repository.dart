import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/favorite_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class FavoritesRepository {
  Future<Either<String, List<ProductTemplateModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: FavoritesEndpoints.wishlist,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<ProductTemplateModel> resultList = [];
          for (var element in commonResponse.data!) {
            resultList.add(
              ProductTemplateModel.fromJson(element['product_id']),
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

  Future<Either<String, String>> remove({required int id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: '${FavoritesEndpoints.wishlist}$id',
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.DELETE),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(response['message']);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> add({required int id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: '${FavoritesEndpoints.wishlist}$id',
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

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
