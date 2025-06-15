/* import 'package:flutter/material.dart';
import 'package:x_im_v00r01/feature/navigation/view/navigation_view.dart';
import 'package:x_im_v00r01/feature/navigation/view_model/Navigation_view_model.dart';
import 'package:x_im_v00r01/product/service/login_service.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

// manage your home view screen
mixin NavigationViewMixin on State<NavigationView> {
  @override
  late final ProductNetworkManager productNetworkManager;
  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final NavigationViewModel navigationViewModel;

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    navigationViewModel = NavigationViewModel(
      operationService: LoginService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
  }
}
 */