import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:x_im_v00r01/feature/settings/view/settings_view.dart';
import 'package:x_im_v00r01/feature/settings/view_model/settings_view_model.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

// manage your home view screen
mixin SettingsViewMixin on BaseState<SettingsView> {
  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final SettingsViewModel settingsViewModel;

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    settingsViewModel = SettingsViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );

    supabaseClient.auth.onAuthStateChange.listen((data) {
      print('data data $data');

      switch (data) {
        case AuthState(
            session: Session(
              user: User(
                userMetadata: {
                  'full_name': final String full,
                  'avatar_url': final String avatarURL
                }
              )
            )
          ):
          print('case ici');
          settingsViewModel.setUserID(avatarUrl: avatarURL, fullName: full);
        case AuthState(event: AuthChangeEvent.signedOut):
          settingsViewModel.setUserID();
        default:
          print('Kullanıcı giriş yapmamış veya metadata eksik.');
      }

      /// avatar_url
      // final fullName =
      //     data.session?.user.userMetadata?['full_name']?.toString();
      // final avatarUrl =
      //     data.session?.user.userMetadata?['avatar_url']?.toString();

      // if (fullName != null || avatarUrl != null) {
      //   settingsViewModel.setUserID(avatarUrl: avatarUrl, fullName: fullName);
      // } else {
      //   print("⚠️ Kullanıcı metadata içinde 'full' bulunamadı!");
      // }
    });
  }

  late String themeModeName;

  String capitalize(String text) {
    if (text.isEmpty) return text;
    return text[0].toUpperCase() + text.substring(1).toLowerCase();
  }

  String capitalizeThemeModeName(BuildContext context) {
    return capitalize(
      (settingsViewModel.userCacheOperation.get('themeMode') ??
              UserCacheModel(themeMode: ThemeMode.system))
          .themeMode
          .toString()
          .split('.')
          .last,
    );
  }

  String capitalizeLanguageName(BuildContext context) {
    themeModeName = capitalize(
      (settingsViewModel.userCacheOperation.get('themeMode') ??
              UserCacheModel(themeMode: ThemeMode.system))
          .themeMode
          .toString()
          .split('.')
          .last,
    );

    if (context.locale.languageCode == 'tr') {
      if (themeModeName == 'System') {
        return 'Sistem';
      } else if (themeModeName == 'Light') {
        return 'Açık';
      } else if (themeModeName == 'Dark') {
        return 'Koyu';
      }
    }
    return themeModeName;
  }

  // E-posta gönderme işlevi
  Future<void> launchEmail() async {
    final emailLaunchUri = Uri.parse(
      'mailto:info_xdbm@gmail.com?subject=Support Request&body=Hello, I need help with...',
    );

    // URL'yi başlatmayı deneyin
    if (!await launchUrl(
      emailLaunchUri,
    )) print('Could not launch email');
  }
}
