import 'package:x_im_v00r01/feature/favorites/view/favorites_view.dart';
import 'package:x_im_v00r01/feature/favorites/view_model/favorites_view_model.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

mixin FavoritesViewMixin on BaseState<FavoritesView> {
  late final ProductNetworkErrorManager productNetworkErrorManager;
  late final FavoritesViewModel favoritesViewModel;

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    favoritesViewModel = FavoritesViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );

  }
}
