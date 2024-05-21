import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_theme.dart';
import 'package:khafif_food_ordering_application/src/core/app/my_app.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/services/cart_services.dart';
import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/favorites_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/language_service.dart';
import 'package:khafif_food_ordering_application/src/core/services/location_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/user_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/delivery_options_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/cart_view/confirm_order_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/product_details_view/product_details_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/splash_screen/splash_controller.dart';
import '../app/my_app_controller.dart';
import '../services/connectivity_service.dart';
import '../services/notifacation_service.dart';
import '../../data/repositories/shared_preference_repository.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';

ConnectivityService get connectivityService => Get.find<ConnectivityService>();

SharedPreferenceRepository get storage =>
    Get.find<SharedPreferenceRepository>();
CartService get cartService => Get.find<CartService>();
FavoriteService get favoriteService => Get.find<FavoriteService>();
LocationService get locationService => Get.find<LocationService>();
NotificationService get notificationService => Get.find<NotificationService>();
ProductsViewController get productsVieewController =>
    Get.find<ProductsViewController>();
ProductDetailsController get productsDetailsController =>
    Get.find<ProductDetailsController>();
CartController get cartController => Get.find<CartController>();
SplashController get splashController => Get.find<SplashController>();
DateTimeController get dateTimeController => Get.find<DateTimeController>();
ShopsController get shopsController => Get.find<ShopsController>();
AppTheme get appTheme => Get.find<AppTheme>();

double get taxAmount => 0.10;

bool get isOnline =>
    Get.find<MyAppController>().connectivityStatus.value ==
    ConnectivityStatus.ONLINE;

bool get isOffline =>
    Get.find<MyAppController>().connectivityStatus.value ==
    ConnectivityStatus.OFFLINE;
Rx<UserModel?>? get userinfo => storage.getUserInfo().obs;

void checkConnection(Function function) {
  //easy
  if (isOnline) {
    function();

    return;
  } else {
    showNoConnectionMessage();
  }
}

void homeRefreshingMethod() {
  checkConnection(() {});
  storage.isLoggedIn ? favoriteService.getFavorites() : null;

  getCurrentProducts();
  productsVieewController.getAllCategories();
  productsVieewController.getBanners();
  // Get.find<SplashController>().getOrderDeliveryOptions();
}

void getCurrentProducts() {
  productsVieewController.categoryIndex.value == -1
      ? productsVieewController.getAllProducts()
      : productsVieewController.getProductsByCategory(
          id: productsVieewController
              .carouselItems[productsVieewController.sliderIndex.value]
                  [productsVieewController.categoryIndex.value]
              .id!);
}

void showNoConnectionMessage() {
  if (!isOnline) {
    showSnackbarText(tr("key_bot_toast_offline"));
    return;
  }
}

Future<double> whenNotZero(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) {
      return value;
    }
  }
  return 0.0;
  // stream exited without a true value, maybe return an exception.
}

void customLoader() => BotToast.showCustomLoading(toastBuilder: (context) {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.mainWhiteColor,
            borderRadius: BorderRadius.circular(20)),
        width: Get.context!.screenWidth(4),
        height: Get.context!.screenWidth(4),
        child: SpinKitFadingCircle(
          color: AppColors.mainAppColor,
          size: Get.context!.screenWidth(8),
        ),
      );
    });

showSnackbarText(String text, {bool? internetSnack = true, String? imageName}) {
  Get.showSnackbar(GetSnackBar(
    dismissDirection: DismissDirection.endToStart,
    snackStyle: SnackStyle.GROUNDED,
    // forwardAnimationCurve: Curves.easeInCirc,

    margin: EdgeInsets.all(Get.context!.screenWidth(20)),
    borderRadius: 20,
    maxWidth: Get.context!.screenWidth(1.3),

    padding: EdgeInsets.symmetric(
        horizontal: Get.context!.screenWidth(30),
        vertical: Get.context!.screenWidth(50)),
    animationDuration: const Duration(milliseconds: 500),
    duration: const Duration(seconds: 2),
    messageText: Row(
      children: [
        if (internetSnack!)
          Icon(
            isOffline ? Icons.wifi_off_sharp : Icons.wifi,
            color: AppColors.mainWhiteColor,
          ),
        if (imageName != null)
          SvgPicture.asset(
            'assets/images/$imageName.svg',
            // color: AppColors.mainWhiteColor,
          ),
        Get.context!.screenWidth(40).px,
        CustomText(
          textColor: AppColors.mainWhiteColor,
          darkTextColor: AppColors.mainWhiteColor,
          text: text,
          textType: TextStyleType.BODYSMALL,
        )
      ],
    ),
  ));
}

RxList<AddressModel> userAddresses = storage.getUserAddresses().obs;

setLanguage(String lan) {
  storage.setAppLanguage(lan);
  Get.updateLocale(getLocal());
  Get.back();
}

void changeLanguageDialog() {
  // SetteingsController controller = Get.put(SetteingsController());
  Get.defaultDialog(
      backgroundColor: AppColors.mainWhiteColor,
      title: tr('Languages_lb'),
      titlePadding: EdgeInsets.only(top: Get.context!.screenWidth(20)),
      content: Column(
        children: [
          const Divider(),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                fixedSize: MaterialStatePropertyAll(
                  Size(
                    Get.context!.screenWidth(1),
                    Get.context!.screenHeight(14),
                  ),
                ),
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent)),
            onPressed: () {
              updateLanguage(langCode: LanguageService.enCode);
            },
            child: CustomText(
              text: 'English',
              textType: TextStyleType.BODY,
              // textColor: AppColors.mainAppColor,
            ),
          ),
          TextButton(
            style: ButtonStyle(
                backgroundColor:
                    const MaterialStatePropertyAll(Colors.transparent),
                fixedSize: MaterialStatePropertyAll(
                  Size(
                    Get.context!.screenWidth(1),
                    Get.context!.screenHeight(14),
                  ),
                ),
                overlayColor:
                    const MaterialStatePropertyAll(Colors.transparent)),
            onPressed: () {
              updateLanguage(langCode: LanguageService.arCode);
            },
            child: CustomText(
              text: 'العربية',
              textType: TextStyleType.BODY,
              // textColor: AppColors.mainAppColor,
            ),
          ),
        ],
      ));
}

void updateLanguage({required String langCode}) {
  if (storage.getAppLanguage() != langCode) {
    LanguageService().updateLAnguage(langCode: langCode);
  }
}

class FileTypeModel {
  FileTypeEnum type;
  String path;

  FileTypeModel(this.path, this.type);
}

String tokenNotFoundMessage = 'customer not found';

checkTokenIsExpiredToShowLoginWarning(
    {required String apiMessage, required void Function() function}) {
  if (apiMessage.toLowerCase() == tokenNotFoundMessage) {
    showBrowsingDialogAlert(Get.context!);
  } else {
    function.call();
  }
}

RxString orderMethodVal = storage.getDelieryServiceAddressOrBranch().obs;

DeliveryOptionsModel? slectedDeliveryService() {
  return splashController.orderDeliveryOptions.firstWhereOrNull(
    (element) => element.id == storage.getOrderDeliveryOptionSelected(),
  );
}
