// ignore_for_file: prefer_const_constructors

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/language_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/user_points_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/login_view/login_view.dart';

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
          if (commonResponse.message == "API Phone number must be unique.") {
            Get.off(LoginView());
            return Left(tr('number_exists_lb'));
          } else {
            return Left(commonResponse.message ?? '');
          }
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

  Future<Either<String, UserPointsModel>> points() async {
    try {
      return NetworkUtil.sendRequest(
              type: RequestType.GET,
              url: UserEndpoints.points,
              headers: NetworkConfig.getHeaders(
                  needAuth: true, type: RequestType.GET))
          .then((response) {
        print(response);

        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);
        UserPointsModel points;
        if (commonResponse.getStatus) {
          points = UserPointsModel.fromJson(commonResponse.data! is List
              ? commonResponse.data![0]
              : commonResponse.data!);
          return Right(
            points,
          );
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  void logout() {
    if (storage.isLoggedIn) {
      customLoader();
      Future.delayed(
          Duration(seconds: 1), () => UserRepository().clearUserData());
      BotToast.closeAllLoading();
      showSnackbarText('Signed out successfully', internetSnack: false);

      Get.offAll(LoginView());
    } else {
      showBrowsingDialogAlert(Get.context!);
    }
  }

  clearUserData() {
    storage.globalSharedPreference.clear();
    clearData();
    Get.appUpdate();
  }

  void clearData() {
    storage.setTokenIno('');
    storage.setDelieryServiceAddressOrBranch(address: '');
    orderMethodVal.value = storage.getDelieryServiceAddressOrBranch();

    // storage.setOtpVerified(false);
    storage.globalSharedPreference.remove(storage.PREF_USER);
    cartService.cartList.clear();
    cartService.clearCart();
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
