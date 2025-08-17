import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SavedPage extends ConsumerStatefulWidget {
  const SavedPage({super.key});

  @override
  ConsumerState<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends ConsumerState<SavedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Tab Bar
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              labelColor: Theme.of(context).colorScheme.secondary,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Theme.of(context).colorScheme.secondary,
              tabs: const [
                Tab(text: 'Posts'),
                Tab(text: 'Products'),
              ],
            ),
          ),
          
          // Tab Views
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildSavedPostsTab(),
                _buildSavedProductsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSavedPostsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10, // Placeholder count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
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
                subtitle: Text('Saved ${index + 1} days ago'),
                trailing: IconButton(
                  icon: const Icon(Icons.bookmark),
                  onPressed: () => _removeSavedPost(index),
                ),
              ),
              
              // Post Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'This is a saved post content for post $index. '
                  'It contains information about products or market demands.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Post Image
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
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.favorite_border),
                      label: Text('${(index * 3) + 12}'),
                    ),
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: Text('${(index * 2) + 5}'),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => _viewOriginalPost(index),
                      child: const Text('View Original'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSavedProductsTab() {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: 20, // Placeholder count
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(12),
                        ),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.bookmark,
                            color: Colors.red,
                          ),
                          onPressed: () => _removeSavedProduct(index),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Product Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product $index',
                        style: Theme.of(context).textTheme.titleSmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '\$${(index * 10 + 50).toStringAsFixed(2)}',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber[600],
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '4.${index % 5 + 3}',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                          const Spacer(),
                          Text(
                            'Saved',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeSavedPost(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Saved'),
        content: const Text('Are you sure you want to remove this post from your saved items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed post $index from saved')),
              );
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _removeSavedProduct(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Saved'),
        content: const Text('Are you sure you want to remove this product from your saved items?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Removed product $index from saved')),
              );
            },
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _viewOriginalPost(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('View original post $index')),
    );
  }
}