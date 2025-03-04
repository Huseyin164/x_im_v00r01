import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:x_im_v00r01/feature/settings/view_model/state/settings_state.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/service/interface/project_operation.dart';
import 'package:x_im_v00r01/product/state/base/base_cubit.dart';

final class SettingsViewModel extends BaseCubit<SettingsState> {
  /// [ProjectOperation] service
  SettingsViewModel({
    required ProjectOperation operationService,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
  })  : _projectOperationService = operationService,
        userCacheOperation = userCacheOperation,
        super(const SettingsState(isLoading: false));

  final ProjectOperation _projectOperationService;
  final HiveCacheOperation<UserCacheModel> userCacheOperation;

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  void setUserID({String? avatarUrl, String? fullName}) {
    emit(
      state.copyWith(user: User(avatar_url: avatarUrl, full_name: fullName)),
    );
  }

  void themeModePutHive(ThemeMode mode) {
    userCacheOperation.remove('boxthemeMode'); // Önce eski veriyi sil
    // ignore: cascade_invocations
    userCacheOperation.put(
      'boxthemeMode',
      UserCacheModel(
        themeMode: mode,
      ),
    );
  }

  void onboardingPutHive() {
    userCacheOperation..remove('isFirstTime') // Önce eski veriyi sil
    ..put(
      'isFirstTime',
      UserCacheModel(
        isFirstTime: true,
      ),
    );
    final isfirstime = userCacheOperation.get('isFirstTime')?.isFirstTime;
    print('onboardingisfirstime:' '$isfirstime');
  }
}
