import 'package:envied/envied.dart';
import 'package:gen/src/environment/app_configuration.dart';

part 'prod_env.g.dart';

@Envied(
  path: 'assets/env/.prod.env',
  obfuscate: true,
)
final class ProdEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseurl = _ProdEnv._baseurl;

  @EnviedField(varName: 'API_KEY')
  static final String _apikey = _ProdEnv._apikey;

  // 'AppConfiguration' arayüzündeki 'ApiKey' özelliğini burada implement ediyoruz.
  // Şifrelenmiş 'API_KEY' değerini çözümledikten sonra onu döndürüyoruz.
  @override
  String get ApiKey => _apikey;

  // 'AppConfiguration' arayüzündeki 'baseurl' özelliğini burada implement ediyoruz.
  // Şifrelenmiş 'BASE_URL' değerini çözümledikten sonra onu döndürüyoruz.
  @override
  String get baseurl => _baseurl;
  
  @override
  String get anonKey => throw UnimplementedError();
  
  @override
  String get supaURL => throw UnimplementedError();
  
  @override
  String get webclientID => throw UnimplementedError();

}


//flutter pub run build_runner build --delete-conflicting-outputs
