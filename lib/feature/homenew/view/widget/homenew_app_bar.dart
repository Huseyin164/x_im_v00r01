import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class HomenewAppBar extends StatelessWidget {
  const HomenewAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1fHx3b21hbiUyMHdlYXJpbmd8ZW58MXx8fHwxNjUzNTg3NjU1&ixlib=rb-1.2.1&q=80&w=1080',
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            SizedBox(
              height: 48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: context.general.textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    'Furkan Özbek',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
