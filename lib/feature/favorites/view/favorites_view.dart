import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/favorites/view/mixin/favorites_view_mixin.dart';
import 'package:x_im_v00r01/feature/favorites/view/widget/favorite_button.dart';
import 'package:x_im_v00r01/feature/favorites/view_model/favorites_view_model.dart';
import 'package:x_im_v00r01/feature/favorites/view_model/state/favorites_state.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

@RoutePage()
class FavoritesView extends StatefulWidget {
  const FavoritesView({super.key});

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends BaseState<FavoritesView>
    with FavoritesViewMixin {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => favoritesViewModel,
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<FavoritesViewModel, FavoritesState>(
            builder: (context, state) {
              final currentLocale = context.locale.languageCode ?? 'en';

              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: 100,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: false,
                      titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                      title: Text(
                        'bottomNavigation.favorites'.tr(),
                        style: context.general.textTheme.headlineSmall,
                      ),
                    ),
                  ),
                  if (state.isLoading ?? false)
                    const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (state.favoriteStories?.isEmpty ?? true)
                    SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.favorite_border,
                              size: 64,
                              color: context.general.colorScheme.primary,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'No favorites yet',
                              style: context.general.textTheme.titleLarge,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Stories you like will appear here',
                              style: context.general.textTheme.bodyMedium
                                  ?.copyWith(
                                color: context.general.colorScheme.onSurface
                                    .withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.all(16),
                      sliver: SliverGrid(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            print(
                              'Favorite Story at index $index: ${state.favoriteStories![index]}',
                            );
                            final story = state.favoriteStories![index];
                            return GestureDetector(
                              onTap: () {
                                productViewModel.changeTabIndex(
                                  0,
                                  context.router,
                                  'story/${state.favoriteStories![index].id}',
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: context.general.colorScheme.surface,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 10,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(16),
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 1,
                                        child: story.photoUrl != null
                                            ? Image.memory(
                                                base64Decode(
                                                  story.photoUrl ?? '',
                                                ),
                                                fit: BoxFit.cover,
                                                errorBuilder: (
                                                  context,
                                                  error,
                                                  stackTrace,
                                                ) {
                                                  return _buildImageError(
                                                    context,
                                                  );
                                                },
                                              )
                                            : _buildImageError(context),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            height: 28, // Matches the fontSize
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    story.translations?[
                                                                    currentLocale]
                                                                ['title']
                                                            as String? ??
                                                        '',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: context.general
                                                        .textTheme.titleMedium
                                                        ?.copyWith(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                                FavoriteButton(
                                                  storyId: story.id ?? '',
                                                  size: 14,
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 2),
                                          if (story.id != null)
                                            Text(
                                              DateFormat.yMMMd()
                                                  .format(DateTime.now()),
                                              style: context
                                                  .general.textTheme.bodySmall
                                                  ?.copyWith(
                                                fontSize: 10,
                                                color: context.general
                                                    .colorScheme.onSurface
                                                    .withOpacity(0.6),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          childCount: state.favoriteStories?.length ?? 0,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildImageError(BuildContext context) {
    return Container(
      color: context.general.colorScheme.primary.withOpacity(0.1),
      child: const Icon(Icons.image_not_supported),
    );
  }
}
