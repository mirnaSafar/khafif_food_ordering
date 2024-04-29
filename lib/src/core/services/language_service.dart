import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/languages_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';

class LanguageService extends BaseController {
  static String arCode = 'ar_001';
  static String enCode = 'en_US';

  Future updateLAnguage({required String langCode}) async {
    runFullLoadingFutuerFunction(
        function: LanguageRepository()
            .updateLanguage(langCode: langCode)
            .then((value) => value.fold(
                    (l) => checkTokenIsExpiredToShowLoginWarning(
                        apiMessage: l,
                        function: () => CustomToast.showMessage(
                              messageType: MessageType.WARNING,
                              message: l,
                            )), (r) {
                  setLanguage(langCode);

                  Get.offAll(const ProductsView());
                })));
  }
}
