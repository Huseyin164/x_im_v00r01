import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/homenew/view/homenew_view.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/homenew_view_model.dart';
import 'package:x_im_v00r01/product/service/manager/index.dart';
import 'package:x_im_v00r01/product/service/project_service.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

// manage your home view screen
mixin HomenewViewMixin on BaseState<HomenewView> {
  late final ProductNetworkErrorManager productNetworkErrorManager;

  late final HomenewViewModel homenewViewModel;

  final String _imageUrl =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/SteveJobsMacbookAir.JPG/640px-SteveJobsMacbookAir.JPG';

  @override
  void initState() {
    super.initState();
    productNetworkErrorManager = ProductNetworkErrorManager(context);
    ProductStateItems.productNetworkManager.listenErrorState(
      onErrorStatus: productNetworkErrorManager.handleError,
    );
    homenewViewModel = HomenewViewModel(
      operationService: ProjectService(ProductStateItems.productNetworkManager),
      userCacheOperation: ProductStateItems.productCache.userCacheOperation,
      pageController: PageController(),
    );
    fetchData();
  }

  Future<void> fetchData() async {
    final data =
        await supabaseClient.from('daily_stories').select().order('created_at');

    print('data $data');

    homenewViewModel.setData(data);

    await loadImageHeight(1, data: data);
  }

  double calculateTextHeight(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: context.general.textTheme.headlineSmall,
      ),
      textDirection: TextDirection.ltr,
      maxLines: 2, // Kaç satır olabileceğini belirle
    )..layout(
        maxWidth: MediaQuery.of(context).size.width,
      ); // Kenar boşluklarını hesaba kat

    return textPainter.height;
  }

  Future<Map<String, dynamic>> fetchImageHeight(String base64String) async {
    final imageBytes = base64Decode(base64String); // Base64 Decode
    final image = Image.memory(imageBytes);

    final completer = Completer<Map<String, dynamic>>();

    image.image.resolve(ImageConfiguration.empty).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        final height = info.image.height.toDouble();
        completer.complete({'height': height, 'image': image});
      }),
    );

    return completer.future;
  }

  Future<void> loadImageHeight(
    int index, {
    List<Map<String, dynamic>>? data,
  }) async {
    print('index $index');
    await fetchImageHeight(data?.elementAt(index - 1)['photo_url'] as String)
        .then((result) {
      final height = result['height'] as double;
      homenewViewModel.setImageHeight(
        height,
        context.general.mediaSize.height,
      );
    });
  }
}
