import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/state/homenew_state.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/service/interface/authenction_operation.dart';
import 'package:x_im_v00r01/product/service/interface/project_operation.dart';
import 'package:x_im_v00r01/product/state/base/base_cubit.dart';

final class HomenewViewModel extends BaseCubit<HomenewState> {
  /// [AuthenticationOperation] service
  HomenewViewModel({
    required ProjectOperation operationService,
    required HiveCacheOperation<UserCacheModel> userCacheOperation,
    required PageController pageController,
  })  : _projectOperationService = operationService,
        userCacheOperation = userCacheOperation,
        pageController = pageController,
        super(
          const HomenewState(
            favCount: 321,
            isLoading: true,
            opacity: 0.00001,
            imageHeight: 250,
            data: [
              {
                'name': 'Acun Ilıcalı',
                'birth_date': '1969-05-29',
                'photo_url': '',
                'story': 'Acun Story',
                'title': 'Story of Acun',
                'birth_place': 'Turkey',
                'translations': {
                  'en': {
                    'title': 'Story of Acun Ilıcalı',
                    'content':
                        'Acun Ilıcalı has achieved great success in the world of television. Starting his career at MTV Turkey, he eventually transformed it into a media empire by purchasing TV8.',
                    'birthPlace': 'Istanbul',
                    'nationality': 'Turkish',
                  },
                  'tr': {
                    'title': 'Acun Ilıcalı Hikayesi',
                    'content':
                        'Acun Ilıcalı televizyon dünyasında büyük başarılara imza atmıştır. MTV Türkiye’de başladığı kariyeri, TV8’i satın alarak büyük bir medya imparatorluğuna dönüşmüştür.',
                    'birthPlace': 'isntanbul',
                    'nationality': 'Türk',
                  },
                },
              },
              {
                'name': 'Acun Ilıcalı',
                'birth_date': '1969-05-29',
                'photo_url': '',
                'story': 'Acun Story',
                'title': 'Story of Acun',
                'birth_place': 'Turkey',
                'translations': {
                  'en': {
                    'title': 'Story of Acun Ilıcalı',
                    'content':
                        'Acun Ilıcalı has achieved great success in the world of television. Starting his career at MTV Turkey, he eventually transformed it into a media empire by purchasing TV8.',
                    'birthPlace': 'Istanbul',
                    'nationality': 'Turkish',
                  },
                  'tr': {
                    'title': 'Acun Ilıcalı Hikayesi',
                    'content':
                        'Acun Ilıcalı televizyon dünyasında büyük başarılara imza atmıştır. MTV Türkiye’de başladığı kariyeri, TV8’i satın alarak büyük bir medya imparatorluğuna dönüşmüştür.',
                    'birthPlace': 'isntanbul',
                    'nationality': 'Türk',
                  },
                },
              },
            ],
          ),
        );

  final ProjectOperation _projectOperationService;
  final HiveCacheOperation<UserCacheModel> userCacheOperation;
  final PageController pageController;

  EdgeInsets dynamicPadding = const EdgeInsets.only(left: 8, right: 8, top: 20);

  /// Change loading states
  void changeLoading(bool isLoading) {
    emit(state.copyWith(isLoading: isLoading));
  }

  Future<bool> fetchUsers() async {
    final response = await _projectOperationService.denemeusers();

    emit(state.copyWith(content: response?.content));

    return true;
  }

  final _supabase = Supabase.instance.client;

  Future<bool> isFavorite(String storyId) async {
    try {
      emit(state.copyWith(isLoadingFavRpc: true));

      final currentFavorites = Map<String, bool>.from(state.favorites);

      final response = await _supabase.rpc<bool>(
        'is_favorite',
        params: {'story_id': storyId},
      ).then<bool>((res) {
        currentFavorites[storyId] = res;

        emit(
          state.copyWith(
            favorites: currentFavorites,
            isLoadingFavRpc: false,
          ),
        );

        return res;
      });

      return response;
    } catch (e) {
      print('Error checking favorite status: $e');
      return false;
    }
  }

  Future<void> toggleFavoriteRPC(String storyId) async {
    try {
      emit(state.copyWith(isLoadingFavRpc: true));

      // Make API call using Supabase RPC
      final response = await _supabase.rpc<Map<String, dynamic>>(
        'favorite_story',
        params: {'p_story_id': storyId},
      ); // If API call fails, revert the optimistic update

      await isFavorite(storyId);
    } catch (e) {
      // Revert optimistic update on error
      final currentFavorites = Map<String, bool>.from(state.favorites);
      currentFavorites[storyId] = !currentFavorites[storyId]!;
      emit(
        state.copyWith(
          favorites: currentFavorites,
          isLoadingFavRpc: false,
        ),
      );

      print('Error toggling favorite: $e');
    }
  }

  void setData(List<Map<String, dynamic>>? data) {
    emit(
      state.copyWith(
        data: data,
      ),
    );
  }

  void setImageHeight(double imageHeight, double screenHeight) {
    if (imageHeight > (screenHeight * 0.6)) {
      emit(
        state.copyWith(
          imageHeight: screenHeight * 0.6,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        imageHeight: imageHeight,
      ),
    );
  }

  void setfavCount(int count) {
    emit(
      state.copyWith(
        favCount: count,
      ),
    );
  }
}
