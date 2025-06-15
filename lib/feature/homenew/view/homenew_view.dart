import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kartal/kartal.dart';
import 'package:x_im_v00r01/feature/homenew/view/homenew_pageBuilder.dart';
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
  const HomenewView({
    super.key,
    @PathParam('storyId') this.storyId,
  });
  final dynamic storyId;

  @override
  State<HomenewView> createState() => _HomenewViewState();
}

class _HomenewViewState extends BaseState<HomenewView> with HomenewViewMixin {
  final String title = 'Harry Potter 20th Anniversary: Retu...';
  final String title2 = 'Harry Potter';

  int selectedIndex = 1;

  double _mediaSizeHeight = 200; // SliverAppBar'ın başlangıç yüksekliği

  final PageController _pageController = PageController(initialPage: 1);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    fetchData().then(
      (value_1) {
        // Data fetched successfully
        print('Data fetched successfully');
        /* final startIndex = widget.storyId != null
            ? homenewViewModel.state.data?.indexWhere(
                  (element) => element['id'] == widget.storyId,
                ) ??
                1
            : -1;
        _pageController =
            PageController(initialPage: startIndex >= 0 ? startIndex + 1 : 1); */

        fetchStoryIdData(widget.storyId as String).then((value_2) {
          fetchFavCount(value_1.first['id'] as String).then((val) {
            homenewViewModel.changeLoading(false);
          });
        });
      },
    ).catchError(
      (error) {
        // Handle error
        print('Error fetching data: $error');
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    homenewViewModel.changeLoading(true);
  }

  @override
  Widget build(BuildContext context) {
    _mediaSizeHeight = context.general.mediaSize.height;
    return BlocProvider(
      create: (context) => homenewViewModel,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 22),
          child: BlocSelector<HomenewViewModel, HomenewState, bool>(
            selector: (state) {
              //!state.isLoading
              return !state.isLoading;
            },
            builder: (context, state) {
              return state
                  ? PageView.builder(
                      reverse: true,
                      controller: _pageController,
                      itemCount: 15,
                      onPageChanged: (value) {
                        print('Page changed to: $value');
                        print(
                          'Page changed to lenhth: ${homenewViewModel.state.data?.length}',
                        );
                        print('Story ID: ${context.router.current.path}');

                        if (value != 0 &&
                            value <= homenewViewModel.state.data!.length) {
                          // Mevcut story ID'sini al
                          final storyId = homenewViewModel.state.data
                              ?.elementAt(value - 1)['id'];

                          fetchFavCount(storyId as String);

                          /* context.router.updateRouteData(
                            '/homenew/${storyId ?? ''}',
                          ); */

                          loadImageHeight(
                            value,
                            data: homenewViewModel.state.data,
                          );
                        }
                      },
                      itemBuilder: (context, index) {
                        print('Index: $index');
                        print('Story ID: ${widget.storyId}');

                        if (index == 0) {
                          return Expanded(
                            child: Container(
                              child:
                                  const Center(child: Text('adfasdasfasdas')),
                            ),
                          );
                        }

                        if (index > homenewViewModel.state.data!.length) {
                          return const Center(
                            child: Text('No more data'),
                          );
                        }

                        /* if (homenewViewModel.state.data!.length <= 2) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } */

                        return PageBuilderHomenewView(
                          key: ValueKey(index),
                          index: index,
                        );
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    );
            },
          ),
        ),
      ),
    );
  }
}



