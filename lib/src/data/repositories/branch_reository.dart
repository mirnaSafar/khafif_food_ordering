import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/branch_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/branch_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class BranchRepository {
  Future<Either<String, List<BranchModel>>> getAllBranches() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: BranchEndpoints.getAllBranches,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<BranchModel> resultList = [];
          for (var element in commonResponse.data!) {
            resultList.add(
              BranchModel.fromJson(element),
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

  Future<Either<String, List<BranchModel>>> getOpenBranches(
      {required String dateTime, required int branchId}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: BranchEndpoints.getBranch,
        body: {"pickUp_datetime": dateTime, "branch_id": branchId},
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<BranchModel> resultList = [];
          for (var element in commonResponse.data!['branch']) {
            resultList.add(
              BranchModel.fromJson(element),
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

  Future<Either<String, BranchModel>> getBranch({required int branchID}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: '${BranchEndpoints.getBranch}/$branchID',
        headers:
            NetworkConfig.getHeaders(needAuth: false, type: RequestType.GET),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          BranchModel result = BranchModel.fromJson(commonResponse.data!);

          return Right(result);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CustomerCartModel>> setBranch(
      {required int branchId}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: BranchEndpoints.setBranch,
        body: {"branch_id": branchId},
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          CustomerCartModel cart =
              CustomerCartModel.fromJson(commonResponse.data!);

          return Right(cart);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
