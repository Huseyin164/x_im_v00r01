import 'package:flutter/material.dart';

enum Locales {
  en(Locale('en', 'US')),
  tr(Locale('tr', 'TR'));

  const Locales(this.locale);
  final Locale locale;

/* burada önce tr ve en seçenekleri oluşturulur 
   sonra her seçeneğin içindeki Locale nesnelerine
   erişmek için locale nesnesi oluşturulur 
   ve const sayesinde bu Locale nesneleri sabitlenir, 
   yani oluşturulduktan sonra bir daha değiştirilemez. 
   Her enum sabiti (tr ve en) kendi Locale nesnesini 
   constructor aracılığıyla alır ve bu nesneler enum içinde 
   final olarak saklanır.

   Özetle:
   - tr: Locale('tr', 'TR') sabit nesnesini tutar.
   - en: Locale('en', 'US') sabit nesnesini tutar.
   
   Bu sayede uygulama içinde bu Locale nesnelerine 
   `Locales.tr.locale` veya `Locales.en.locale` ile 
   kolayca erişilebilir. Örneğin, uygulamada bir dili değiştirmek 
   istediğimizde doğrudan Locales enum sabitlerinden 
   birini seçip o dilin Locale değerini kullanabiliriz.
*/
}
