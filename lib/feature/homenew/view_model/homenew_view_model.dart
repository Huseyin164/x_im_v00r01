import 'dart:async';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
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
            isLoading: false,
            opacity: 0.00001,
            imageHeight: 250,
            data: [
              {
                'name': 'Acun Ilıcalı',
                'birth_date': '1969-05-29',
                'photo_url': '',
                'story': 'Acun Story',
                'title': 'Story of Acun',
              },
              {
                'name': 'Acun Ilıcalı',
                'birth_date': '1969-05-29',
                'photo_url': '',
                'story': 'Acun Story',
                'title': 'Story of Acun',
              }
            ],
          ),
        );

  final ProjectOperation _projectOperationService;
  final HiveCacheOperation<UserCacheModel> userCacheOperation;
  final PageController pageController;

  EdgeInsets dynamicPadding = const EdgeInsets.only(left: 8, right: 8, top: 20);

  /// Change loading states
  void changeLoading() {
    emit(state.copyWith(isLoading: !state.isLoading));
  }

  Future<bool> fetchUsers() async {
    final response = await _projectOperationService.denemeusers();

    emit(state.copyWith(content: response?.content));

    return true;
  }

  void favoritesButtton() {}


  void setData(List<Map<String, dynamic>>? data) {
    emit(
      state.copyWith(
        data: data,
        isLoading: true,
      ),
    );
  }

  void setImageHeight(double imageHeight, double screenHeight) {
    if (imageHeight > screenHeight) {
      emit(
        state.copyWith(
          imageHeight: screenHeight * 0.6,
          isLoading: true,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        imageHeight: imageHeight,
        isLoading: true,
      ),
    );
  }

  void increaseFav() {}
}
