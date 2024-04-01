import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/language_service.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

import '../../core/network/network_utils.dart';
import '../models/apis/user_model.dart';
import '../models/common_response.dart';
import '../../core/network/endpoints/user_endpoints.dart';
import '../../core/network/network_config.dart';

class UserRepository {
  Future<Either<String, UserModel>> login({
    required String phone,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: UserEndpoints.login,
          headers:
              NetworkConfig.getHeaders(needAuth: false, type: RequestType.POST),
          body: {
            'phone': phone,
          }).then((response) {
        print(response);
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(
            UserModel.fromJson(
              commonResponse.data ?? {},
            ),
          );
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> signup({
    required String userName,
    required String email,
    required String phone,
  }) async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.POST,
              url: UserEndpoints.signup,
              headers: NetworkConfig.getHeaders(
                needAuth: false,
                type: RequestType.POST,
              ),
              body: {"user_name": userName, "email": email, "phone": phone})
          .then((response) {
        print(response);

        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> modifyUserInfo({
    required String userName,
    required String email,
    required String image,
  }) async {
    try {
      return NetworkUtil.sendMultipartRequest(
          requestType: RequestType.PUT,
          url: UserEndpoints.signup,
          headers: NetworkConfig.getHeaders(
            needAuth: true,
            type: RequestType.PUT,
          ),
          files: {
            "image": image,
          },
          fields: {
            "name": userName,
            "email": email,
            "lang": storage.getAppLanguage(),
          }).then((response) {
        print(response);

        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(UserModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, UserModel>> verifyUser({
    required String userOtp,
    required String phone,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: UserEndpoints.verify,
          headers: NetworkConfig.getHeaders(
            needAuth: true,
            type: RequestType.POST,
          ),
          body: {
            "phone": phone,
            "user_otp": userOtp,
          }).then((response) {
        print(response);

        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(UserModel.fromJson(
            commonResponse.data ?? {},
          ));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  clearUserData() {
    storage.globalSharedPreference.clear();
    clearData();
    Get.appUpdate();
  }

  void clearData() {
    storage.setTokenIno('');
    storage.setOtpVerified(false);
    storage.globalSharedPreference.remove(storage.PREF_USER);
    cartService.cartList.clear();
    favoriteService.favoritesList.clear();
    setLanguage(LanguageService.enCode);
    userAddresses.clear();
  }

  void resetTheme() {
    appTheme.isDarkMode.value = false;
    appTheme.updateTheme();
    storage.setAppTheme(dark: appTheme.isDarkMode.value);
  }
}
