import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:x_im_v00r01/feature/login/view_model/state/login_state.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/service/interface/authenction_operation.dart';
import 'package:x_im_v00r01/product/state/base/base_cubit.dart';

final class LoginViewModel extends BaseCubit<LoginState> {
  /// [AuthenticationOperation] service
  LoginViewModel({
    required AuthenticationOperation operationService,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
  })  : _authenticationOperationService = operationService,
        userCacheOperation = userCacheOperation,
        super(const LoginState(isLoading: false));
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final AuthenticationOperation _authenticationOperationService;
  final HiveCacheOperation<UserCacheModel> userCacheOperation;
  

  /// Change loading state
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<bool> fetchUsers() async {
    final response = await _authenticationOperationService.users();

    emit(state.copyWith(users: response));
    return !response.isNotEmpty;
  }
  

  Future<bool> buttonloading() async {
    final response = await _authenticationOperationService.inlogin(
      emailController.text,
      passwordController.text,
    );

    print('${emailController.text}, ${passwordController.text}');

    if (response == null) {
      // Handle error case
      return false;
    }
    //await Future.delayed(const Duration(seconds: 5));

    //emit(state.copyWith(users: response));

    userCacheOperation.put('1', UserCacheModel(user: response));

    emit(state.copyWith(model: response));

    return true;
  }

  Future<bool> tokenCheck() async {
    final model = userCacheOperation.get(
      '1',
    );
    final response = await _authenticationOperationService
        .tokencheck(model?.user?.token?.token ?? '');

    if (response?.name != null && model != null) {
      emit(state.copyWith(model: model.user));

      return true;
    }

    return false;
  }
}
