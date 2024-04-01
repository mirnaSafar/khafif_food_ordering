import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/languages_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';

class LanguageService {
  static String arCode = 'ar_001';
  static String enCode = 'en_US';

  Future updateLAnguage({required String langCode}) async {
    await LanguageRepository().updateLanguage(langCode: langCode).then(
        (value) => value.fold((l) => CustomToast.showMessage(message: l), (r) {
              setLanguage(langCode);

              Get.offAll(const ProductsView());
            }));
  }
}
