import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/init/index.dart';
import 'package:x_im_v00r01/product/state/base/base_cubit.dart';
import 'package:x_im_v00r01/product/state/container/index.dart';
import 'package:x_im_v00r01/product/state/view_model/product_state.dart';

final class ProductViewModel extends BaseCubit<ProductState> {
  ProductViewModel()
      : super(
          const ProductState(),
        ) {
    _monitorConnection();
  }

  int selectedindex = 0;
  HiveCacheOperation<UserCacheModel> userCacheOperation =
      ProductStateItems.productCache.userCacheOperation;

  final Connectivity _connectivity = Connectivity();

  Future<UserCacheModel> getSettings() async {
    final settings = userCacheOperation.get('settings');
    return settings ?? UserCacheModel(user: LoginResponseModel2());
  }

  void _monitorConnection() {
    _connectivity.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.none)) {
        emit(state.copyWith(networkStatus: NetworkStatus.disconnected));
      } else {
        emit(state.copyWith(networkStatus: NetworkStatus.connected));
      }
      print('obsject');
    });
  }

  /// Change theme mode
  /// [themeMode] is [ThemeMode.light] or [ThemeMode.dark]
  void changeThemeMode(ThemeMode themeMode) {
    //print(userCacheOperation.getAll());
    emit(state.copyWith(themeMode: themeMode));
  }

  void setTextSize(double textSize) {
    emit(state.copyWith(fontSize: textSize));
  }

  void screenSize(double widthScale, double heightScale) {
    emit(state.copyWith(widthScale: widthScale));
    emit(state.copyWith(heightScale: heightScale));
  }

  /// Get the current platform brightness
  ThemeMode getPlatformBrightness(BuildContext context) {
    final isDarkMode =
        PlatformDispatcher.instance.platformBrightness == Brightness.dark;

    final selectedTheme = isDarkMode ? ThemeMode.dark : ThemeMode.light;

    return selectedTheme;
  }

  /// Get the current platform locale
  void getPlatformLocale(BuildContext context) {
    final systemLocale = PlatformDispatcher.instance.locale;

    ProductLocalization.updateLanguage(
      context: context,
      value: context
              .read<ProductViewModel>()
              .userCacheOperation
              .get('lang')
              ?.language ??
          systemLocale,
    );
  }

  void themeModeRead() {
    final usercachemodel = userCacheOperation.get('boxthemeMode');
    var thememode = usercachemodel?.themeMode;
    if (thememode == null || thememode == ThemeMode.system) {
      thememode = ThemeMode.system;
      changeThemeMode(thememode);
    } else {
      changeThemeMode(thememode);
    }
  }
}
