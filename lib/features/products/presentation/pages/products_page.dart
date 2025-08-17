import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/product_model.dart';

class ProductsPage extends ConsumerStatefulWidget {
  const ProductsPage({super.key});

  @override
  ConsumerState<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends ConsumerState<ProductsPage> {
  bool _isGridView = true;
  ProductCategory? _selectedCategory;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search and Filter Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search Bar
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = '';
                        });
                      },
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
                
                const SizedBox(height: 12),
                
                // Filter Row
                Row(
                  children: [
                    // Category Filter
                    Expanded(
                      child: DropdownButtonFormField<ProductCategory?>(
                        value: _selectedCategory,
                        decoration: const InputDecoration(
                          labelText: 'Category',
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        items: [
                          const DropdownMenuItem<ProductCategory?>(
                            value: null,
                            child: Text('All Categories'),
                          ),
                          ...ProductCategory.values.map((category) {
                            return DropdownMenuItem(
                              value: category,
                              child: Text(_getCategoryDisplayName(category)),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                    ),
                    
                    const SizedBox(width: 12),
                    
                    // More Filters Button
                    OutlinedButton.icon(
                      onPressed: _showFiltersBottomSheet,
                      icon: const Icon(Icons.filter_list),
                      label: const Text('Filters'),
                    ),
                    
                    const SizedBox(width: 8),
                    
                    // View Toggle
                    IconButton(
                      icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
                      onPressed: () {
                        setState(() {
                          _isGridView = !_isGridView;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Products List/Grid
          Expanded(
            child: _isGridView ? _buildGridView() : _buildListView(),
          ),
        ],
      ),
    );
  }

  Widget _buildGridView() {
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
        return _buildProductGridCard(context, index);
      },
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 20, // Placeholder count
      itemBuilder: (context, index) {
        return _buildProductListCard(context, index);
      },
    );
  }

  Widget _buildProductGridCard(BuildContext context, int index) {
    return Card(
      child: InkWell(
        onTap: () => _navigateToProductDetail(index),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Expanded(
              flex: 3,
              child: Container(
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
                        Icon(
                          Icons.favorite_border,
                          size: 16,
                          color: Colors.grey[600],
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

  Widget _buildProductListCard(BuildContext context, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () => _navigateToProductDetail(index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Product Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.image,
                  size: 30,
                  color: Colors.grey,
                ),
              ),
              
              const SizedBox(width: 16),
              
              // Product Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Product $index',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'This is a sample product description for product $index.',
                      style: Theme.of(context).textTheme.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          '\$${(index * 10 + 50).toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
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
                      ],
                    ),
                  ],
                ),
              ),
              
              // Action Buttons
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () => _handleSaveProduct(index),
                  ),
                  IconButton(
                    icon: const Icon(Icons.chat_bubble_outline),
                    onPressed: () => _handleMessageSeller(index),
                  ),
                ],
              ),
            ],
          ),
        ),
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

  void _showFiltersBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
                'Filters',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Range',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Price range slider would go here
                    const Placeholder(fallbackHeight: 50),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Location',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Location filter would go here
                    const Placeholder(fallbackHeight: 50),
                    
                    const SizedBox(height: 24),
                    
                    Text(
                      'Condition',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    // Condition filter would go here
                    const Placeholder(fallbackHeight: 100),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Clear'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Apply'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToProductDetail(int index) {
    context.push('/products/product-$index');
  }

  void _handleSaveProduct(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Saved product $index')),
    );
  }

  void _handleMessageSeller(int index) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Message seller for product $index')),
    );
  }
}