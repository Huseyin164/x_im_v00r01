import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/product/cache/model/user_cache_model.dart';
import 'package:x_im_v00r01/product/state/view_model/product_state.dart';
import 'package:x_im_v00r01/product/state/view_model/product_view_model.dart';

enum TextSize { def, small, large }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  TextSize calendarView = TextSize.def;

  final List<bool> _selectedTextSize = [
    false,
    false,
    false,
  ]; // Başlangıçta varsayılan seçili

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductViewModel, ProductState>(
      builder: (context, state) {
        return ToggleButtons(
          constraints: const BoxConstraints(
            minWidth: 62,
            minHeight: 48,
            maxWidth: 62,
          ), // Butonları küçült
          borderRadius: BorderRadius.circular(8), // Kenar yuvarlama
          borderColor: Colors.grey, // Kenarlık rengi
          selectedBorderColor: Colors.blue, // Seçili segmentin kenarlık rengi
          color: context.general.textTheme.displaySmall?.color, // Yazı rengi
          selectedColor: Colors.blue, // Seçili yazı rengi
          fillColor: Colors.transparent,
          isSelected: context
                  .read<ProductViewModel>()
                  .userCacheOperation
                  .get('settingsBox')
                  ?.selectedTextSize ??
              [true, false, false],
          onPressed: (int index) {
            final sizes = [12.0, 10.0, 16.0];
            context.read<ProductViewModel>().setTextSize(sizes[index]);

            context.read<ProductViewModel>().userCacheOperation.put(
                  'fontSize',
                  UserCacheModel(fontSize: sizes[index]),
                );

            // UserCacheModel'e List<bool> gönder
            final updatedSelectedTextSize = [
              false,
              false,
              false,
            ]; // İlk önce hepsi false
            updatedSelectedTextSize[index] =
                true; // Seçili olan index'i true yap

            // Cache'e güncellenmiş değeri kaydet
            context.read<ProductViewModel>().userCacheOperation.put(
                  'settingsBox',
                  UserCacheModel(selectedTextSize: updatedSelectedTextSize),
                );
          },
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                'settings.default'.tr(),
                style: context.general.appTheme.textTheme.bodySmall
                    ?.copyWith(fontSize: 9),
              ),
            ),
            Text(
              'settings.small'.tr(),
              style: context.general.appTheme.textTheme.bodySmall,
            ),
            Text(
              'settings.large'.tr(),
              style: context.general.appTheme.textTheme.bodySmall,
            ),
          ], // Seçili arka plan rengi
        );
      },
    );
  }
}
