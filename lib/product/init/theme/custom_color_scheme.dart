import 'package:flutter/material.dart';
import 'package:gen/gen.dart';

final class CustomColorScheme {
  CustomColorScheme._();

  static ColorScheme lightColorScheme = const ColorScheme.light(
    primary: Color(0xff415f91),
    surfaceTint: Color(0xff415f91),
    primaryContainer: Color(0xffd6e3ff),
    onPrimaryContainer: Color(0xff001b3e),
    secondary: Color(0xff565f71),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffdae2f9),
    onSecondaryContainer: Color(0xff131c2b),
    tertiary: Color(0xff705575),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xfffad8fd),
    onTertiaryContainer: Color(0xff28132e),
    error: ColorName.crimsonRed,
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff410002),
    surface: Color(0xfff9f9ff),
    onSurface: Color(0xff191c20),
    onSurfaceVariant: Color(0xff44474e),
    outline: Color(0xff74777f),
    outlineVariant: Color(0xffc4c6d0),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff2e3036),
    inversePrimary: Color(0xffaac7ff),
    primaryFixed: Color(0xffd6e3ff),
    onPrimaryFixed: Color(0xff001b3e),
    primaryFixedDim: Color(0xffaac7ff),
    onPrimaryFixedVariant: Color(0xff284777),
    secondaryFixed: Color(0xffdae2f9),
    onSecondaryFixed: Color(0xff131c2b),
    secondaryFixedDim: Color(0xffbec6dc),
    onSecondaryFixedVariant: Color(0xff3e4759),
    tertiaryFixed: Color(0xfffad8fd),
    onTertiaryFixed: Color(0xff28132e),
    tertiaryFixedDim: Color(0xffddbce0),
    onTertiaryFixedVariant: Color(0xff573e5c),
    surfaceDim: Color(0xfff9f9ff),
    surfaceBright: Color(0xffd9d9e0),
    surfaceContainerLowest: Color(0xffffffff),
    surfaceContainerLow: Color(0xfff3f3fa),
    surfaceContainer: Color(0xffededf4),
    surfaceContainerHigh: Color(0xffe7e8ee),
    surfaceContainerHighest: Color(0xffe2e2e9),
  );

  static ColorScheme darkColorScheme = const ColorScheme.dark(
    
    primary: Color(0xffaac7ff),
    surfaceTint: Color(0xffaac7ff),
    onPrimary: Color(0xff0a305f),
    primaryContainer: Color(0xff284777),
    onPrimaryContainer: Color(0xffd6e3ff),
    secondary: Color(0xffbec6dc),
    onSecondary: Color(0xff283141),
    secondaryContainer: Color(0xff3e4759),
    onSecondaryContainer: Color(0xffdae2f9),
    tertiary: Color(0xffddbce0),
    onTertiary: Color(0xff3f2844),
    tertiaryContainer: Color(0xff573e5c),
    onTertiaryContainer: Color(0xfffad8fd),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffdad6),
    surface: Color(0xff111318),
    onSurface: Color(0xffe2e2e9),
    onSurfaceVariant: Color(0xffc4c6d0),
    outline: Color(0xff8e9099),
    outlineVariant: Color(0xff44474e),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xffe2e2e9),
    inversePrimary: Color(0xff415f91),
    primaryFixed: Color(0xffd6e3ff),
    onPrimaryFixed: Color(0xff001b3e),
    primaryFixedDim: Color(0xffaac7ff),
    onPrimaryFixedVariant: Color(0xff284777),
    secondaryFixed: Color(0xffdae2f9),
    onSecondaryFixed: Color(0xff131c2b),
    secondaryFixedDim: Color(0xffbec6dc),
    onSecondaryFixedVariant: Color(0xff3e4759),
    tertiaryFixed: Color(0xfffad8fd),
    onTertiaryFixed: Color(0xff28132e),
    tertiaryFixedDim: Color(0xffddbce0),
    onTertiaryFixedVariant: Color(0xff573e5c),
    surfaceDim: Color(0xff111318),
    surfaceBright: Color(0xff37393e),
    surfaceContainerLowest: Color(0xff0c0e13),
    surfaceContainerLow: Color(0xff191c20),
    surfaceContainer: Color(0xff1d2024),
    surfaceContainerHigh: Color(0xff282a2f),
    surfaceContainerHighest: Color(0xff33353a),
  );
}
// onSurface: Color(0xffe2e2e9)  
// Açıklama: Genel olarak metin rengi olarak kullanılır.  
// Kullanım Alanı: "Skip" butonu ve onboarding sayfasındaki başlık (title) ve içerik (content) metinleri bu rengi kullanır.


// surface: Color(0xff111318)  
// Açıklama: Arka plan (background) rengi olarak kullanılır.  
// Kullanım Alanı: Onboarding ekranlarının genel arka plan rengi bu renktir.


// onPrimaryContainer: Color(0xffd6e3ff)  
// Açıklama: "Primary Container" renginin üzerindeki metin rengi olarak kullanılır.  
// Kullanım Alanı: Floating Action Button (FAB) içindeki "Next" (İlerle) butonunun metin rengi olarak kullanılır.