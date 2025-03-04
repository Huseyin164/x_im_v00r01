import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  const FadeAnimation(this.delay, this.child, {super.key});
  final double delay;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PlayAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1), // 0'dan 1'e opacity animasyonu
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: (500 * delay).round()),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: Transform.translate(
          offset: Offset(0, (1 - value) * 130), // Yukarıdan aşağı hareket
          child: child,
        ),
      ),
      child: child,
    );
  }
}
