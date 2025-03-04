import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';

final class UserCacheModel with CacheModel {
  UserCacheModel({
    this.user,
    this.isFirstTime,
    this.themeMode,
    this.language,
    this.selectedTextSize,
    this.fontSize,

  });

  UserCacheModel.empty()
      : user = LoginResponseModel2(),
        isFirstTime = true,
        themeMode = null,
        language = null,
        selectedTextSize = null,
        fontSize = 12.0;

  final LoginResponseModel2? user;
  final bool? isFirstTime; // Opsiyonel alan
  final ThemeMode? themeMode;
  final Locale? language;
  final List<bool>? selectedTextSize;
  final double? fontSize;


  @override
  UserCacheModel fromDynamicJson(dynamic json) {
    final jsonMap = json as Map<String, dynamic>?;
    if (jsonMap == null) {
      CustomLogger.showError<LoginResponseModel2>('Json cannot be null');
      return this;
    }
    return copyWith(
      user: LoginResponseModel2.fromJson(jsonMap),
      isFirstTime: jsonMap['isFirstTime'] as bool?, // isFirstTime'ı al!
      themeMode: _stringToThemeMode(jsonMap['themeMode'] as String?),
      language: jsonMap['language'] != null
          ? Locale(jsonMap['language'].toString())
          : null,
      selectedTextSize: (jsonMap['selectedTextSize'] as List<dynamic>?)
          ?.map((e) => e as bool)
          .toList(),
      fontSize: jsonMap['fontSize'] as double?,

    );
  }

  @override
  String get id => user?.user?.id.toString() ?? '';

  @override
  Map<String, dynamic> toJson() {
    return {
      ...(user ?? LoginResponseModel2()).toJson(),
      'isFirstTime': isFirstTime,
      'themeMode': themeMode.toString().split('.').last,
      'language': language?.languageCode,
      'selectedTextSize': selectedTextSize,
      'fontSize': fontSize,

    };
  }

  UserCacheModel copyWith({
    LoginResponseModel2? user,
    bool? isFirstTime,
    ThemeMode? themeMode,
    Locale? language,
    List<bool>? selectedTextSize,
    double? fontSize,

  }) {
    return UserCacheModel(
      user: user ?? this.user,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
      selectedTextSize: selectedTextSize ?? this.selectedTextSize,
      fontSize: fontSize ?? this.fontSize,

    );
  }

  /// **Enum String'den ThemeMode'a çevirme**
  ThemeMode? _stringToThemeMode(String? themeModeString) {
    switch (themeModeString) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }
}
