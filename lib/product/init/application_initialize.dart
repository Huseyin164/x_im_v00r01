import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:kartal/kartal.dart';
import 'package:logger/logger.dart';
import 'package:x_im_v00r01/product/init/config/app_environment.dart';
import 'package:x_im_v00r01/product/state/container/product_state_container.dart';
import 'package:x_im_v00r01/product/state/container/product_state_items.dart';

@immutable
final class AplicationInitiliaze {
  Future<void> make() async {
    final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    await runZonedGuarded<Future<void>>(
      _initialize,
      (error, stack) {
        Logger().e(error);
      },
    );
  }

  Future<void> _initialize() async {
    await EasyLocalization.ensureInitialized();
    EasyLocalization.logger.enableLevels = [LevelMessages.error];
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await DeviceUtility.instance.initPackageInfo();

    FlutterError.onError = (details) {
      Logger().e(details.exceptionAsString());
    };

    await _productEnvironmentWithContainer();

    await ProductStateItems.productCache.init();

    FlutterNativeSplash.remove();

    //await ProductStateItems.productCache.loadData();
    //await ProductStateItems.productCache.updateData();
  }

  /// DO NOT CHANGE THIS METHOD
  Future<void> _productEnvironmentWithContainer() async {
    AppEnvironment.general();

    /// It must be call after [AppEnvironment.general()]
    await ProductContainer.setup();
  }
  /*
  burada uygulama açılışı esnasındaki initiliazler yapıldı

  widgetlar yüklenir

  easy localization sayesinde dil yüklenir
  levelmessager.errorun bu şekilde yazılma sebebi enum olması

  await sayesinde bu işlemlerin yapılması beklenir

  flutter on error bir calback fonskyion ve hata olduğu zaman çalışır
  oluşturduğu  FlutterErrorDetails nesnesini detailsa parametre olarak geçirir
  sonrasında biz details üzerinen hatanın detaylarına ulaşabiliriz


  buraya fire base initiliazeleri de gelebilir
  */
}
