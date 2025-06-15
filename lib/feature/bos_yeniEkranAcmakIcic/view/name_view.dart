import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/bos_yeniEkranAcmakIcic/view/mixin/name_view_mixin.dart';
import 'package:x_im_v00r01/feature/bos_yeniEkranAcmakIcic/view_model/name_view_model.dart';
import 'package:x_im_v00r01/feature/bos_yeniEkranAcmakIcic/view_model/state/name_state.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

@RoutePage()
class NameView extends StatefulWidget {
  const NameView({super.key});

  @override
  State<NameView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends BaseState<NameView> with NameViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => nameViewModel,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<NameViewModel, NameState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 100,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        'Favorites',
                        style: context.general.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  // Add your content widgets here
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
