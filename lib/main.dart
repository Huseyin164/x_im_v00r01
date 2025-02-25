import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widgets/widgets.dart';
import 'package:x_im_v00r01/product/init/application_initialize.dart';
import 'package:x_im_v00r01/product/init/product_localization.dart';
import 'package:x_im_v00r01/product/init/state_initialize.dart';
import 'package:x_im_v00r01/product/navigation/deeplink/app_router.dart';
import 'package:x_im_v00r01/product/state/view_model/product_state.dart';
import 'package:x_im_v00r01/product/state/view_model/product_view_model.dart';

Future<void> main() async {
  await AplicationInitiliaze().make();
  runApp(ProductLocalization(child: const StateInitialize(child: MyApp())));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = MediaQuery.of(context).platformBrightness;
    final width = size.width;
    final height = size.height;
    final widthScale = size.width / 375; // Ekran genişliğine göre ölçek
    final heightScale = size.height / 643; // Ekran yüksekliğine göre ölçek
    print('height: $height, width: $width');
    context.read<ProductViewModel>().screenSize(widthScale, heightScale);
    context.read<ProductViewModel>().themeModeRead();
    context.read<ProductViewModel>().languageModeRead(context);
    final systemLocale = PlatformDispatcher.instance.locale;
    print('system locale: $systemLocale');

    //context.read<ProductViewModel>().userCacheOperation.clear();

    context.read<ProductViewModel>().changeThemeMode(
          (context
                      .read<ProductViewModel>()
                      .userCacheOperation
                      .get('themeMode')
                      ?.themeMode ==
                  ThemeMode.system)
              ? context.read<ProductViewModel>().getPlatformBrightness(context)
              : context
                      .read<ProductViewModel>()
                      .userCacheOperation
                      .get('themeMode')
                      ?.themeMode ??
                  context
                      .read<ProductViewModel>()
                      .getPlatformBrightness(context),
        );

    if (context.read<ProductViewModel>().state.networkStatus ==
        NetworkStatus.disconnected) {
      _appRouter.replaceAll([const NoConnectionRoute()]);
    }

    return MaterialApp.router(
      routerConfig: _appRouter.config(),
      builder: (context, child) {
        return BlocListener<ProductViewModel, ProductState>(
          listener: (context, state) {
            print(state.networkStatus);
            if (state.networkStatus == NetworkStatus.disconnected) {
              _appRouter.replaceAll([const NoConnectionRoute()]);
              return;
            }
          },
          child: CustomResponsive.build(context, child),
        );
      },
      theme: context.watch<ProductViewModel>().state.lightThemeData,
      darkTheme: context.watch<ProductViewModel>().state.darkThemeData,
      themeMode: context.watch<ProductViewModel>().state.themeMode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
