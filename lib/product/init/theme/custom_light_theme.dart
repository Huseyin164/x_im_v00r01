import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:x_im_v00r01/product/init/theme/custom_color_scheme.dart';
import 'package:x_im_v00r01/product/init/theme/custom_theme.dart';

/// Custom light theme for project design
final class CustomLightTheme implements CustomTheme {
  //2vb6 16.dakikayı izlersin

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        colorScheme: CustomColorScheme.lightColorScheme,
        floatingActionButtonTheme: floatingActionButtonThemeData,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      );

  TextTheme textTheme(double fontSize) {
    // GoogleFonts.poppinsTextTheme'i kullanarak temel bir textTheme oluşturuyoruz
    final baseTextTheme =
        GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme);

    return baseTextTheme.copyWith(
      titleSmall: baseTextTheme.titleSmall?.copyWith(fontSize: fontSize + 2),
      titleMedium: baseTextTheme.titleMedium?.copyWith(fontSize: fontSize + 4),
      titleLarge: baseTextTheme.titleLarge?.copyWith(fontSize: fontSize + 8),
      bodySmall: baseTextTheme.bodySmall?.copyWith(fontSize: fontSize),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(fontSize: fontSize + 2),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(fontSize: fontSize + 4),
    );
  }

  @override
  FloatingActionButtonThemeData get floatingActionButtonThemeData =>
      const FloatingActionButtonThemeData(
        backgroundColor: Colors.pink,
      );
  //özelleştrimek istediğin komponentin değerlerini gir
}
