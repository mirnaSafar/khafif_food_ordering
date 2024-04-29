import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/user_addresses_enndpoints.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import '../../core/network/network_utils.dart';
import '../models/common_response.dart';
import '../../core/network/network_config.dart';

class UserAddressesRepository {
  Future<Either<String, AddressModel>> addAddress(
      {required AddressModel address}) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: UserAddressesEndpoints.addAddress,
          headers:
              NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
          body: {
            "name": address.name,
            "type": "1",
            "email": userinfo?.value?.email ?? '',
            "street": address.street,
            "street2": address.street2 ?? '',
            "zip": address.zip,
            "city": address.city,
            "latitude": address.latitude.toString(),
            "longitude": address.longitude.toString(),
          }).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(AddressModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<AddressModel>>> getAddress() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: UserAddressesEndpoints.getAddresses,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<AddressModel> resultList = [];
          if (commonResponse.data is List) {
            for (var element in commonResponse.data!) {
              resultList.add(
                AddressModel.fromJson(element),
              );
            }
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

  Future<Either<String, bool>> deleteAddress({required int addressID}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: UserAddressesEndpoints.deleteAddresse + addressID.toString(),
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.DELETE),
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
