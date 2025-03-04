import 'package:auto_route/auto_route.dart';
import 'package:x_im_v00r01/feature/loading/view/loading_view.dart';
import 'package:x_im_v00r01/feature/loading/view_model/loading_view_model.dart';
import 'package:x_im_v00r01/product/navigation/deeplink/app_router.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

// manage your home view screen
mixin LoadingViewMixin on BaseState<LoadingView> {
  @override
  late final ProductNetworkManager productNetworkManager;
  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final LoadingViewModel loadingViewModel;

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    loadingViewModel = LoadingViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
    _initializeAsyncWork();
  }

  Future<void> _initializeAsyncWork() async {
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      context.router.replaceAll([const NavigationRoute()]);
    });
  }
}
