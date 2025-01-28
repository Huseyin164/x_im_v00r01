import 'package:x_im_v00r01/feature/storyy/view/storyy_view.dart';
import 'package:x_im_v00r01/feature/storyy/view_model/storyy_view_model.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

// manage your home view screen
mixin StoryViewMixin on BaseState<StoryyView> {
  @override
  late final ProductNetworkManager productNetworkManager;
  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final StoryyViewModel storyyViewModel;

  @override
  void initState() {
    // TODO: implement activate
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    storyyViewModel = StoryyViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
  }
}
