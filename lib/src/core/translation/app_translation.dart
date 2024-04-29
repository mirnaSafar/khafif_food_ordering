import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/translation/languages/ar_langauge.dart';

import 'languages/en_language.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': ENLanguage.map,
        'ar_SA': ARLanguage.map,
      };
}

tr(String key) => key.tr;
