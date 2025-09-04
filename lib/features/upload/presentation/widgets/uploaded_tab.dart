import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/post_card.dart';

class UploadedTab extends StatefulWidget {
  const UploadedTab({super.key});

  @override
  State<UploadedTab> createState() => _UploadedTabState();
}

class _UploadedTabState extends State<UploadedTab> {
  // Dummy data for products
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Nike Sneakers',
      'brand': 'Nike',
      'price': '\$120.00',
      'location': 'New York, USA',
      'description': 'Brand new Nike running shoes, size 10. Perfect for athletes.',
      'user': 'Seller123',
      'time': '2 days ago',
      'avatar': 'https://i.pravatar.cc/150?u=nike'
    },
    {
      'id': '2',
      'name': 'iPhone 14 Pro',
      'brand': 'Apple',
      'price': '\$999.00',
      'location': 'San Francisco, USA',
      'description': 'Slightly used iPhone 14 Pro, 256GB, in midnight black. No scratches.',
      'user': 'TechGuru',
      'time': '5 days ago',
      'avatar': 'https://i.pravatar.cc/150?u=apple'
    },
    {
      'id': '3',
      'name': 'Sony WH-1000XM5 Headphones',
      'brand': 'Sony',
      'price': '\$350.00',
      'location': 'Tokyo, Japan',
      'description': 'Noise-cancelling headphones with amazing sound quality. Comes with all accessories.',
      'user': 'AudioPhile',
      'time': '1 week ago',
      'avatar': 'https://i.pravatar.cc/150?u=sony'
    },
  ];

  void _handleMenuAction(String action, String productId) {
    switch (action) {
      case 'delete':
        setState(() {
          _products.removeWhere((product) => product['id'] == productId);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Product deleted.'),
            backgroundColor: Colors.red,
          ),
        );
        break;
      case 'convert_auction':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product converted to Auction.')),
        );
        break;
      case 'convert_distress':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product converted to Distress Sale.')),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          return PostCard(
            type: PostCardType.uploaded,
            userName: product['user'],
            userAvatarUrl: product['avatar'],
            postTime: product['time'],
            productName: product['name'],
            newPrice: product['price'],
            brand: product['brand'],
            location: product['location'],
            description: product['description'],
            showFollowButton: false,
            showMessageButton: false,
            popupMenuItems: [
              const PopupMenuItem(
                value: 'convert_auction',
                child: Text('Convert to Auction'),
              ),
              const PopupMenuItem(
                value: 'convert_distress',
                child: Text('Convert to Distress Sale'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete', style: TextStyle(color: Colors.red)),
              ),
            ],
            onPopupMenuItemSelected: (value) => _handleMenuAction(value, product['id']),
          );
        },
      ),
    );
  }
}
