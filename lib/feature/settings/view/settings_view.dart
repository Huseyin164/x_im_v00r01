import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/settings/view/mixin/settings_view_mixin.dart';
import 'package:x_im_v00r01/feature/settings/view/utils/appearance_modal.dart';
import 'package:x_im_v00r01/feature/settings/view/utils/language_modal.dart';
import 'package:x_im_v00r01/feature/settings/view/widget/login_signup_widget.dart';
import 'package:x_im_v00r01/feature/settings/view/widget/single_choice.dart';
import 'package:x_im_v00r01/feature/settings/view_model/settings_view_model.dart';
import 'package:x_im_v00r01/feature/settings/view_model/state/settings_state.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/view_model/product_view_model.dart';

@RoutePage()
class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends BaseState<SettingsView>
    with SettingsViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => settingsViewModel,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 100,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Text(
                  'settings.title'.tr(),
                  style: context.general.textTheme.headlineSmall,
                ),
              ),
            ),
          ];
        },
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'settings.account.title'.tr(),
                      style: context.general.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 16),
      
                    /// This is where the login/signup widget is placed
                    BlocSelector<SettingsViewModel, SettingsState, User?>(
                      selector: (state) =>
                          state.user, // Sadece user değişimlerini dinler
                      builder: (context, user) {
                        return LoginSignupWidget(
                          avatarURL: user?.avatar_url ?? '',
                          fullName: user?.full_name,
                        );
                      },
                    ),
      
                    const SizedBox(height: 16),
      
                    Text(
                      'settings.title'.tr(),
                      style: context.general.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w400),
                    ),
      
                    const SizedBox(height: 16),
      
                    BlocBuilder<SettingsViewModel, SettingsState>(
                      builder: (contextAppearance, dynamic) {
                        return _buildListTile(
                          'settings.appearance.title'.tr(),
                          Icons.dark_mode,
                          capitalizeLanguageName(context),
                          Colors.purple,
                          context.watch<ProductViewModel>().state.themeMode,
                          onTab: () => showAppearanceModal(
                            context,
                            context.general.appTheme,
                            capitalizeThemeModeName(context),
                            settingsViewModel,
                          ),
                        );
                        // return Text(_.theme);
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<SettingsViewModel, SettingsState>(
                      builder: (contextLanguage, state) {
                        return _buildListTile(
                          'settings.language.title'.tr(),
                          Icons.language,
                          context.locale.languageCode.toUpperCase(),
                          Colors.orange,
                          context.general.appTheme,
                          onTab: () => showLanguageModal(
                            context,
                            context.general.appTheme,
                            context.locale.languageCode.toUpperCase(),
                            settingsViewModel,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 8),
                    _buildListTile(
                      'settings.notifications.title'.tr(),
                      Icons.notifications_outlined,
                      '',
                      Colors.blue,
                      context.general.appTheme,
                      onTab: () {},
                    ),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color.fromARGB(255, 90, 81, 216)
                              .withAlpha(30),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.text_fields_rounded,
                            color: Color.fromARGB(255, 90, 81, 216),
                          ),
                        ),
                      ),
                      title: Text('settings.textSize'.tr()),
                      trailing: const SizedBox(
                        width: 190,
                        height: 34,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SingleChoice(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildListTile(
                      'settings.legal.title'.tr(),
                      Icons.gavel,
                      '',
                      Colors.blue,
                      context.general.appTheme,
                      onTab: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildListTile(
                      'settings.rateApp'.tr(),
                      Icons.star,
                      '',
                      Colors.yellow,
                      context.general.appTheme,
                      onTab: () {},
                    ),
                    const SizedBox(height: 8),
                    _buildListTile(
                      'settings.help'.tr(),
                      Icons.help,
                      '',
                      Colors.green,
                      context.general.appTheme,
                      onTab: launchEmail,
                    ),
                  ],
                ),
                Text(
                  '${'general.dialog.version.title'.tr()} 1.0.0',
                  style: context.general.appTheme.textTheme.bodyMedium
                      ?.copyWith(color: Colors.grey.shade500),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(
    String title,
    IconData icon,
    String trailing,
    Color color,
    theme, {
    VoidCallback? onTab,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        width: 34,
        height: 34,
        decoration:
            BoxDecoration(shape: BoxShape.circle, color: color.withAlpha(30)),
        child: Center(
          child: Icon(
            icon,
            color: color,
          ),
        ),
      ),
      title: Text(title, style: context.general.textTheme.bodyMedium),
      trailing: SizedBox(
        width: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              trailing,
              style: context.general.appTheme.textTheme.bodySmall
                  ?.copyWith(color: Colors.grey.shade600),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
          ],
        ),
      ),
      onTap: onTab,
    );
  }
}
