import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/login/view/mixin/login_view_mixin.dart';
import 'package:x_im_v00r01/feature/login/view/widget/uizard_text_form.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/view_model/product_view_model.dart';
import 'package:x_im_v00r01/product/widget/button/custom_login/custom_login_button.dart';

void showLoginModal(BuildContext context) {
  showModalBottomSheet<LoginView>(
    useSafeArea: true,
    context: context,
    isScrollControlled: true, // Modalın yüksekliğini kontrol edebilmek için
    builder: (context) {
      return const LoginView();
    },
  );
}

@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> with LoginViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginViewModel,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: context.general.mediaSize.height * 0.8,
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
          mainAxisSize: MainAxisSize.min, // İçeriğe göre boyut alır
          children: [
            Text(
              'XDBM Life Stories',
              style: context.general.textTheme.headlineMedium,
            ),
            const SizedBox(height: 10),
            Text(
              'Discover inspiring life journey',
              style: context.general.textTheme.bodySmall,
            ),
            const SizedBox(height: 24),
            UizardTextForm(
              label: 'Email',
              controller: loginViewModel.emailController,
              obscure: false,
            ),
            const SizedBox(height: 20),
            UizardTextForm(
              label: 'Password',
              controller: loginViewModel.passwordController,
              obscure: true,
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: context.general.mediaSize.width,
              child: CustomLoginButton(
                onOperation: loginViewModel.buttonloading,
                title: 'Login',
              ),
            ),
            Row(
              children: [
                SizedBox(
                  height: 20,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      overlayColor: WidgetStateProperty.all(Colors.transparent),
                      alignment: Alignment.centerLeft,
                      padding: WidgetStateProperty.all(EdgeInsets.zero),
                      minimumSize: WidgetStateProperty.all(const Size(0, 16)),
                    ),
                    child: Text(
                      'Forgot your password ?',
                      style: context.general.textTheme.labelSmall
                          ?.copyWith(color: Colors.red),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 37),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 141,
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('or'),
                ),
                SizedBox(
                  width: 141,
                  child: Divider(thickness: 1, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomLoginButton(
                  onOperation: loginViewModel.buttonloading,
                  title: 'Facebook',
                  icon: Assets.icons.facebook.svg(
                    package: 'gen',
                    width: 25,
                  ),
                ),
                const SizedBox(width: 13),
                CustomLoginButton(
                  onOperation: () => googleSignIn(context),
                  title: 'Google',
                  icon: Assets.icons.google.svg(
                    package: 'gen',
                    width: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
