import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bonfire/theme/color_theme.dart';
import 'package:bonfire/theme/text_theme.dart';

class CustomThemeData {
  final textTheme = CustomTextTheme();
  late final ColorTheme colorTheme;

  CustomThemeData({required bool isDarkTheme}) {
    colorTheme = isDarkTheme
        ? ColorTheme(
            backgroundColor: AppColorsDark.backgroundColor,
            textColor1: AppColorsDark.textColor1,
            textColor2: AppColorsDark.textColor2,
            selectedIconColor: AppColorsDark.selectedIconColor,
            deselectedIconColor: AppColorsDark.deselectedIconColor,
            blurpleColor: AppColorsDark.blurpleColor,
            redColor: AppColorsDark.redColor,
            greenColor: AppColorsDark.greenColor,
            yellowColor: AppColorsDark.yellowColor,
            greyColor1: AppColorsDark.greyColor1,
          )
        : ColorTheme(
            backgroundColor: AppColorsLight.backgroundColor,
            textColor1: AppColorsLight.textColor1,
            textColor2: AppColorsLight.textColor2,
            selectedIconColor: AppColorsLight.selectedIconColor,
            deselectedIconColor: AppColorsLight.deselectedIconColor,
            blurpleColor: AppColorsLight.blurpleColor,
            redColor: AppColorsLight.redColor,
            greenColor: AppColorsLight.greenColor,
            yellowColor: AppColorsLight.yellowColor,
            greyColor1: AppColorsLight.greyColor1,
          );
  }
}

final darkThemeProvider = Provider((ref) => _darkTheme);
final lightThemeProvider = Provider((ref) => _theme);

final _customTheme = CustomThemeData(isDarkTheme: false);
final _theme = ThemeData(
  brightness: Brightness.light,
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(4.0),
    ),
    backgroundColor: AppColorsLight.backgroundColor,
    titleTextStyle:
        const TextStyle(color: AppColorsLight.textColor1, fontSize: 16),
    contentTextStyle: const TextStyle(
      color: AppColorsLight.textColor1,
      fontSize: 16,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColorsLight.greenColor,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: AppColorsLight.backgroundColor,
  iconTheme: const IconThemeData(
    color: AppColorsLight.selectedIconColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColorsLight.greenColor,
  ),
  dividerTheme: const DividerThemeData(
    color: AppColorsLight.greyColor1,
    thickness: 0.1,
  ),
);

// Dark theme
final _customDarkTheme = CustomThemeData(isDarkTheme: true);
final _darkTheme = ThemeData(
  brightness: Brightness.dark,
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(4.0),
    ),
    backgroundColor: AppColorsDark.backgroundColor,
    titleTextStyle:
        const TextStyle(color: AppColorsLight.textColor1, fontSize: 16),
    contentTextStyle: const TextStyle(
      color: AppColorsLight.textColor1,
      fontSize: 16,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColorsDark.blurpleColor,
    foregroundColor: Colors.white,
  ),
  scaffoldBackgroundColor: AppColorsDark.backgroundColor,
  iconTheme: const IconThemeData(
    color: AppColorsDark.selectedIconColor,
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: AppColorsDark.greenColor,
  ),
  dividerTheme: const DividerThemeData(
    color: AppColorsDark.greyColor1,
    thickness: 0.1,
  ),
);

extension CustomTheme on ThemeData {
  CustomThemeData get custom =>
      brightness == Brightness.dark ? _customDarkTheme : _customTheme;

  AssetImage themedImage(String name) {
    final path =
        brightness == Brightness.dark ? 'assets/images/dark' : 'assets/images';
    return AssetImage('$path/$name');
  }
}
