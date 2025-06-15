import 'package:x_im_v00r01/feature/bos_yeniEkranAcmakIcic/view/name_view.dart';
import 'package:x_im_v00r01/feature/bos_yeniEkranAcmakIcic/view_model/name_view_model.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

mixin NameViewMixin on BaseState<NameView> {
  late final ProductNetworkErrorManager productNetworkErrorManager;
  late final NameViewModel nameViewModel;

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    nameViewModel = NameViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
    );
  }
}
