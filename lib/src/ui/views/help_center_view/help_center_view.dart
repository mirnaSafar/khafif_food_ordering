import 'package:flutter/material.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/core/utility/url_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_icon_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';

class HelpCenterView extends StatelessWidget {
  const HelpCenterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        appbarTitle: tr('help_center_lb'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
            future: whenNotZero(
              Stream<double>.periodic(const Duration(milliseconds: 50),
                  (x) => MediaQuery.of(context).size.width),
            ),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data! > 0) {
                  return Padding(
                    padding: EdgeInsets.all(context.screenWidth(30)),
                    child: Column(children: [
                      CustomIconText(
                        // imagecolor: AppColors.mainTextColor,
                        onTap: () {},
                        imageHeight: context.screenWidth(18),
                        image: const Icon(Icons.help_outline_outlined),
                        text: tr('help_center_lb'),

                        textType: TextStyleType.BODY,
                      ),
                      const Divider(),
                      CustomIconText(
                        // imagecolor: AppColors.mainTextColor,
                        onTap: () {},
                        imageHeight: context.screenWidth(18),
                        image:
                            const Icon(Icons.supervised_user_circle_outlined),
                        text: tr('terms_of_service_lb'),

                        textType: TextStyleType.BODY,
                      ),
                      const Divider(),
                      CustomIconText(
                        // imagecolor: AppColors.mainTextColor,
                        onTap: () {
                          UrlLauncherUtil().startLaunchUrl(
                              url: Uri.parse(
                                  'https://erp.khafif.com.sa/privacy'),
                              type: UrlType.WEB);
                        },
                        imageHeight: context.screenWidth(18),
                        image: const Icon(Icons.privacy_tip_outlined),
                        text: tr('privacy_policy_lb'),

                        textType: TextStyleType.BODY,
                      ),
                      const Divider(),
                    ]),
                  );
                }
                return Container();
              }
              return Container();
            }),
      ),
    );
  }
}
