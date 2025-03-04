import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:x_im_v00r01/feature/onboardings/view/onboardings_view.dart';
import 'package:x_im_v00r01/feature/onboardings/view/widget/onboardingpages.dart';
import 'package:x_im_v00r01/feature/onboardings/view_model/onboardings_view_model.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

// manage your home view screen
mixin OnboardingsViewMixin on BaseState<OnboardingsView> {
  @override
  late final ProductNetworkManager productNetworkManager;
  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final OnboardingsViewModel onboardingsViewModel;

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    onboardingsViewModel = OnboardingsViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
      pageController: PageController(),
    );
  }

  final List<OnboardingPage> onboardingPages = [
    OnboardingPage(
      title: 'onboardings.step1.title'.tr(),
      description: 'onboardings.step1.content'.tr(),
      imageAsset: Assets.lottie.onboardscreen1.lottie(
        package: 'gen',
      ),
      titlePosition: 'top',
    ),
    OnboardingPage(
      title: 'onboardings.step2.title'.tr(),
      description: 'onboardings.step2.content'.tr(),
      imageAsset: Assets.lottie.onboardscreen2.lottie(
        package: 'gen',
      ),
      titlePosition: 'bottom',
    ),
    OnboardingPage(
      title: 'onboardings.step3.title'.tr(),
      description: 'onboardings.step3.content'.tr(),
      imageAsset: Assets.lottie.onboardscreen3.lottie(
        package: 'gen',
      ),
      titlePosition: 'top',
    ),
    OnboardingPage(
      title: 'onboardings.step4.title'.tr(),
      description: 'onboardings.step4.content'.tr(),
      imageAsset: Assets.lottie.onboardscreen4.lottie(
        package: 'gen',
      ),
      titlePosition: 'top',
    ),
  ];
}
