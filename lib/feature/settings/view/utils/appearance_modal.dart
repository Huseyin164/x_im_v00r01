import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:x_im_v00r01/feature/settings/view_model/settings_view_model.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/state/view_model/product_view_model.dart';

void showAppearanceModal(
  BuildContext context,
  ThemeData theme,
  String current,
  SettingsViewModel settingsViewModel,
) {
  showModalBottomSheet<Container>(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16),
        height: 320,
        decoration: BoxDecoration(
          color: context.watch<ProductViewModel>().state.themeMode ==
                  ThemeMode.dark
              ? Colors.grey.shade900
              : Colors.grey.shade200,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'settings.appearance.showModal'.tr(),
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 32),
            ListTile(
              leading: const Icon(
                Icons.brightness_5,
                color: Colors.blue,
              ),
              title: Text(
                'settings.light'.tr(),
                style: theme.textTheme.bodyLarge,
              ),
              onTap: () {
                settingsViewModel.userCacheOperation.put(
                  'themeMode',
                  UserCacheModel(themeMode: ThemeMode.light),
                );
                context
                    .read<ProductViewModel>()
                    .changeThemeMode(ThemeMode.light);
                Navigator.pop(context);
              },
              trailing: Icon(
                Icons.check,
                color: current == 'Light' ? Colors.blue : Colors.transparent,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.brightness_2,
                color: Colors.orange,
              ),
              title: Text(
                'settings.dark'.tr(),
                style: theme.textTheme.bodyLarge,
              ),
              onTap: () {
                settingsViewModel.userCacheOperation.put(
                  'themeMode',
                  UserCacheModel(themeMode: ThemeMode.dark),
                );
                context
                    .read<ProductViewModel>()
                    .changeThemeMode(ThemeMode.dark);
                Navigator.pop(context);
              },
              trailing: Icon(
                Icons.check,
                color: current == 'Dark' ? Colors.orange : Colors.transparent,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.brightness_6,
                color: Colors.blueGrey,
              ),
              title: Text(
                'settings.system'.tr(),
                style: theme.textTheme.bodyLarge,
              ),
              onTap: () {
                settingsViewModel.userCacheOperation.put(
                  'themeMode',
                  UserCacheModel(themeMode: ThemeMode.system),
                );
                final themeModeSystem = context
                    .read<ProductViewModel>()
                    .getPlatformBrightness(context);
                context.read<ProductViewModel>().changeThemeMode(
                      themeModeSystem,
                    );
                Navigator.pop(context);
              },
              trailing: Icon(
                Icons.check,
                color:
                    current == 'System' ? Colors.blueGrey : Colors.transparent,
              ),
            ),
          ],
        ),
      );
    },
  );
  return;
}
