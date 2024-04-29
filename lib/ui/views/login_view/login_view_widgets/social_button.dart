import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SocialButton extends StatelessWidget {
  _launchURL() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      launchUrl(uri);
    } else {
      throw 'could not launch';
    }
  }

  const SocialButton(
      {super.key,
      required this.path,
      required this.text,
      required this.color,
      required this.url});
  final String path, text;
  final String url;
  final Color color;
  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    // final height = MediaQuery.of(context).size.height;
    return Sizer(
      builder: (context, orientation, deviceType) => InkWell(
        onTap: () => {_launchURL()},
        child: Container(
          height: 15.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                path,
              ),
              30.px,
              CustomText(
                text: text,
                textColor: AppColors.mainWhiteColor,
                textType: TextStyleType.CUSTOM,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
