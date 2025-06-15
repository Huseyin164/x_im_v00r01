import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ltr;

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
  }
/* 
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Fetch data when the widget is built
    fetchData();
  } */

  Future<List> fetchData() async {
    try {
      // Veriyi çek
      final data = await supabaseClient
          .from('daily_stories')
          .select()
          .order('created_at')
          .then(
        (data) {
          print('Fetched data: $data');

          if (data.isNotEmpty) {
            homenewViewModel.setData(data);
            loadImageHeight(1, data: data);
            return data;
          } else {
            print('Uyarı: daily_stories tablosu boş.');

            return [];
          }
        },
      );
      return data;
    } catch (e, stackTrace) {
      print('fetchData hatası: $e');
      print('StackTrace: $stackTrace');
      // Hata loglaması veya kullanıcıya gösterilecek hata mesajı eklenebilir
      return [];
    }
  }

  Future<List> fetchStoryIdData(String storyId) async {
    try {
      if (storyId.startsWith('homepage') || storyId.startsWith(':storyId'))
        return [];
      // Veriyi çek
      final data = await supabaseClient
          .from('daily_stories')
          .select()
          .eq('id', storyId)
          .order('created_at')
          .then(
        (data) {
          print('Fetched data: $data');

          if (data.isNotEmpty) {
            homenewViewModel.setData(data);
            loadImageHeight(1, data: data);
            return data;
          } else {
            print('Uyarı: daily_stories tablosu boş.');

            return [];
          }
        },
      );
      return data;
    } catch (e, stackTrace) {
      print('fetchData hatası: $e');
      print('StackTrace: $stackTrace');
      // Hata loglaması veya kullanıcıya gösterilecek hata mesajı eklenebilir
      return [];
    }
  }

  Future<void> fetchFavCount(String storyId) async {
    try {
      await supabaseClient
          .from('story_favorite_counts')
          .select()
          .eq('story_id', storyId)
          .then(
            (res) => (res as List).isNotEmpty
                ? res.first['favorite_count'] as int?
                : null,
          )
          .then((count) {
        if (count == null) return homenewViewModel.setfavCount(0);
        print('setfavCount: $count');
        homenewViewModel.setfavCount(count);
      });
    } catch (e) {
      print('fetchFavCount hatası: $e');
    }
  }

  double calculateTextHeight(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: context.general.textTheme.headlineSmall,
      ),
      textDirection: ltr.TextDirection.ltr,
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
