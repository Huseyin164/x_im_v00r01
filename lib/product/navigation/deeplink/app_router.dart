import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:x_im_v00r01/feature/discover/view/discover_view.dart';
import 'package:x_im_v00r01/feature/home/view/home_detail_view.dart';
import 'package:x_im_v00r01/feature/home/view/home_view.dart';
import 'package:x_im_v00r01/feature/homenew/view/homenew_view.dart';
import 'package:x_im_v00r01/feature/loading/view/loading_view.dart';
import 'package:x_im_v00r01/feature/login/view/login_view.dart';
import 'package:x_im_v00r01/feature/navigation/view/navigation_view.dart';
import 'package:x_im_v00r01/feature/no_connection/view/no_connection.dart';
import 'package:x_im_v00r01/feature/onboardings/view/onboardings_view.dart';
import 'package:x_im_v00r01/feature/settings/view/settings_view.dart';
import 'package:x_im_v00r01/feature/storyy/view/storyy_view.dart';
import 'package:x_im_v00r01/product/navigation/deeplink/autoguard.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),

        AutoRoute(page: HomeDetailRoute.page),

        AutoRoute(
          page: LoginRoute.page,
          fullscreenDialog: true,
        ),

        AutoRoute(page: HomenewRoute.page),

        AutoRoute(page: DiscoverRoute.page, path: '/discover/:id'),

        AutoRoute(page: SettingsRoute.page),

        AutoRoute(
          page: LoadingRoute.page,
          initial: true,
        ),

        AutoRoute(page: OnboardingsRoute.page),

        AutoRoute(page: NoConnectionRoute.page),

        AutoRoute(
          page: NavigationRoute.page,
          guards: [
            FirstTimeGuard(
              userCacheOperation:
                  ProductStateItems.productCache.userCacheOperation,
            ),
          ],
          children: [
            // ✅ Children ekledik
            AutoRoute(
              page: HomenewRoute.page,
              initial: true,
            ),
            CustomRoute<dynamic>(
              page: DiscoverRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              durationInMilliseconds: 500, // 🔹 Animasyon süresi
            ),
            CustomRoute<dynamic>(
              page: OnboardingsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              durationInMilliseconds: 500, // 🔹 Animasyon süresi
            ),
            CustomRoute<dynamic>(
              page: SettingsRoute.page,
              transitionsBuilder: TransitionsBuilders.fadeIn,
              durationInMilliseconds: 500, // 🔹 Animasyon süresi
            ),
          ],
        ),

        // Add more routes as needed...
      ];
}

/*     List<AutoRoute> get routes => [
        AutoRoute(
          page: HomeRoute.page,
          path: '/home',
          initial: true,
          children: [
            AutoRoute(page: HomeDetailRoute.page, path: 'detail'),
          ],
        ),

        /// routes go here
      ];   */
