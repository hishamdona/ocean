import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/product_model.dart';

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
          _showCreatePostPage(context);
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
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Follow Button
                OutlinedButton(
                  onPressed: () => _handleFollow(index),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(60, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('Follow'),
                ),
                const SizedBox(width: 8),
                // Message Me Button
                ElevatedButton(
                  onPressed: () => _handleMessageMe(index),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(80, 32),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text('Message Me'),
                ),
                const SizedBox(width: 8),
                // Menu Button
                PopupMenuButton(
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
              ],
            ),
          ),
          
          // Product Details Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                // Row 1: Product Name and Price
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Product Name',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'iPhone 15 Pro Max',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Price',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '\$${(index * 100 + 999).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                const SizedBox(height: 12),
                
                // Row 2: Brand and Location
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brand',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Apple',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Lagos, Nigeria',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // 2x2 Image Grid
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              height: 200,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                ),
                itemCount: 4,
                itemBuilder: (context, imageIndex) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 30,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Post Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Brand new iPhone 15 Pro Max in excellent condition. '
              'Comes with original box, charger, and warranty. '
              'Perfect for photography enthusiasts and tech lovers.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          
          const SizedBox(height: 12),
          
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
          
          // Comment Input Row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // User Avatar
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  radius: 16,
                  child: const Icon(Icons.person, size: 16),
                ),
                const SizedBox(width: 12),
                // Comment Input
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Write your comments…',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                // Attachment Icon
                IconButton(
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.grey[600],
                  ),
                  onPressed: () => _handleCommentAttachment(index),
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
    _showShareModal(context, index);
  }

  void _handleFollow(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Following user from post $index')),
    );
  }

  void _handleMessageMe(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message user from post $index')),
    );
  }

  void _handleCommentAttachment(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Add attachment to comment on post $index')),
    );
  }

  void _handleSave(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved post $index')),
    );
  }

  void _showShareModal(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Share Post',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  _buildShareOption(context, 'Copy Link', Icons.link),
                  _buildShareOption(context, 'Threads', Icons.alternate_email),
                  _buildShareOption(context, 'WhatsApp', Icons.chat),
                  _buildShareOption(context, 'Pinterest', Icons.push_pin),
                  _buildShareOption(context, 'X', Icons.close),
                  _buildShareOption(context, 'Telegram', Icons.send),
                  _buildShareOption(context, 'Facebook', Icons.facebook),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Shared via $title')),
        );
      },
    );
  }

  void _showCreatePostPage(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'Create Post',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // User Avatar and Text Field
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey[300],
                          radius: 20,
                          child: const Icon(Icons.person),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: TextField(
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintText: "What's on your mind?",
                              border: InputBorder.none,
                              hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                color: Colors.grey[500],
                              ),
                            ),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Interactive Icons Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCreatePostOption(context, 'Image', Icons.image, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Upload images')),
                          );
                        }),
                        _buildCreatePostOption(context, 'Video', Icons.videocam, () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Upload videos')),
                          );
                        }),
                        _buildCreatePostOption(context, 'Response', Icons.people, () {
                          _showResponseDropdown(context);
                        }),
                        _buildCreatePostOption(context, 'Category', Icons.category, () {
                          _showCategoryDropdown(context);
                        }),
                      ],
                    ),
                    
                    const Spacer(),
                    
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Post created successfully')),
                              );
                            },
                            child: const Text('Post'),
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
      ),
    );
  }

  Widget _buildCreatePostOption(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        child: Column(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  void _showResponseDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Response Limit'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Set maximum number of responses:'),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              decoration: const InputDecoration(
                labelText: 'Max Responses',
              ),
              items: const [
                DropdownMenuItem(value: 5, child: Text('5')),
                DropdownMenuItem(value: 10, child: Text('10')),
                DropdownMenuItem(value: 15, child: Text('15')),
                DropdownMenuItem(value: 20, child: Text('20')),
              ],
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Response limit set')),
              );
            },
            child: const Text('Set'),
          ),
        ],
      ),
    );
  }

  void _showCategoryDropdown(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Product Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Select product category:'),
            const SizedBox(height: 16),
            DropdownButtonFormField<ProductCategory>(
              decoration: const InputDecoration(
                labelText: 'Category',
              ),
              items: ProductCategory.values.map((category) {
                return DropdownMenuItem(
                  value: category,
                  child: Text(_getCategoryDisplayName(category)),
                );
              }).toList(),
              onChanged: (value) {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Category selected')),
              );
            },
            child: const Text('Select'),
          ),
        ],
      ),
    );
  }

  String _getCategoryDisplayName(ProductCategory category) {
    switch (category) {
      case ProductCategory.electronics:
        return 'Electronics';
      case ProductCategory.fashion:
        return 'Fashion';
      case ProductCategory.homeGarden:
        return 'Home & Garden';
      case ProductCategory.sportsOutdoors:
        return 'Sports & Outdoors';
      case ProductCategory.automotive:
        return 'Automotive';
      case ProductCategory.booksMedia:
        return 'Books & Media';
      case ProductCategory.healthBeauty:
        return 'Health & Beauty';
      case ProductCategory.toysGames:
        return 'Toys & Games';
      case ProductCategory.foodBeverages:
        return 'Food & Beverages';
      case ProductCategory.industrial:
        return 'Industrial';
      case ProductCategory.other:
        return 'Other';
    }
  }
}