import 'package:envied/envied.dart';
import 'package:gen/src/environment/app_configuration.dart';

part 'dev_env.g.dart';

@Envied(
  path: 'assets/env/.dev.env',
  obfuscate: true,
)
final class DevEnv implements AppConfiguration {
  @EnviedField(varName: 'BASE_URL')
  static final String _baseurl = _DevEnv._baseurl;

  @EnviedField(varName: 'API_KEY')
  static final String _apikey = _DevEnv._apikey;

  @EnviedField(varName: 'SUPABASE_URL')
  static final String _supaurl = _DevEnv._supaurl;

  @EnviedField(varName: 'SUPABASE_ANON_KEY')
  static final String _anonkey = _DevEnv._anonkey;

  @EnviedField(varName: 'WEB_CLIENT_ID')
  static final String _webclientID = _DevEnv._webclientID;

  @override
  String get ApiKey => _apikey;

  @override
  String get baseurl => _baseurl;

  @override
  String get supaURL => _supaurl;

  @override
  String get anonKey => _anonkey;

  @override
  String get webclientID => _webclientID;
}

// 'envied' paketini import ediyoruz. Bu paket, ortam değişkenlerini (environment variables)
// kullanmak ve onları güvenli bir şekilde saklamak (obfuscation) için kullanılıyor.

// Uygulama yapılandırma sınıfını temsil eden 'AppConfiguration' arayüzünü import ediyoruz.

// 'dev_env.g.dart' adlı dosya, build runner çalıştırıldığında otomatik olarak oluşturulacak.
// Bu dosya, ortam değişkenlerinin şifrelenmiş hallerini çözümlemek için gerekli olan
// kodu içerecek. Bu nedenle 'part' anahtar kelimesiyle belirtiyoruz.

// 'Envied' anotasyonu ile ortam değişkenlerini tanımlıyoruz.
// 'path' parametresi, ortam değişkenlerinin tanımlı olduğu dosya yolunu belirtir (asset/env/.dev.env).
// 'obfuscate: true' parametresi ile ortam değişkenleri şifrelenmiş (obfuscated) hale getirilir,
// bu da güvenliği artırır.

// Ortam değişkeni olan 'BASE_URL' burada '_baseurl' adında bir static değişken ile eşleştirilir.
// Bu, şifrelenmiş 'BASE_URL' değerini çözümlemek için gerekli olan değişkendir.

// Ortam değişkeni olan 'API_KEY' burada '_apikey' adında bir static değişken ile eşleştirilir.
// Bu da şifrelenmiş 'API_KEY' değerini çözümlemek için kullanılır.

// 'AppConfiguration' arayüzündeki 'ApiKey' özelliğini burada implement ediyoruz.
// Şifrelenmiş 'API_KEY' değerini çözümledikten sonra onu döndürüyoruz.

// 'AppConfiguration' arayüzündeki 'baseurl' özelliğini burada implement ediyoruz.
// Şifrelenmiş 'BASE_URL' değerini çözümledikten sonra onu döndürüyoruz.

// Yorum: Bu komut, 'build_runner' aracını çalıştırarak .g.dart dosyasını üretir.
// --delete-conflicting-outputs ile eski ve çakışan dosyalar silinir.
// dart run build_runner clean
// flutter pub run build_runner build --delete-conflicting-outputs
