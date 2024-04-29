import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/user_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_repository.dart';

class ProfileController extends BaseController {
  @override
  void onInit() {
    update();
    super.onInit();
    getUserPoints();
  } // final MapController _mapControlsler = Get.put(MapController());

  Rx<UserModel>? usermodel = userinfo?.value!.obs;
  RxDouble discountPercentFontSize = (80.0).obs;
  RxDouble discountFontSize = (32.0).obs;
  RxDouble userPoints = 0.0.obs;
  Rx<Widget> cardBackground = Transform.translate(
    offset: const Offset(0, 0),
    child: SvgPicture.asset(
      AppAssets.icUserCard,
    ),
  ).obs;

  RxBool showQrCode = true.obs;
  RxBool get isUserPointsLoading =>
      operationType.contains(OperationType.MODIFYUSERINFORMATION).obs;
  RxString intUserPoints = ''.obs;
  RxString userCode = ''.obs;
  getUserPoints() {
    runLoadingFutuerFunction(
        type: OperationType.MODIFYUSERINFORMATION,
        function: UserRepository()
            .points()
            .then((value) => value.fold((l) => null, (r) {
                  userPoints.value = r.point ?? 0.0;
                  userCode.value = r.code ?? '';
                  intUserPoints.value =
                      '${userPoints.value.toString().split('.')[0]}.00';
                })));
  }

  flipCard() {
    showQrCode.value = !showQrCode.value;
    changeDiscountFontSize();
    changeDiscountPercentFontSize();
    changeCardBackground();
  }

  changeDiscountPercentFontSize() {
    discountPercentFontSize.value = showQrCode.value ? 48 : 80;
  }

  changeDiscountFontSize() {
    discountFontSize.value = showQrCode.value ? 16 : 32;
  }

  changeCardBackground() {
    cardBackground.value = showQrCode.value
        ? Transform.translate(
            offset: Offset(0, -screenWidth(8.5)),
            child: SvgPicture.asset(
              AppAssets.icUserCard,
              width: screenWidth(1.5),
              height: screenHeight(3.3),
            ),
          )
        : Transform.translate(
            offset: const Offset(0, 0),
            child: SvgPicture.asset(
              AppAssets.icUserCard,
              height: screenHeight(4),
            ),
          );
  }
}
