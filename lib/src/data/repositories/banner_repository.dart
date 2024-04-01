import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/banner_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/banner_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class BannerRepository {
  Future<Either<String, List<BannerModel>>> getBanner() async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.GET, url: BannerEndpoints.getBanners)
          .then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        List<BannerModel> bannerList = [];
        if (commonResponse.getStatus) {
          for (var element in commonResponse.data!) {
            bannerList.add(BannerModel.fromJson(element));
          }
          return Right(bannerList);
        } else {
          return Left(commonResponse.message!);
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
