import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/bulk_purchase_post_card.dart';
import '../../../main/presentation/widgets/custom_bottom_navigation_bar.dart';

class BulkPurchaseDetailsPage extends StatelessWidget {
  const BulkPurchaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    void onTabTapped(int index) {
      switch (index) {
        case 0:
          context.go('/');
          break;
        case 1:
          context.go('/products');
          break;
        case 2:
          context.go('/upload');
          break;
        case 3:
          context.go('/saved');
          break;
        case 4:
          context.go('/chats');
          break;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Purchase Details'),
      ),
      body: ListView.builder(
        itemCount: 10, // dummy count
        itemBuilder: (context, index) {
          return BulkPurchasePostCard(
            productName: 'Product Name ${index + 1}',
            brand: 'Brand ${index + 1}',
            price: (index + 1) * 10.0,
            location: 'Location ${index + 1}',
            description: 'This is a sample description for product ${index + 1}.',
            onSeeWaitlist: () {
              context.push('/market-survey/bulk-purchase/waitlist');
            },
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: -1, // No active tab
        onTap: onTabTapped,
      ),
    );
  }
}
