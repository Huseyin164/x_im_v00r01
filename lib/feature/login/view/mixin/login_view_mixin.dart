import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_im_v00r01/feature/login/view/login_view.dart';
import 'package:x_im_v00r01/feature/login/view_model/login_view_model.dart';
import 'package:x_im_v00r01/product/init/config/app_environment.dart';
import 'package:x_im_v00r01/product/navigation/deeplink/app_router.dart';
import 'package:x_im_v00r01/product/service/login_service.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

mixin LoginViewMixin on BaseState<LoginView> {

  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final LoginViewModel loginViewModel;

  @override
  void initState() {
    super.initState();

    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    loginViewModel = LoginViewModel(
      operationService: LoginService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
    //_initializeAsyncWork();
  }

  // if (await loginViewModel.tokenCheck()) {
  //   context.router.navigate(const HomenewRoute());
  // }
  Future<void> _initializeAsyncWork() async {
    // Token doğrulama işlemi
    final isValid = await loginViewModel.tokenCheck();

    if (isValid) {
      if (!mounted) return;
      await context.router.navigate(const NavigationRoute());
    }
    // Token geçersizse başka bir sayfaya yönlendirme yapılabilir
    if (!isValid) {
      if (!mounted) return;
      await context.router.navigate(const LoginRoute());
    }
  }

  Future<bool> googleSignIn(BuildContext context) async {
    final webClientId = AppEnvironmentItems.webclientID.value;

    /// iOS Client ID that you registered with Google Cloud.
    //const iosClientId = 'my-ios.apps.googleusercontent.com';

    // Google sign in on Android will work without providing the Android
    // Client ID registered on Google Cloud.

    final googleSignIn = GoogleSignIn(
      // clientId: iosClientId,
      serverClientId: webClientId,
    );

    final googleUser = await googleSignIn.signIn();

    final googleAuth = await googleUser!.authentication;

    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw Exception('No Access Token found.');
    }
    if (idToken == null) {
      throw Exception('No ID Token found.');
    }

    if (!context.mounted) return true;
    await supabaseClient.auth
        .signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    )
        .then(
      (value) {
        print('object');
        print('Google sign-in successful');

        if (!context.mounted) return true;
        context.router.popUntilRoot();

        // SnackBar ile kullanıcıya bilgi verme
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('snackbar.successfulSignIN'.tr())),
        );
      },
    );

    return true;
  }
}
