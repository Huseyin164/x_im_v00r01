import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:widgets/widgets.dart';
import 'package:x_im_v00r01/product/widget/button/loading_button.dart';
import 'package:x_im_v00r01/product/widget/button/normal_button.dart';

part 'custom_login_button_mixin.dart';

final class CustomLoginButton extends StatefulWidget {
  // ignore: public_member_api_docs
  const CustomLoginButton({
    required this.onOperation,
    required this.title,
    this.icon,
    super.key,
  });
  final AsyncValueGetter<bool> onOperation;
  final String title;
  final Widget? icon;

  @override
  State<CustomLoginButton> createState() => _CustomLoginButtonState();
}

class _CustomLoginButtonState extends State<CustomLoginButton>
    with MountedMixin, _CustomLoginButtonMixin {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _isLoadingNotifier,
      builder: (BuildContext context, bool value, Widget? child) {
        if (value) {
          return SizedBox(
            width: context.general.mediaSize.width / 2.7,
            child: LoadingButton(
              onPressed: () {},
            ),
          );
        }
        return SizedBox(
          width: context.general.mediaSize.width / 2.7,
          child: NormalButton(
            title: widget.title,
            icon: widget.icon,
            onPressed: () async {
              await _onPressed(context);
            },
          ),
        );
      },
    );
  }
}
