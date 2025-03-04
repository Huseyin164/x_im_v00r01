import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/homenew/view/mixin/homenew_view_mixin.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/homenew_view_model.dart';
import 'package:x_im_v00r01/feature/homenew/view_model/state/homenew_state.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

/// This file contains the implementation of the `HomeNewView` class, which is
/// responsible for rendering the home view of the application. The class
/// provides the UI elements and handles user interactions for the home screen.
///
/// The `HomeNewView` class is part of the `homenew` feature and is located in
/// the `view` directory of the `homenew` feature module.
///
@RoutePage()
class HomenewView extends StatefulWidget {
  /// HomeNewView widget displays the home screen of the application.
  const HomenewView({super.key});

  @override
  State<HomenewView> createState() => _HomenewViewState();
}

class _HomenewViewState extends BaseState<HomenewView> with HomenewViewMixin {
  final String title = 'Harry Potter 20th Anniversary: Retu...';
  final String title2 = 'Harry Potter';

  int selectedIndex = 1;
  final ScrollController _scrollController = ScrollController();
  double _mediaSizeHeight = 200; // SliverAppBar'ın başlangıç yüksekliği
  bool isAnimating = false;

  double textHeight = 50;
  // ignore: prefer_final_locals
  late double expandedHeight;

  @override
  void initState() {
    super.initState();

    expandedHeight = textHeight;

    _scrollController.addListener(() {
      if (!isAnimating) {
        final offset = _scrollController.offset;

        if (offset > 110 && offset < 135) {
          _triggerScroll(_mediaSizeHeight * 0.6 + (expandedHeight - 45));
        } else if (offset > (_mediaSizeHeight * 0.6 - 65) &&
            offset < (_mediaSizeHeight * 0.6 - 50)) {
          _triggerScroll(0);
        }
      }
    });
  }

