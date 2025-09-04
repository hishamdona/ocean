import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../shared/presentation/widgets/post_card.dart';

class BulkPurchaseDetailsPage extends StatelessWidget {
  const BulkPurchaseDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Group Buys'),
      ),
      body: ListView.builder(
        itemCount: 5, // Dummy count
        itemBuilder: (context, index) {
          return PostCard(
            userName: 'Supplier ${index + 1}',
            userAvatarUrl: 'https://i.pravatar.cc/150?u=supplier$index',
            postTime: 'Posted ${index + 1}d ago',
            productName: 'Sought-After Product',
            newPrice: 'Group Price: \$${100 - index * 5}',
            brand: 'Popular Brand',
            location: 'Supplier Hub',
            description: 'High-quality product available for bulk purchase. Join the group to get a discount!',
            likeCount: 75 - index * 3,
            commentCount: 20 - index,
            shareCount: 10,
            showFollowButton: false, // As per spec, no follow/message
            showMessageButton: false,
            customAction: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.people_alt_outlined),
                label: const Text('See Waitlist'),
                onPressed: () {
                  context.push('/bulk-purchase-waitlist');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
