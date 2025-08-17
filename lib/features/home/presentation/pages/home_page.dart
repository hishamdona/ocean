import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
                  return _buildPostCard(context, index);
                },
                childCount: 20, // Placeholder count
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post Header
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey[300],
              child: const Icon(Icons.person),
            ),
            title: Text('User $index'),
            subtitle: Text('2 hours ago'),
            trailing: PopupMenuButton(
              itemBuilder: (context) => [
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
              onSelected: (value) {
                _handlePostMenuAction(value.toString(), index);
              },
            ),
          ),
          
          // Post Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'This is a sample post content for post $index. '
              'It could be about a product, demand, or any social commerce content.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Post Image/Media
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[200],
            child: const Icon(
              Icons.image,
              size: 50,
              color: Colors.grey,
            ),
          ),
          
          // Post Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Like Button
                InkWell(
                  onTap: () => _handleLike(index),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text('${(index * 3) + 12}'),
                    ],
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // Comment Button
                InkWell(
                  onTap: () => _handleComment(index),
                  child: Row(
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text('${(index * 2) + 5}'),
                    ],
                  ),
                ),
                
                const SizedBox(width: 24),
                
                // Share Button
                InkWell(
                  onTap: () => _handleShare(index),
                  child: Row(
                    children: [
                      Icon(
                        Icons.share_outlined,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text('${index + 2}'),
                    ],
                  ),
                ),
                
                const Spacer(),
                
                // Save Button
                InkWell(
                  onTap: () => _handleSave(index),
                  child: Icon(
                    Icons.bookmark_border,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handlePostMenuAction(String action, int index) {
    switch (action) {
      case 'product_details':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Product details for post $index')),
        );
        break;
      case 'view_ar':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('AR view for post $index')),
        );
        break;
      case 'report':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Report post $index')),
        );
        break;
    }
  }

  void _handleLike(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Liked post $index')),
    );
  }

  void _handleComment(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Comment on post $index')),
    );
  }

  void _handleShare(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Share post $index')),
    );
  }

  void _handleSave(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved post $index')),
    );
  }
}