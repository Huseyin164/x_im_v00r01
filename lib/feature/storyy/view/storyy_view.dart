import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:x_im_v00r01/feature/storyy/view/mixin/story_view_mixin.dart';
import 'package:x_im_v00r01/product/navigation/deeplink/app_router.dart';
import 'package:x_im_v00r01/product/state/base/base_state.dart';

@RoutePage()
class StoryyView extends StatefulWidget {
  const StoryyView({super.key});

  @override
  State<StoryyView> createState() => _StoryyViewState();
}

class _StoryyViewState extends BaseState<StoryyView> with StoryViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            context.router.popAndPush(const HomenewRoute());
          }, // Geri butonu işlevi
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {}, // Favorilere ekle işlevi
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kitap Görseli
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1fHx3b21hbiUyMHdlYXJpbmd8ZW58MXx8fHwxNjUzNTg3NjU1&ixlib=rb-1.2.1&q=80&w=1080',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            // Başlık ve Ücret
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'The Homeric Hymns',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'By Michael Crudden',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                Text(
                  '₹757',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Detay Kartları
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoCard(label: 'Released', value: '2021'),
                _InfoCard(label: 'Part', value: '16'),
                _InfoCard(label: 'Pages', value: '340'),
              ],
            ),
            const SizedBox(height: 16),
            // TabBar ve İçerik
            const DefaultTabController(
              length: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TabBar(
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: Colors.black,
                    tabs: [
                      Tab(text: 'Synopsis'),
                      Tab(text: 'Details'),
                      Tab(text: 'Author'),
                      Tab(text: 'Review'),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 200, // İçerik yüksekliği
                    child: TabBarView(
                      children: [
                        // Synopsis
                        Text(
                          '“With fair-tressed Demeter, the sacred goddess, my song begins...”',
                          style: TextStyle(fontSize: 14),
                        ),
                        // Details
                        Center(child: Text('Details content')),
                        // Author
                        Center(child: Text('Author content')),
                        // Review
                        Center(child: Text('Review content')),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Oynat Butonu
            Center(
              child: FloatingActionButton(
                onPressed: () {}, // Buton işlevi
                child: const Icon(Icons.play_arrow),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
