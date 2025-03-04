import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_im_v00r01/product/init/index.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/state/container/product_state_container.dart';
import 'package:x_im_v00r01/product/state/view_model/product_view_model.dart';

final class ProductStateItems {
  const ProductStateItems._();

  static ProductNetworkManager get productNetworkManager =>
      ProductContainer.read<ProductNetworkManager>();

  static ProductViewModel get productViewModel =>
      ProductContainer.read<ProductViewModel>();

  static ProductCache get productCache => ProductContainer.read<ProductCache>();

  static SupabaseClient get supabaseClient =>
      ProductContainer.read<SupabaseClient>();
}
