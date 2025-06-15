import 'dart:convert';
import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/homenew/view/mixin/homenew_pageBuilder_mixin.dart';
import 'package:x_im_v00r01/feature/homenew/view/widget/home_favorite_button.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/homenew_view_model.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/state/homenew_state.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

class PageBuilderHomenewView extends StatefulWidget {
  const PageBuilderHomenewView({
    super.key,
    this.index = 1,
  });
  final int index;

  @override
  State<PageBuilderHomenewView> createState() => _PageBuilderHomenewState();
}

class _PageBuilderHomenewState extends BaseState<PageBuilderHomenewView>
    with HomenewPageBuilderMixin {
  double calculateTextHeight(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: context.general.textTheme.headlineSmall,
      ),
      textDirection: ui.TextDirection.ltr,
      maxLines: 2, // Kaç satır olabileceğini belirle
    )..layout(
        maxWidth: MediaQuery.of(context).size.width,
      ); // Kenar boşluklarını hesaba kat

    return textPainter.height;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: scrollController,
      slivers: <Widget>[
        BlocSelector<HomenewViewModel, HomenewState,
            (double, String, String, String)>(
          selector: (state) {
            return (
              state.imageHeight ?? 250,
              state.data?.elementAt(widget.index - 1)['photo_url'] ?? '',
              state.data?.elementAt(widget.index - 1)['id'] ?? '',
              formatTarih(
                state.data?.elementAt(widget.index - 1)['created_at'],
              ),
            );
          },
          builder: (context, state) {
            return SliverAppBar(
              elevation: 1,
              expandedHeight: state.$1,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.only(top: 10),
                title: Transform.translate(
                  offset: const Offset(0, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                      color: context.general.colorScheme.surfaceDim,
                    ),
                    child: Transform.translate(
                      offset: const Offset(0, -25),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color:
                                    context.general.colorScheme.surfaceBright,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  state.$4,
                                  style: context.general.textTheme.bodySmall,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                HomeFavoriteButton(
                                  storyId: state.$3,
                                  size: context.general.textTheme.bodySmall!
                                          .fontSize! +
                                      5,
                                  color: context
                                      .general.textTheme.bodySmall?.color,
                                ),
                                IconButton(
                                  onPressed: () {
                                    return;
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    size: context.general.textTheme.bodySmall!
                                            .fontSize! +
                                        5,
                                  ),
                                  style: TextButton.styleFrom(
                                    iconColor: context
                                        .general.textTheme.bodySmall?.color,
                                    minimumSize: const Size(0, 32),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    textStyle:
                                        context.general.textTheme.bodySmall,
                                    foregroundColor: context
                                        .general.textTheme.bodySmall?.color,
                                    backgroundColor: context
                                        .general.colorScheme.surfaceBright,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: MemoryImage(
                        base64Decode(state.$2),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        BlocSelector<HomenewViewModel, HomenewState, String>(
          selector: (state) {
            final currentLocale = context.locale.languageCode ?? 'en';

            final item = state.data?.elementAt(widget.index - 1);
            // `translations` is expected to be a map where keys are locale codes (e.g., 'en', 'fr')
            // and values are maps containing localized data for each locale.
            // Example structure:
            // {
            //   'en': {'title': 'English Title'},
            //   'fr': {'title': 'French Title'}
            // }
            final translations = item?['translations'] as Map<String, dynamic>?;
            final localeData =
                translations?[currentLocale] as Map<String, dynamic>?;
            return localeData?['title'] as String? ?? '';
          },
          builder: (context, state) {
            return SliverLayoutBuilder(
              builder: (context, constraints) {
                // ignore: prefer_final_locals
                textHeight = calculateTextHeight(
                  state,
                );
                // ignore: prefer_final_locals
                expandedHeight = textHeight + 35;

                return SliverAppBar(
                  backgroundColor: context.general.colorScheme.surfaceDim,
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  shadowColor: context.general.colorScheme.surfaceDim,
                  surfaceTintColor: context.general.colorScheme.surfaceDim,
                  foregroundColor: context.general.colorScheme.surfaceDim,
                  automaticallyImplyLeading: false,
                  expandedHeight: expandedHeight,
                  collapsedHeight: 45,
                  toolbarHeight: 0,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Transform.translate(
                      offset: const Offset(0, 5),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: Text(
                          state,
                          style:
                              context.general.textTheme.headlineSmall?.copyWith(
                            height: 1.1,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
        SliverAppBar(
          backgroundColor: context.general.colorScheme.surfaceDim,
          elevation: 0,
          scrolledUnderElevation: 0,
          shadowColor: context.general.colorScheme.surfaceDim,
          surfaceTintColor: context.general.colorScheme.surfaceDim,
          foregroundColor: context.general.colorScheme.surfaceDim,
          automaticallyImplyLeading: false,
          pinned: true,
          title: Row(
            children: [
              TextButton.icon(
                onPressed: () {
                  return;
                },
                // icon: const CircleAvatar(
                //   radius: 12,
                //   backgroundImage: NetworkImage(
                //     'https://m.media-amazon.com/images/M/MV5BMTQ3ODE2NTMxMV5BMl5BanBnXkFtZTgwOTIzOTQzMjE@._V1_.jpg',
                //   ),
                // ),
                label: BlocSelector<HomenewViewModel, HomenewState, String>(
                  selector: (state) {
                    return state.data?.elementAt(widget.index - 1)['name']
                            as String? ??
                        'Text Placeholder';
                  },
                  builder: (context, name) {
                    return Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                style: TextButton.styleFrom(
                  iconColor: context.general.textTheme.bodySmall?.color,
                  minimumSize: const Size(0, 32),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  textStyle: context.general.textTheme.bodySmall,
                  foregroundColor: context.general.colorScheme.onTertiary,
                  backgroundColor: context.general.colorScheme.tertiary,
                ),
              ),
              BlocSelector<HomenewViewModel, HomenewState, String>(
                selector: (state) {
                  return state.data?.elementAt(widget.index - 1)['birth_date']
                      as String;
                },
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      DateFormat.yMMMMd(context.locale.languageCode)
                          .format(DateTime.parse(state)),
                      style: context.general.textTheme.labelMedium,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BlocSelector<HomenewViewModel, HomenewState, String>(
                  selector: (state) {
                    final currentLocale = context.locale.languageCode ?? 'en';

                    final item = state.data?.elementAt(widget.index - 1);
                    // `translations` is expected to be a map where keys are locale codes (e.g., 'en', 'fr')
                    // and values are maps containing localized data for each locale.
                    // Example structure:
                    // {
                    //   'en': {'title': 'English Title'},
                    //   'fr': {'title': 'French Title'}
                    // }
                    final translations =
                        item?['translations'] as Map<String, dynamic>?;
                    final localeData =
                        translations?[currentLocale] as Map<String, dynamic>?;
                    return localeData?['content'] as String? ?? '';
                  },
                  builder: (context, state) {
                    return Text(
                      state,
                      style: const TextStyle(
                        fontSize: 12,
                        height: 1.4,
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Text(
                  'Born',
                  style: context.general.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocSelector<HomenewViewModel, HomenewState, (String, String)>(
                  selector: (state) {
                    final currentLocale = context.locale.languageCode ?? 'en';

                    final item = state.data?.elementAt(widget.index - 1);
                    // `translations` is expected to be a map where keys are locale codes (e.g., 'en', 'fr')
                    // and values are maps containing localized data for each locale.
                    // Example structure:
                    // {
                    //   'en': {'title': 'English Title'},
                    //   'fr': {'title': 'French Title'}
                    // }
                    final translations =
                        item?['translations'] as Map<String, dynamic>?;
                    final localeData =
                        translations?[currentLocale] as Map<String, dynamic>?;
                    return (
                      state.data?.elementAt(widget.index - 1)['birth_date']
                          as String,
                      localeData?['birth_place'] as String? ?? '',
                    );
                  },
                  builder: (context, state) {
                    return Text(
                      '${DateFormat.yMMMMd(context.locale.languageCode).format(DateTime.parse(state.$1))}, ${state.$2}',
                      style: const TextStyle(color: Colors.grey),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Nationality',
                  style: context.general.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocSelector<HomenewViewModel, HomenewState, String>(
                  selector: (state) {
                    final currentLocale = context.locale.languageCode ?? 'en';

                    final item = state.data?.elementAt(widget.index - 1);
                    // `translations` is expected to be a map where keys are locale codes (e.g., 'en', 'fr')
                    // and values are maps containing localized data for each locale.
                    // Example structure:
                    // {
                    //   'en': {'title': 'English Title'},
                    //   'fr': {'title': 'French Title'}
                    // }
                    final translations =
                        item?['translations'] as Map<String, dynamic>?;
                    final localeData =
                        translations?[currentLocale] as Map<String, dynamic>?;
                    return localeData?['nationality'] as String? ??
                        'general.unknown'.tr();
                  },
                  builder: (context, state) {
                    return Text(
                      state,
                      style: const TextStyle(color: Colors.grey),
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Videos',
                  style: context.general.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _makeVideo(
                        image: 'assets/images/emma-1.jpg',
                      ),
                      _makeVideo(
                        image: 'assets/images/emma-2.jpg',
                      ),
                      _makeVideo(
                        image: 'assets/images/emma-3.jpg',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 120,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Widget _makeVideo({required String image}) {
  return AspectRatio(
    aspectRatio: 1.5 / 1,
    child: Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.3),
            ],
          ),
        ),
        child: const Align(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 70,
          ),
        ),
      ),
    ),
  );
}