/* class HomenewPage2 extends StatelessWidget {
  const HomenewPage2({
    required this.homenewViewModel,
    super.key,
  });

  final HomenewViewModel homenewViewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            CustomScrollView(
              controller: homenewViewModel.scrollController,
              slivers: [
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    return SliverAppBar(
                      backgroundColor: Colors.blueGrey[900],
                      expandedHeight: 500,
                      toolbarHeight: 100,
                      pinned: true,
                      leading: const SizedBox(),
                      bottom: PreferredSize(
                        preferredSize: const Size.fromHeight(0),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            TweenAnimationBuilder<double>(
                              duration: const Duration(
                                milliseconds: 500,
                              ), // 🔥 Animasyon süresi
                              tween: Tween<double>(
                                begin: 150,
                                end: homenewViewModel.scrollOffset <= 100
                                    ? 150
                                    : 100,
                              ),
                              builder: (context, height, child) {
                                return AppBar(
                                  shadowColor: Colors.transparent,
                                  backgroundColor: Colors.blueGrey[400],
                                  clipBehavior: Clip.none,
                                  toolbarHeight: height,
                                  leading: const SizedBox(),
                                  leadingWidth: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  title: Text(
                                    'Başlık aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa',
                                    softWrap: true,
                                    maxLines: homenewViewModel.titlemaxline,
                                    style: TextStyle(
                                      fontSize: 20 -
                                          (10 * homenewViewModel.titleSize),
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                            Positioned(
                              top:
                                  -20, // İkonları yukarı kaydırıyoruz, böylece yarısı dışarıda kalır
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.center, // Ortalamak için
                                children: [
                                  AnimatedOpacity(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    opacity: homenewViewModel.opacity,
                                    child: AppBarTopIcon(
                                      // Üstteki ikonlar

                                      color: Colors.black,
                                      iconSizeHeight: 30,
                                      iconSizeWidth: 50,
                                      icon: Icons.home,
                                      text: 'Home',
                                      onPressed: () {
                                        print('object');
                                      },
                                      iconColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ), // İkonlar arası boşluk
                                  AnimatedOpacity(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    opacity: homenewViewModel.opacity,
                                    child: AppBarTopIcon(
                                      // Üstteki ikonlar

                                      color: Colors.black,
                                      iconSizeHeight: 30,
                                      iconSizeWidth: 50,
                                      icon: Icons.home,
                                      text: 'Home',
                                      onPressed: () {
                                        print('object');
                                      },
                                      iconColor: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  AnimatedOpacity(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    opacity: homenewViewModel.opacity,
                                    child: IconButton(
                                      // Üstteki ikonlar
                                      icon: const Icon(
                                        Icons.home,
                                        color: Colors.white,
                                      ),
                                      style: ButtonStyle(
                                        shape: WidgetStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                        ),
                                        backgroundColor:
                                            WidgetStateProperty.all(
                                          Colors.black,
                                        ),
                                      ),

                                      onPressed: () {
                                        print('object');
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      flexibleSpace: LayoutBuilder(
                        builder: (context, constraints) {
                          return Stack(
                            children: [
                              FlexibleSpaceBar(
                                background: Stack(
                                  fit: StackFit
                                      .expand, // 📌 Tüm alanı kaplamasını sağlar
                                  children: [
                                    Padding(
                                      padding: homenewViewModel.dynamicPadding,
                                      child: Image.asset(
                                        'asset/images/pexels1.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Başlığın üst kısmındaki semboller
                              Positioned(
                                top: 50,
                                right: 20,
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 300),
                                  opacity: homenewViewModel
                                      .opacity, // Kaydırıldıkça kaybolur
                                  child: Row(
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.favorite,
                                          color: Colors.black,
                                        ),
                                        onPressed: () {
                                          print('tttt');
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.share,
                                          color: Colors.white,
                                        ),
                                        onPressed: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          return Padding(
                            padding: homenewViewModel.scrollOffset <= 300
                                ? const EdgeInsets.only(
                                    left: 8,
                                    right: 8,
                                  )
                                : const EdgeInsets.only(),
                            child: const Card(
                              color: Colors.white,
                              child: Text('''
                        Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
                        Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
                        Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
                        Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
                        Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
                        Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
                        Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
                        Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
                        Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
                        Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
                        Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
                        Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
                        Bunu `ScrollController` ile dinleyerek yapabilirsin.Flutter'da `scrollOffset` kullanarak sayfa kaydırıldıkça içerik ve animasyonları değiştirebilirsin.  
                        Bu, özellikle `SliverAppBar`, `PageView.builder`, `ListView.builder` ve sonsuz kaydırma (infinite scroll) gibi özelliklerle oldukça kullanışlıdır.  
                        Örneğin, kullanıcı aşağı kaydırdıkça bir başlık görünmez hale gelebilir veya yeni veriler yüklenebilir.  
                        Bunu `ScrollController` ile dinleyerek yapabilirsin.
                        '''),
                            ),
                          );
                        },
                        childCount: 1,
                      ),
                    );
                  },
                ),
              ],
            ),

            // Sağ alt köşedeki semboller
            BlocSelector<HomenewViewModel, HomenewState, double>(
              selector: (state) {
                return state.opacity ?? 0.0;
              },
              builder: (context, state) {
                return Positioned(
                  bottom: 20,
                  right: 20,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: state < 0.1
                        ? 1.0
                        : 0.0, // Kaybolan semboller sağ alt köşede belirir
                    child: Row(
                      children: [
                        Builder(
                          builder: (context) {
                            if (state < 0.1) {
                              return IconButton(
                                icon: const Icon(Icons.favorite),
                                onPressed: () {
                                  print('bbbb');
                                },
                              );
                            } else {
                              return const SizedBox();
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.share,
                            color: Colors.amber,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class AppBarTopIcon extends StatelessWidget {
  const AppBarTopIcon({
    required this.color,
    required this.iconSizeWidth,
    required this.iconSizeHeight,
    required this.text,
    required this.onPressed,
    required this.iconColor,
    this.icon,
    super.key,
  });

  final Color color;
  final double? iconSizeWidth;
  final double? iconSizeHeight;
  final IconData? icon;
  final String text;
  final VoidCallback onPressed;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(
          Size(iconSizeWidth ?? 30, iconSizeHeight ?? 30),
        ),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(
          Colors.black,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min, // İçeriğin fazla genişlememesi için
        children: [
          Icon(icon, color: Colors.white), // İkon
          const SizedBox(width: 4), // İkon ile metin arasında boşluk
          Text(text, style: const TextStyle(color: Colors.white)), // Metin
        ],
      ),
    );
  }
} */

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