  void _triggerScroll(double targetOffset) {
    if (_scrollController.hasClients) {
      isAnimating = true;
      _scrollController
          .animateTo(
        targetOffset,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      )
          .then((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          isAnimating = false;
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose(); // Kaydırma denetleyicisini temizliyoruz
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _mediaSizeHeight = context.general.mediaSize.height;
    return BlocProvider(
      create: (context) => homenewViewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 22),
          child: PageView.builder(
            reverse: true,
            controller: PageController(initialPage: 1),
            itemCount: 4,
            onPageChanged: (value) {
              if (value != 0)
                loadImageHeight(value, data: homenewViewModel.state.data);
            },
            itemBuilder: (context, index) {
              if (index == 0) {
                return Expanded(
                  child: Container(
                    child: const Center(child: Text('adfasdasfasdas')),
                  ),
                );
              }

              return CustomScrollView(
                controller: _scrollController,
                slivers: <Widget>[
                  BlocSelector<HomenewViewModel, HomenewState,
                      (double, String)>(
                    selector: (state) {
                      return (
                        state.imageHeight ?? 250,
                        state.data?.elementAt(index - 1)['photo_url'] ?? ''
                      );
                    },
                    builder: (context, state) {
                      return SliverAppBar(
                        elevation: 1,
                        expandedHeight: state.$1,
                        automaticallyImplyLeading: false,
                        flexibleSpace: FlexibleSpaceBar(
                          expandedTitleScale: 1,
                          titlePadding: const EdgeInsets.only(top: 10),
                          title: Transform.translate(
                            offset: const Offset(0, 20),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                                color: context.general.colorScheme.surfaceDim,
                              ),
                              child: Transform.translate(
                                offset: const Offset(0, -25),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,

                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: context.general.colorScheme
                                              .surfaceBright,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Text(
                                            'Bugün',
                                            style: context
                                                .general.textTheme.bodySmall,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          TextButton.icon(
                                            onPressed: () {
                                              homenewViewModel.increaseFav();
                                              return;
                                            },
                                            iconAlignment: IconAlignment.end,
                                            icon: Icon(
                                              Icons.favorite_border,
                                              size: context.general.textTheme
                                                      .bodySmall!.fontSize! +
                                                  5,
                                            ),
                                            label: const Text(
                                              '1664',
                                            ),
                                            style: TextButton.styleFrom(
                                              iconColor: context.general
                                                  .textTheme.bodySmall?.color,
                                              minimumSize: const Size(0, 32),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              textStyle: context
                                                  .general.textTheme.bodySmall,
                                              foregroundColor: context.general
                                                  .textTheme.bodySmall?.color,
                                              backgroundColor: context.general
                                                  .colorScheme.surfaceBright,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              return;
                                            },
                                            icon: Icon(
                                              Icons.share,
                                              size: context.general.textTheme
                                                      .bodySmall!.fontSize! +
                                                  5,
                                            ),
                                            style: TextButton.styleFrom(
                                              iconColor: context.general
                                                  .textTheme.bodySmall?.color,
                                              minimumSize: const Size(0, 32),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                              ),
                                              textStyle: context
                                                  .general.textTheme.bodySmall,
                                              foregroundColor: context.general
                                                  .textTheme.bodySmall?.color,
                                              backgroundColor: context.general
                                                  .colorScheme.surfaceBright,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          background: (!homenewViewModel.state.isLoading)
                              ? Container(
                                  color: Colors
                                      .grey[300], // Arka plan placeholder rengi
                                  child: const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: MemoryImage(
                                        base64Decode(state.$2),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  BlocSelector<HomenewViewModel, HomenewState, String>(
                    selector: (state) {
                      return state.data?.elementAt(index - 1)['title']
                          as String;
                    },
                    builder: (context, state) {
                      return SliverLayoutBuilder(
                        builder: (context, constraints) {
                          // ignore: prefer_final_locals
                          textHeight = calculateTextHeight(
                            state,
                          );
                          // ignore: prefer_final_locals
                          expandedHeight = textHeight + 35;

                          return SliverAppBar(
                            backgroundColor:
                                context.general.colorScheme.surfaceDim,
                            elevation: 0,
                            scrolledUnderElevation: 0,
                            shadowColor: context.general.colorScheme.surfaceDim,
                            surfaceTintColor:
                                context.general.colorScheme.surfaceDim,
                            foregroundColor:
                                context.general.colorScheme.surfaceDim,
                            automaticallyImplyLeading: false,
                            expandedHeight: expandedHeight,
                            collapsedHeight: 45,
                            toolbarHeight: 0,
                            pinned: true,
                            flexibleSpace: FlexibleSpaceBar(
                              title: Transform.translate(
                                offset: const Offset(0, 5),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Text(
                                    state,
                                    style:
                                        context.general.textTheme.headlineSmall,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SliverAppBar(
                    backgroundColor: context.general.colorScheme.surfaceDim,
                    elevation: 0,
                    scrolledUnderElevation: 0,
                    shadowColor: context.general.colorScheme.surfaceDim,
                    surfaceTintColor: context.general.colorScheme.surfaceDim,
                    foregroundColor: context.general.colorScheme.surfaceDim,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    title: Row(
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            return;
                          },
                          // icon: const CircleAvatar(
                          //   radius: 12,
                          //   backgroundImage: NetworkImage(
                          //     'https://m.media-amazon.com/images/M/MV5BMTQ3ODE2NTMxMV5BMl5BanBnXkFtZTgwOTIzOTQzMjE@._V1_.jpg',
                          //   ),
                          // ),
                          label: BlocSelector<HomenewViewModel, HomenewState,
                              String>(
                            selector: (state) {
                              return state.data?.elementAt(index - 1)['name']
                                      as String? ??
                                  'Text Placeholder';
                            },
                            builder: (context, name) {
                              return Text(
                                name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            },
                          ),
                          style: TextButton.styleFrom(
                            iconColor:
                                context.general.textTheme.bodySmall?.color,
                            minimumSize: const Size(0, 32),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                            ),
                            textStyle: context.general.textTheme.bodySmall,
                            foregroundColor:
                                context.general.colorScheme.onTertiary,
                            backgroundColor:
                                context.general.colorScheme.tertiary,
                          ),
                        ),
                        BlocSelector<HomenewViewModel, HomenewState, String>(
                          selector: (state) {
                            return state.data
                                ?.elementAt(index - 1)['birth_date'] as String;
                          },
                          builder: (context, state) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                DateFormat.yMMMMd(context.locale.languageCode)
                                    .format(DateTime.parse(state)),
                                style: context.general.textTheme.labelMedium,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          BlocSelector<HomenewViewModel, HomenewState, String>(
                            selector: (state) {
                              return state.data?.elementAt(index - 1)['story']
                                  as String;
                            },
                            builder: (context, state) {
                              return Text(
                                state,
                                style: const TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Born',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'April, 15th 1990, Paris, France',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Nationality',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            'British',
                            style: TextStyle(color: Colors.grey),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'Videos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 200,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: <Widget>[
                                _makeVideo(
                                  image: 'assets/images/emma-1.jpg',
                                ),
                                _makeVideo(
                                  image: 'assets/images/emma-2.jpg',
                                ),
                                _makeVideo(
                                  image: 'assets/images/emma-3.jpg',
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 120,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

Widget _makeVideo({required String image}) {
  return AspectRatio(
    aspectRatio: 1.5 / 1,
    child: Container(
      margin: const EdgeInsets.only(right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomRight,
            colors: [
              Colors.black.withOpacity(.9),
              Colors.black.withOpacity(.3),
            ],
          ),
        ),
        child: const Align(
          child: Icon(
            Icons.play_arrow,
            color: Colors.white,
            size: 70,
          ),
        ),
      ),
    ),
  );
}

// class HomenewPage2 extends StatelessWidget {
//   const HomenewPage2({
//     required this.homenewViewModel,
//     super.key,
//   });

//   final HomenewViewModel homenewViewModel;

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Stack(
//           children: [
//             CustomScrollView(
//               controller: homenewViewModel.scrollController,
//               slivers: [
//                 SliverLayoutBuilder(
//                   builder: (context, constraints) {
//                     return SliverAppBar(
//                       backgroundColor: Colors.blueGrey[900],
//                       expandedHeight: 500,
//                       toolbarHeight: 100,
//                       pinned: true,
//                       leading: const SizedBox(),
//                       bottom: PreferredSize(
//                         preferredSize: const Size.fromHeight(0),
//                         child: Stack(
//                           clipBehavior: Clip.none,
//                           children: [
//                             TweenAnimationBuilder<double>(
//                               duration: const Duration(
//                                 milliseconds: 500,
//                               ), // 🔥 Animasyon süresi
//                               tween: Tween<double>(
//                                 begin: 150,
//                                 end: homenewViewModel.scrollOffset <= 100
//                                     ? 150
//                                     : 100,
//                               ),
//                               builder: (context, height, child) {
//                                 return AppBar(
//                                   shadowColor: Colors.transparent,
//                                   backgroundColor: Colors.blueGrey[400],
//                                   clipBehavior: Clip.none,
//                                   toolbarHeight: height,
//                                   leading: const SizedBox(),
//                                   leadingWidth: 0,
//                                   shape: const RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.only(
//                                       topLeft: Radius.circular(20),
//                                       topRight: Radius.circular(20),
//                                     ),
//                                   ),
//                                   title: Text(
//                                     'Başlık aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
//                                     softWrap: true,
//                                     maxLines: homenewViewModel.titlemaxline,
//                                     style: TextStyle(
//                                       fontSize: 20 -
//                                           (10 * homenewViewModel.titleSize),
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                             Positioned(
//                               top:
//                                   -20, // İkonları yukarı kaydırıyoruz, böylece yarısı dışarıda kalır
//                               left: 0,
//                               right: 0,
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.center, // Ortalamak için
//                                 children: [
//                                   AnimatedOpacity(
//                                     duration: const Duration(
//                                       milliseconds: 300,
//                                     ),
//                                     opacity: homenewViewModel.opacity,
//                                     child: AppBarTopIcon(
//                                       // Üstteki ikonlar

//                                       color: Colors.black,
//                                       iconSizeHeight: 30,
//                                       iconSizeWidth: 50,
//                                       icon: Icons.home,
//                                       text: 'Home',
//                                       onPressed: () {
//                                         print('object');
//                                       },
//                                       iconColor: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     width: 10,
//                                   ), // İkonlar arası boşluk
//                                   AnimatedOpacity(
//                                     duration: const Duration(
//                                       milliseconds: 300,
//                                     ),
//                                     opacity: homenewViewModel.opacity,
//                                     child: AppBarTopIcon(
//                                       // Üstteki ikonlar

//                                       color: Colors.black,
//                                       iconSizeHeight: 30,
//                                       iconSizeWidth: 50,
//                                       icon: Icons.home,
//                                       text: 'Home',
//                                       onPressed: () {
//                                         print('object');
//                                       },
//                                       iconColor: Colors.white,
//                                     ),
//                                   ),
//                                   const SizedBox(width: 10),
//                                   AnimatedOpacity(
//                                     duration: const Duration(
//                                       milliseconds: 300,
//                                     ),
//                                     opacity: homenewViewModel.opacity,
//                                     child: IconButton(
//                                       // Üstteki ikonlar
//                                       icon: const Icon(
//                                         Icons.home,
//                                         color: Colors.white,
//                                       ),
//                                       style: ButtonStyle(
//                                         shape: WidgetStateProperty.all(
//                                           RoundedRectangleBorder(
//                                             borderRadius: BorderRadius.circular(
//                                               50,
//                                             ),
//                                           ),
//                                         ),
//                                         backgroundColor:
//                                             WidgetStateProperty.all(
//                                           Colors.black,
//                                         ),
//                                       ),

//                                       onPressed: () {
//                                         print('object');
//                                       },
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       flexibleSpace: LayoutBuilder(
//                         builder: (context, constraints) {
//                           return Stack(
//                             children: [
//                               FlexibleSpaceBar(
//                                 background: Stack(
//                                   fit: StackFit
//                                       .expand, // 📌 Tüm alanı kaplamasını sağlar
//                                   children: [
//                                     Padding(
//                                       padding: homenewViewModel.dynamicPadding,
//                                       child: Image.asset(
//                                         'asset/images/pexels1.jpg',
//                                         fit: BoxFit.cover,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               // Başlığın üst kısmındaki semboller
//                               Positioned(
//                                 top: 50,
//                                 right: 20,
//                                 child: AnimatedOpacity(
//                                   duration: const Duration(milliseconds: 300),
//                                   opacity: homenewViewModel
//                                       .opacity, // Kaydırıldıkça kaybolur
//                                   child: Row(
//                                     children: [
//                                       IconButton(
//                                         icon: const Icon(
//                                           Icons.favorite,
//                                           color: Colors.black,
//                                         ),
//                                         onPressed: () {
//                                           print('tttt');
//                                         },
//                                       ),
//                                       IconButton(
//                                         icon: const Icon(
//                                           Icons.share,
//                                           color: Colors.white,
//                                         ),
//                                         onPressed: () {},
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//                 SliverLayoutBuilder(
//                   builder: (context, constraints) {
//                     return SliverList(
//                       delegate: SliverChildBuilderDelegate(
//                         (BuildContext context, int index) {
//                           return Padding(
//                             padding: homenewViewModel.scrollOffset <= 300
//                                 ? const EdgeInsets.only(
//                                     left: 8,
//                                     right: 8,
//                                   )
//                                 : const EdgeInsets.only(),
//                             child: const Card(
//                               color: Colors.white,
//                               child: Text('''
//                         Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
//                         Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
//                         Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
//                         Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
//                         Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
//                         Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
//                         Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
//                         Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
//                         Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
//                         Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
//                         Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
//                         Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
//                         Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
//                         Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
//                         Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
//                         Bunu `ScrollController` ile dinleyerek yapabilirsin.
//                         '''),
//                             ),
//                           );
//                         },
//                         childCount: 1,
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),

//             // Sağ alt köşedeki semboller
//             BlocSelector<HomenewViewModel, HomenewState, double>(
//               selector: (state) {
//                 return state.opacity ?? 0.0;
//               },
//               builder: (context, state) {
//                 return Positioned(
//                   bottom: 20,
//                   right: 20,
//                   child: AnimatedOpacity(
//                     duration: const Duration(milliseconds: 300),
//                     opacity: state < 0.1
//                         ? 1.0
//                         : 0.0, // Kaybolan semboller sağ alt köşede belirir
//                     child: Row(
//                       children: [
//                         Builder(
//                           builder: (context) {
//                             if (state < 0.1) {
//                               return IconButton(
//                                 icon: const Icon(Icons.favorite),
//                                 onPressed: () {
//                                   print('bbbb');
//                                 },
//                               );
//                             } else {
//                               return const SizedBox();
//                             }
//                           },
//                         ),
//                         IconButton(
//                           icon: const Icon(
//                             Icons.share,
//                             color: Colors.amber,
//                           ),
//                           onPressed: () {},
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class AppBarTopIcon extends StatelessWidget {
//   const AppBarTopIcon({
//     required this.color,
//     required this.iconSizeWidth,
//     required this.iconSizeHeight,
//     required this.text,
//     required this.onPressed,
//     required this.iconColor,
//     this.icon,
//     super.key,
//   });

//   final Color color;
//   final double? iconSizeWidth;
//   final double? iconSizeHeight;
//   final IconData? icon;
//   final String text;
//   final VoidCallback onPressed;
//   final Color iconColor;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ButtonStyle(
//         minimumSize: WidgetStateProperty.all(
//           Size(iconSizeWidth ?? 30, iconSizeHeight ?? 30),
//         ),
//         shape: WidgetStateProperty.all(
//           RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10),
//           ),
//         ),
//         backgroundColor: WidgetStateProperty.all(
//           Colors.black,
//         ),
//       ),
//       onPressed: onPressed,
//       child: Row(
//         mainAxisSize: MainAxisSize.min, // İçeriğin fazla genişlememesi için
//         children: [
//           Icon(icon, color: Colors.white), // İkon
//           const SizedBox(width: 4), // İkon ile metin arasında boşluk
//           Text(text, style: const TextStyle(color: Colors.white)), // Metin
//         ],
//       ),
//     );
//   }
// }

//----------------------------------------------------------------
/*BlocProvider<HomenewViewModel> firstHomeNew(BuildContext context) {
    return BlocProvider(
      create: (context) => homenewViewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 32),
          child: ListView(
            children: [
              const HomenewAppBar(),
              const SizedBox(
                height: 34,
              ),
              const Center(child: HomenewStatusBar()),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: SearchAndFriend(),
              ),
              const SizedBox(
                height: 32,
              ),
              BlocListener<HomenewViewModel, HomenewState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                child:
                    BlocSelector<HomenewViewModel, HomenewState, List<Content>>(
                  selector: (state) {
                    return state.content ??
                        [
                          Content(
                            email: '',
                            fullName: '',
                            id: '',
                            username: '',
                            image: '',
                          ),
                        ];
                  },
                  builder: (context, state) {
                    return HomenewText(
                      text: state.first.email ?? 'email',
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              HomenewStoryButton(
                onOperation: homenewViewModel.fetchUsers,
                width: 335,
                height: 184,
              ),
              const SizedBox(height: 32),
              const Row(
                children: [
                  HomenewText(text: 'Life-changing moments'),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 184,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: HomenewStoryButton(
                        width: 161,
                        height: 184,
                        onOperation: () async {
                          await context.router.navigate(const StoryyRoute());
                          return true; // Ensure the return type is Future<bool>
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
                color: Colors.black,
              ),
              label: 'Settings',
            ),
          ],
          currentIndex: selectedIndex, // Selected index (Settings)
          onTap: (index) {
            // Bottom navigation logic
            setState(() {
              selectedIndex = index;
              switch (selectedIndex) {
                case 0:
                  // Navigate to Home route
                  context.router.navigate(const HomenewRoute());
                // case 1:
                //   // Navigate to Search route
                //   context.router.navigate(const SearchRoute());
                // case 2:
                //   // Navigate to Profile route
                //   context.router.navigate(const ProfileRoute());
                case 3:
                  // Navigate to Settings route
                  context.router.navigate(const SettingsRoute());
                default:
                  break;
              }
            });
            print('$index');
          },
        ),
      ),
    );
  }
}*/
