import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:x_im_v00r01/feature/homenew/view/homenew_pageBuilder.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

mixin HomenewPageBuilderMixin on BaseState<PageBuilderHomenewView> {
  double textHeight = 50;
  // ignore: prefer_final_locals
  late double expandedHeight;

  final ScrollController scrollController = ScrollController();
  double _mediaSizeHeight = 200; // SliverAppBar'ın başlangıç yüksekliği
  bool isAnimating = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _mediaSizeHeight = MediaQuery.of(context).size.height;

    expandedHeight = textHeight;

    scrollController.addListener(_handleScroll);
  }

  @override
  void initState() {
    super.initState();
  }

  void _handleScroll() {
    if (isAnimating || !scrollController.hasClients) return;

    final offset = scrollController.offset;

    // Responsive eşikler
    final triggerDownStart = _mediaSizeHeight * 0.15;
    final triggerDownEnd = _mediaSizeHeight * 0.18;

    final triggerUpStart = _mediaSizeHeight * 0.6 - 65;
    final triggerUpEnd = _mediaSizeHeight * 0.6 - 50;

    if (offset > triggerDownStart && offset < triggerDownEnd) {
      _triggerScroll(_mediaSizeHeight * 0.6 + (expandedHeight - 45));
    } else if (offset > triggerUpStart && offset < triggerUpEnd) {
      _triggerScroll(0);
    }
  }

  void _triggerScroll(double targetOffset) {
    isAnimating = true;

    scrollController
        .animateTo(
          targetOffset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        )
        .whenComplete(() => isAnimating = false);
  }

  @override
  void dispose() {
    scrollController.dispose(); // Kaydırma denetleyicisini temizliyoruz
    super.dispose();
  }

  String formatTarih(dynamic timestamp) {
    if (timestamp == null) return '';

    final now = DateTime.now();
    DateTime date;

    if (timestamp is String) {
      date = DateTime.parse(timestamp).toLocal();
    } else if (timestamp is DateTime) {
      date = timestamp.toLocal();
    } else {
      return '';
    }

    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'home.today'.tr(); // assets/lang/tr.json içinde "today": "Bugün"
    } else if (dateOnly == yesterday) {
      return 'home.yesterday'.tr(); // "yesterday": "Dün"
    } else {
      return DateFormat('d MMMM', context.locale.toLanguageTag()).format(date);
    }
  }

  
}
