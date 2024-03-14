import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class AppTheme {
  static ThemeData get theme {
    var typography = Typography.material2021(platform: defaultTargetPlatform);
    var textTheme = typography.black.apply(
      fontFamily: 'Outfit',
      bodyColor: Colors.black,
      displayColor: Colors.black,
    );

    var titleLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      fontFamily: 'Avenir',
      color: Colors.black,
      height: 34 / 24,
      letterSpacing: 0,
    );

    var titleMedium = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      fontFamily: 'Avenir',
      height: 20 / 14,
      color: Colors.black,
      letterSpacing: 0,
    );

    var titleSmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Avenir',
      height: 17 / 14,
      color: Colors.black,
      letterSpacing: 0,
    );

    var labelLarge = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      fontFamily: 'Outfit',
      height: 1,
      color: Colors.black,
      letterSpacing: 0,
    );

    var labelSmall = const TextStyle(
      fontSize: 14,
      fontFamily: 'Avenir',
      fontWeight: FontWeight.w500,
      height: 20 / 14,
      color: Colors.black,
      letterSpacing: 0,
    );

    var bodyLarge = const TextStyle(
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      height: 1,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    ); // Done

    var bodyMedium = const TextStyle(
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    ); // Done

    var bodySmall = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'Outfit',
      letterSpacing: 0,
      color: Colors.black,
      fontStyle: FontStyle.normal,
    ); // Done

    var headlineMedium = const TextStyle(
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w600,
      fontSize: 20,
      height: 28 / 20,
      color: Colors.black,
      fontStyle: FontStyle.normal,
      letterSpacing: 0,
    ); // Done

    var headlineSmall = const TextStyle(
      fontSize: 30,
      fontFamily: 'Outfit',
      fontWeight: FontWeight.w600,
      height: 38 / 30,
      color: Colors.black,
      letterSpacing: 0,
      fontStyle: FontStyle.normal,
    );

    textTheme = textTheme.copyWith(
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: bodySmall,
      labelLarge: labelLarge,
      labelSmall: labelSmall,
    );

    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(
        color: MyColors.divider.withOpacity(0.2),
        width: 1,
      ),
    );

    return ThemeData(
      fontFamily: 'Outfit',
      scaffoldBackgroundColor: Colors.white,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: primaryColor.withOpacity(0.3),
        selectionHandleColor: primaryColor,
      ),
      primaryColor: primaryColor,
      indicatorColor: primaryColor,
      canvasColor: Colors.white,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
      typography: typography,
      cardTheme: CardTheme(
        elevation: 0,
        margin: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        clipBehavior: Clip.antiAlias,
      ),
      appBarTheme: AppBarTheme(
        elevation: 4,
        titleSpacing: 0,
        centerTitle: false,
        backgroundColor: Colors.white,
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
          statusBarColor: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        titleTextStyle: titleLarge.copyWith(color: Colors.black, fontSize: 18),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      buttonTheme: ButtonThemeData(
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.all(16),
        buttonColor: primaryColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          textStyle: labelLarge,
          fixedSize: const Size(140, 50),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: MyColors.primaryColor,
          padding: EdgeInsets.zero,
          textStyle: bodyLarge.copyWith(fontSize: 14),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: MyColors.primaryColor),
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(width: 1, color: MyColors.primaryColor),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          textStyle: labelLarge.copyWith(height: 1, fontSize: 14),
          fixedSize: const Size(140, 50),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: const BorderSide(color: MyColors.divider, width: 1),
        ),
        elevation: 0,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        iconSize: 22,
        elevation: 0,
        disabledElevation: 0,
      ),
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.all(15),
        filled: false,
        hintStyle: bodySmall.copyWith(
          fontSize: 14,
          color: Colors.black.withOpacity(0.5),
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        labelStyle: titleMedium.copyWith(color: Colors.black.withOpacity(0.7)),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      iconTheme: const IconThemeData(color: Colors.black, size: 24),
      dividerTheme: const DividerThemeData(
        thickness: 1,
        space: 1,
        // color: MyColors.divider,
      ),
      checkboxTheme: CheckboxThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        splashRadius: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
        side: MaterialStateBorderSide.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return const BorderSide(width: 2, color: MyColors.primaryColor);
          }
          return const BorderSide(width: 2, color: Colors.grey);
        }),
        checkColor: MaterialStateProperty.all(MyColors.primaryColor),
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return Colors.white;
          }
          return const Color(0xFFFFFFFF);
        }),
        overlayColor: MaterialStateProperty.all(const Color(0xFFFFFFFF)),
      ),
      radioTheme: RadioThemeData(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          } else {
            return const Color(0xFFB5B5B5);
          }
        }),
      ).copyWith(
        fillColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return primaryColor;
          }
          return null;
        }),
      ),
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return MyColors.primaryColor;
          }
          return null;
        }),
        trackColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return null;
          }
          if (states.contains(MaterialState.selected)) {
            return MyColors.primaryColor;
          }
          return null;
        }),
      ),
      chipTheme: ChipThemeData(
        elevation: 3,
        backgroundColor: Colors.white,
        disabledColor: Colors.grey,
        selectedColor: MyColors.primaryColor.withOpacity(0.3),
        secondarySelectedColor: MyColors.primaryColor.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: const StadiumBorder(),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryColor,
        activeTickMarkColor: primaryColor,
        thumbColor: primaryColor,
        inactiveTrackColor: primaryColor.withOpacity(.2),
      ),
      tabBarTheme: TabBarTheme(
        indicatorSize: TabBarIndicatorSize.tab,
        // labelColor: MyColors.accentColor3,
        unselectedLabelColor: Colors.black.withOpacity(0.7),
        labelStyle: titleLarge.copyWith(
          fontWeight: FontWeight.w700,
          // color: MyColors.accentColor3,
          // fontSize: 14,
        ),
        unselectedLabelStyle: bodySmall.copyWith(
          fontWeight: FontWeight.w400,
          // fontSize: 14,
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        secondary: primaryColor,
        onSecondary: Colors.white,
        brightness: Brightness.light,
        background: Colors.white,
      ).copyWith(
        background: Colors.white,
      ),
    );
  }

  static Color primaryColor = MyColors.primaryColor;
}
