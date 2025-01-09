import 'package:core/core.dart';
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
    await Future.delayed(const Duration(seconds: 5));

    //emit(state.copyWith(users: response));
    return false;
  }
}
