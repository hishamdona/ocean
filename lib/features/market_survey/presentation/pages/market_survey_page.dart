import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MarketSurveyPage extends ConsumerStatefulWidget {
  const MarketSurveyPage({super.key});

  @override
  ConsumerState<MarketSurveyPage> createState() => _MarketSurveyPageState();
}

class _MarketSurveyPageState extends ConsumerState<MarketSurveyPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;

  final List<String> _sections = [
    'Products Demand',
    'Distress Sales',
    'Heavy Distributors',
    'Swap Deals',
    'Bulk Purchases',
    'Auctions',
  ];

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
      appBar: AppBar(
        title: Text(_sections[_selectedIndex]),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).colorScheme.secondary,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Theme.of(context).colorScheme.secondary,
          tabs: const [
            Tab(text: 'My Posts'),
            Tab(text: 'Global'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Section Selector
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _sections.length,
              itemBuilder: (context, index) {
                final isSelected = index == _selectedIndex;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_sections[index]),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    selectedColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
                    checkmarkColor: Theme.of(context).colorScheme.secondary,
                  ),
                );
              },
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildMyPostsTab(),
                _buildGlobalTab(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreatePostDialog();
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildMyPostsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5, // Placeholder count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'My ${_sections[_selectedIndex]} Post $index',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    PopupMenuButton(
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: ListTile(
                            leading: Icon(Icons.edit),
                            title: Text('Edit'),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: ListTile(
                            leading: Icon(Icons.delete, color: Colors.red),
                            title: Text('Delete', style: TextStyle(color: Colors.red)),
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        _handlePostAction(value.toString(), index);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'This is a sample ${_sections[_selectedIndex].toLowerCase()} post content. '
                  'It contains details about what I\'m looking for or offering.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.schedule,
                      size: 16,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Posted ${index + 1} days ago',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    Text(
                      '${(index * 3) + 5} responses',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
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

  Widget _buildGlobalTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 20, // Placeholder count
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      radius: 20,
                      child: Text('U$index'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User $index',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          Text(
                            '${index + 1} hours ago',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_selectedIndex == 5) // Auctions
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '2h 15m left',
                          style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: Colors.red[700],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 12),

                // Post Content
                Text(
                  _getPostContent(index),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                const SizedBox(height: 12),

                // Post Image (if applicable)
                if (index % 3 == 0)
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.image,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),

                const SizedBox(height: 12),

                // Action Buttons
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: Text('${(index * 2) + 3} responses'),
                    ),
                    const Spacer(),
                    if (_selectedIndex == 5) // Auctions
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Place bid on auction $index')),
                          );
                        },
                        child: const Text('Place Bid'),
                      )
                    else
                      OutlinedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Contact user $index')),
                          );
                        },
                        child: const Text('Contact'),
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

  String _getPostContent(int index) {
    switch (_selectedIndex) {
      case 0: // Products Demand
        return 'Looking for high-quality electronics in bulk. Need smartphones, tablets, and accessories. Serious buyers only.';
      case 1: // Distress Sales
        return 'Urgent sale! Clearing inventory of fashion items at 50% off. Limited time offer. Contact immediately.';
      case 2: // Heavy Distributors
        return 'Major distributor of home appliances. Wholesale prices available. Minimum order 100 units.';
      case 3: // Swap Deals
        return 'Looking to swap my collection of books for electronics. Have 200+ technical books in excellent condition.';
      case 4: // Bulk Purchases
        return 'Need 500 units of organic skincare products. Looking for reliable suppliers with competitive pricing.';
      case 5: // Auctions
        return 'Vintage watch collection auction! Starting bid \$100. Rare pieces from the 1960s. Bidding ends in 2 hours.';
      default:
        return 'Sample post content for market survey section.';
    }
  }

  void _showCreatePostDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create ${_sections[_selectedIndex]} Post'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter post title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe what you need or offer',
              ),
            ),
            if (_selectedIndex == 5) ...[
              const SizedBox(height: 16),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Starting Bid',
                  hintText: 'Enter starting bid amount',
                  prefixText: '\$ ',
                ),
                keyboardType: TextInputType.number,
              ),
            ],
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
                SnackBar(content: Text('${_sections[_selectedIndex]} post created')),
              );
            },
            child: const Text('Post'),
          ),
        ],
      ),
    );
  }

  void _handlePostAction(String action, int index) {
    switch (action) {
      case 'edit':
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Edit post $index')),
        );
        break;
      case 'delete':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Delete Post'),
            content: const Text('Are you sure you want to delete this post?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deleted post $index')),
                  );
                },
                child: const Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        );
        break;
    }
  }
}