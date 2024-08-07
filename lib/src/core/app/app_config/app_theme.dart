import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/app/my_app.dart';
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
    ThemeData base = ThemeData.light(
// useMaterial3: false,

        );
    return base.copyWith(
      dividerTheme: DividerThemeData(
        color: AppColors.mainGreyColor,
      ),
      dialogBackgroundColor: Get.theme.scaffoldBackgroundColor,
      dialogTheme: DialogTheme(
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
      ),

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
                fontSize: AppFonts(Get.context ?? globalContext)
                    .header), // Define custom color for headline1
            displayMedium: TextStyle(
                color: AppColors.mainTextColor,
                fontFamily: 'Baloo 2',
                fontSize: AppFonts(Get.context ?? globalContext)
                    .title), // Define custom color for headline2
            bodyLarge: TextStyle(
                color: AppColors.mainTextColor,
                fontFamily: 'Baloo 2',
                fontSize: AppFonts(Get.context ?? globalContext)
                    .body), // Define custom color for bodyText1
            bodyMedium: TextStyle(
                fontFamily: 'Baloo 2',
                color: AppColors.mainTextColor,
                fontSize: AppFonts(Get.context ?? globalContext).bodySmall),
            bodySmall: TextStyle(
                fontFamily: 'Baloo 2',
                color: AppColors.greyColor,
                fontSize: AppFonts(Get.context ?? globalContext)
                    .small), // Define custom color for bodyText2
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
          systemOverlayStyle: SystemUiOverlayStyle(
// Status bar color
            statusBarColor: Colors.transparent,

// Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          elevation: 0,
          color: Colors.transparent,
          scrolledUnderElevation: 0),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Get.theme.colorScheme.secondary,
        selectionColor: Get.theme.colorScheme.surface,
        selectionHandleColor: Get.theme.colorScheme.secondary,
      ),
      colorScheme:
          ColorScheme.light(onPrimary: AppColors.mainTextColor).copyWith(
        background: AppColors.mainWhiteColor,
        primary: AppColors.mainWhiteColor,
        secondary: AppColors.secondary2blackColor,
        onBackground: AppColors.mainWhiteColor,
        surface: Colors.grey[350]!,
        onSurface: Colors.grey[100]!,
        primaryContainer: Get.theme.scaffoldBackgroundColor,
      ),
    );
  }

  static ThemeData get darkTheme {
    ThemeData base = ThemeData.dark(
        // useMaterial3: false,
        );

    return base.copyWith(
      dividerTheme: DividerThemeData(
        color: AppColors.mainGreyColor,
      ),

      dialogBackgroundColor: Get.theme.colorScheme.primary,
      dialogTheme: DialogTheme(
        backgroundColor: Get.theme.colorScheme.primaryContainer,
        surfaceTintColor: Colors.transparent,
      ),
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
                fontSize: AppFonts(Get.context ?? globalContext)
                    .header), // Define custom color for headline1
            displayMedium: TextStyle(
                color: const Color(0xffcdcdcd),
                fontFamily: 'Baloo 2',
                fontSize: AppFonts(Get.context ?? globalContext)
                    .title), // Define custom color for headline2
            bodyLarge: TextStyle(
                color: const Color(0xffcdcdcd),
                fontFamily: 'Baloo 2',
                fontSize: AppFonts(Get.context ?? globalContext)
                    .body), // Define custom color for bodyText1
            bodyMedium: TextStyle(
                fontFamily: 'Baloo 2',
                color: const Color(0xffcdcdcd),
                fontSize: AppFonts(Get.context ?? globalContext).bodySmall),
            bodySmall: TextStyle(
                fontFamily: 'Baloo 2',
                color: const Color(0xffcdcdcd),
                fontSize: AppFonts(Get.context ?? globalContext)
                    .small), // Define custom color for bodyText2
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
          systemOverlayStyle: SystemUiOverlayStyle(
// Status bar color
            statusBarColor: Colors.transparent,

// Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
          scrolledUnderElevation: 0),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Get.theme.colorScheme.secondary,
        selectionColor: Get.theme.colorScheme.secondary,
        selectionHandleColor: Get.theme.colorScheme.secondary,
      ),
      colorScheme:
          ColorScheme.dark(onPrimary: AppColors.secondary2blackColor).copyWith(
        primary: AppColors.secondary2blackColor,
        secondary: Colors.white70,
        onBackground: Colors.grey[800],
        background: AppColors.secondary2blackColor,
        surface: Colors.grey[600]!,
        onSurface: Colors.grey[400]!,
        primaryContainer: AppColors.secondary2blackColor,
      ),
    );
  }
}
