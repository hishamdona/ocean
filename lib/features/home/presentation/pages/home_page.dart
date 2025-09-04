import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/home_create_post_modal.dart';
import '../../../shared/presentation/widgets/post_card.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          // TODO: Implement refresh logic
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              title: Text(
                'BUYIT',
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),
              floating: true,
              snap: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Search')),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.notifications_none),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notifications')),
                    );
                  },
                ),
              ],
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            ),
            // Stories Section
            SliverToBoxAdapter(
              child: Container(
                height: 100,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: 10, // Placeholder count
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.secondary.withOpacity(0.7),
                                ],
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey[300],
                              ),
                              child: const Icon(Icons.person, size: 30),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'User $index',
                            style: Theme.of(context).textTheme.labelSmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Posts Feed
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return PostCard(
                    userName: 'User $index',
                    userAvatarUrl: 'https://i.pravatar.cc/150?u=a042581f4e29026704d',
                    postTime: '${index + 1} hours ago',
                    productName: 'Product $index',
                    newPrice: '\$${(index + 1) * 25}',
                    brand: 'Apple',
                    location: 'Lagos, Nigeria',
                    description: 'This is a sample post content for post $index. '
                        'It could be about a product, demand, or any social commerce content.',
                    likeCount: (index * 3) + 12,
                    commentCount: (index * 2) + 5,
                    shareCount: index + 2,
                    onFollow: () {},
                    onMessage: () {},
                    onLike: () {},
                    onComment: () {},
                    onSave: () {},
                    popupMenuItems: [
                      const PopupMenuItem(
                        value: 'product_details',
                        child: ListTile(
                          leading: Icon(Icons.info_outline),
                          title: Text('Product Details'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'view_ar',
                        child: ListTile(
                          leading: Icon(Icons.view_in_ar),
                          title: Text('View in AR'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'report',
                        child: ListTile(
                          leading: Icon(Icons.report_outlined),
                          title: Text('Report'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
                    onPopupMenuItemSelected: (value) {
                       ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Selected $value on post $index')),
                      );
                    },
                  );
                },
                childCount: 20, // Placeholder count
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const HomeCreatePostModal(),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}