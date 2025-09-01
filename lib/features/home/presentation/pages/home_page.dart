import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final Map<int, bool> _isLiked = {};
  String? _selectedResponse = '5';
  String? _selectedCategory = 'Electronics';

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
                  return _buildPostCard(context, index);
                },
                childCount: 20, // Placeholder count
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCreatePostModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.image, size: 50, color: Colors.grey),
          );
        },
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
                OutlinedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Followed user $index')),
                    );
                  },
                  child: const Text('Follow'),
                ),
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
          
          // Post Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Messaging user $index')),
                );
              },
              child: const Text('Message Me'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ),

          _buildProductDetails(context, index),
          const SizedBox(height: 12),

          // Image Grid
          _buildImageGrid(context),
          const SizedBox(height: 12),

          // Post Description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'This is a sample post content for post $index. '
              'It could be about a product, demand, or any social commerce content.',
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
                        _isLiked[index] ?? false ? Icons.favorite : Icons.favorite_border,
                        color: _isLiked[index] ?? false ? Colors.red : Colors.grey[600],
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
          _buildCommentInputRow(context),
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
    setState(() {
      _isLiked[index] = !(_isLiked[index] ?? false);
    });
  }

  void _handleComment(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Comment on post $index')),
    );
  }

  void _handleShare(int index) {
    _showShareModal(context);
  }

  void _handleSave(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved post $index')),
    );
  }

  Widget _buildProductDetails(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product Name: Product $index'),
              Text('Price: \$${index * 10}'),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Brand: Brand $index'),
              Text('Location: Location $index'),
            ],
          ),
        ],
      ),
    );
  }

  void _showShareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Share to'),
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSocialIcon(FontAwesomeIcons.link, 'Copy Link'),
                    _buildSocialIcon(FontAwesomeIcons.threads, 'Threads'),
                    _buildSocialIcon(FontAwesomeIcons.whatsapp, 'WhatsApp'),
                    _buildSocialIcon(FontAwesomeIcons.pinterest, 'Pinterest'),
                    _buildSocialIcon(FontAwesomeIcons.xTwitter, 'X'),
                    _buildSocialIcon(FontAwesomeIcons.telegram, 'Telegram'),
                    _buildSocialIcon(FontAwesomeIcons.facebook, 'Facebook'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 40),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }

  Widget _buildCommentInputRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write your comments…',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Attach file')),
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCreatePostModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: const Icon(Icons.person),
                    ),
                    const SizedBox(width: 12),
                    Text('User Name'),
                  ],
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    hintText: "What's on your mind?",
                    border: InputBorder.none,
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildModalAction(Icons.image, 'Image'),
                    _buildModalAction(Icons.videocam, 'Video'),
                    DropdownButton<String>(
                      value: _selectedResponse,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedResponse = newValue;
                        });
                      },
                      items: <String>['5', '10', '15', '20']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton<String>(
                      value: _selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue;
                        });
                      },
                      items: <String>['Electronics', 'Fashion', 'Home', 'Books']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Post created')),
                        );
                        Navigator.of(context).pop();
                      },
                      child: const Text('Post'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildModalAction(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, size: 30),
        const SizedBox(height: 4),
        Text(label),
      ],
    );
  }
}