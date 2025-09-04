import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/post_card.dart';
import '../../../../features/main/presentation/widgets/custom_drawer.dart';

class DistressSalesPage extends StatelessWidget {
  const DistressSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Distress Sales'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Posts'),
              Tab(text: 'Global'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMyPostsTab(),
            _buildGlobalTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Implement create distress sale post
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildMyPostsTab() {
    // Replace with actual data fetching logic
    return ListView.builder(
      itemCount: 2, // Dummy count
      itemBuilder: (context, index) {
        return PostCard(
          type: PostCardType.distress,
          userName: 'My Store',
          userAvatarUrl: 'https://i.pravatar.cc/150?u=mystore',
          postTime: '${index + 1}h ago',
          productName: 'Samsung Galaxy S22',
          oldPrice: '\$899.99',
          newPrice: '\$649.99',
          brand: 'Samsung',
          location: 'My City, My Country',
          description: 'Urgent sale! Clearing stock. Phone is in pristine condition.',
          likeCount: 15,
          commentCount: 4,
          shareCount: 2,
        );
      },
    );
  }

  Widget _buildGlobalTab() {
    // Replace with actual data fetching logic
    return ListView.builder(
      itemCount: 10, // Dummy count
      itemBuilder: (context, index) {
        return PostCard(
          type: PostCardType.distress,
          userName: 'Global Seller $index',
          userAvatarUrl: 'https://i.pravatar.cc/150?u=globalseller$index',
          postTime: '${index * 2}h ago',
          productName: 'Product on Sale $index',
          oldPrice: '\$${200 + index * 10}',
          newPrice: '\$${150 + index * 5}',
          brand: 'Global Brand',
          location: 'Global Location',
          description: 'This is a global distress sale. Get it before it\'s gone!',
          likeCount: 120 - index * 5,
          commentCount: 30 - index,
          shareCount: 15 - index,
          onFollow: () {},
          onMessage: () {},
        );
      },
    );
  }
}
