import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class AppTheme extends GetxController {
  RxBool isDarkMode = storage.getAppTheme().obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    updateTheme();
    storage.setAppTheme(dark: isDarkMode.value);
  }

  ThemeData get theme => isDarkMode.value ? darkTheme : lightTheme;
  ThemeMode get themeMode =>
      isDarkMode.value ? ThemeMode.dark : ThemeMode.light;
  void init() {
    // Use ever or reaction to listen for changes in isDarkMode and update the theme accordingly
    ever(isDarkMode, (_) {
      updateTheme();
      Get.forceAppUpdate();
    });
  }

  void updateTheme() {
    Get.changeTheme(theme);
    Get.changeThemeMode(themeMode);
  }

  static ThemeData get lightTheme {
    ThemeData base = ThemeData.light();
    return base.copyWith(
      dividerTheme: DividerThemeData(
        color: AppColors.mainGreyColor,
      ),
      dialogBackgroundColor: AppColors.backgroundColor,
      unselectedWidgetColor:
          AppColors.buttonTextColor, // Color of the checkbox when unchecked
      checkboxTheme: CheckboxThemeData(
          side: BorderSide(width: 1, color: AppColors.greyColor),
          shape: CircleBorder(
              side: BorderSide(width: 1, color: AppColors.greyColor)),
          checkColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors
                  .white; // Background color when the checkbox is checked
            }
            return AppColors.buttonTextColor; // Default background color
          }),
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors
                  .buttonTextColor; // Background color when the checkbox is checked
            }
            return Colors.white; // Default background color
          })),

      hintColor: AppColors.buttonTextColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        focusColor: AppColors.mainWhiteColor,
        focusElevation: 0,
        hoverColor: AppColors.mainWhiteColor,
        hoverElevation: 0,
        elevation: 0,
        highlightElevation: 0,
      ),
      primaryColor: AppColors.mainAppColor,
      textTheme: ThemeData.light().textTheme.copyWith(
            displayLarge: TextStyle(
                color: AppColors.mainTextColor,
                fontFamily: 'Baloo 2',
                fontSize: AppFonts.header), // Define custom color for headline1
            displayMedium: TextStyle(
                color: AppColors.mainTextColor,
                fontFamily: 'Baloo 2',
                fontSize: AppFonts.title), // Define custom color for headline2
            bodyLarge: TextStyle(
                color: AppColors.mainTextColor,
                fontFamily: 'Baloo 2',
                fontSize: AppFonts.body), // Define custom color for bodyText1
            bodyMedium: TextStyle(
                fontFamily: 'Baloo 2',
                color: AppColors.mainTextColor,
                fontSize: AppFonts.bodySmall),
            bodySmall: TextStyle(
                fontFamily: 'Baloo 2',
                color: AppColors.greyColor,
                fontSize: AppFonts.small), // Define custom color for bodyText2
            // Add more text styles as needed
          ),
      scaffoldBackgroundColor: AppColors.backgroundColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.mainAppColor,
        ),
      ),
      cardColor: Colors.white,
      brightness: Brightness.light,
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          color: Colors.transparent,
          scrolledUnderElevation: 0),
      colorScheme:
          ColorScheme.light(onPrimary: AppColors.mainTextColor).copyWith(
        background: AppColors.backgroundColor,
        primary: AppColors.mainWhiteColor,
        secondary: Colors.black,
      ),
    );
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark();

    return base.copyWith(
      dividerTheme: DividerThemeData(
        color: AppColors.mainGreyColor,
      ),

      dialogBackgroundColor: AppColors.secondaryblackColor,

      unselectedWidgetColor:
          AppColors.buttonTextColor, // Color of the checkbox when unchecked
      checkboxTheme: CheckboxThemeData(
          side: BorderSide(width: 1, color: AppColors.greyColor),
          shape: CircleBorder(
              side: BorderSide(width: 1, color: AppColors.greyColor)),
          checkColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return Colors
                  .white; // Background color when the checkbox is checked
            }
            return AppColors.buttonTextColor; // Default background color
          }),
          fillColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return AppColors
                  .buttonTextColor; // Background color when the checkbox is checked
            }
            return Colors.white; // Default background color
          })),

      hintColor: AppColors.buttonTextColor,

      primaryColor: AppColors.mainAppColor,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.white,
        focusColor: AppColors.mainWhiteColor,
        focusElevation: 0,
        hoverColor: AppColors.mainWhiteColor,
        hoverElevation: 0,
        elevation: 0,
        highlightElevation: 0,
      ),
      textTheme: ThemeData.dark().textTheme.copyWith(
            displayLarge: TextStyle(
                color: const Color(0xffcdcdcd),
                fontFamily: 'Baloo 2',
                fontSize: AppFonts.header), // Define custom color for headline1
            displayMedium: TextStyle(
                color: const Color(0xffcdcdcd),
                fontFamily: 'Baloo 2',
                fontSize: AppFonts.title), // Define custom color for headline2
            bodyLarge: TextStyle(
                color: const Color(0xffcdcdcd),
                fontFamily: 'Baloo 2',
                fontSize: AppFonts.body), // Define custom color for bodyText1
            bodyMedium: TextStyle(
                fontFamily: 'Baloo 2',
                color: const Color(0xffcdcdcd),
                fontSize: AppFonts.bodySmall),
            bodySmall: TextStyle(
                fontFamily: 'Baloo 2',
                color: const Color(0xffcdcdcd),
                fontSize: AppFonts.small), // Define custom color for bodyText2
            // Add more text styles as needed
          ),
      scaffoldBackgroundColor: AppColors.secondaryblackColor,
      cardColor: Colors.black,
      // textTheme: base.textTheme.copyWith(
      //   bodySmall: base.textTheme.bodySmall!.copyWith(
      //     color: const Color(0xffcdcdcd),
      //   ),
      // ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style:
            ElevatedButton.styleFrom(backgroundColor: AppColors.mainAppColor),
      ),
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          scrolledUnderElevation: 0),
      colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.grey[800],
        secondary: Colors.white70,
        background: AppColors.mainTextColor,
      ),
    );
  }
}
