import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomenewStatusBar extends StatelessWidget {
  const HomenewStatusBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 335,
      height: 118,
      decoration: const BoxDecoration(
        color: Color(0xffd3d3d3),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 24,
          right: 24,
          top: 22,
          bottom: 24,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover extraordinary journeys',
              style: context.general.textTheme.bodySmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Find your inspiration',
              style: context.general.textTheme.bodySmall,
            ),
            const SizedBox(height: 14),
            Container(
              height: 8,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(
                  100,
                ),
              ),
              child: const LinearProgressIndicator(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                valueColor: AlwaysStoppedAnimation<Color>(
                  Color(0xffd3d3d3),
                ),
                backgroundColor: Colors.white,
                value: 0.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
