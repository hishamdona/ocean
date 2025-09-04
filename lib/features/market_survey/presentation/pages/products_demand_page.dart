import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/post_card.dart';
import '../../../../features/main/presentation/widgets/custom_drawer.dart';

class ProductsDemandPage extends StatelessWidget {
  const ProductsDemandPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Products Demand'),
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
            // TODO: Implement create product demand post
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildMyPostsTab() {
    return ListView.builder(
      itemCount: 1, // Dummy count
      itemBuilder: (context, index) {
        return PostCard(
          userName: 'My Company',
          userAvatarUrl: 'https://i.pravatar.cc/150?u=mycompany',
          postTime: '1d ago',
          productName: 'Bulk T-Shirts',
          newPrice: 'Requesting Quotes',
          brand: 'Any',
          location: 'My Warehouse',
          description: 'Looking to purchase 10,000 units of plain cotton t-shirts. Please send quotes.',
          likeCount: 5,
          commentCount: 8,
          shareCount: 1,
        );
      },
    );
  }

  Widget _buildGlobalTab() {
    return ListView.builder(
      itemCount: 15, // Dummy count
      itemBuilder: (context, index) {
        return PostCard(
          userName: 'Global Buyer $index',
          userAvatarUrl: 'https://i.pravatar.cc/150?u=globalbuyer$index',
          postTime: '${index + 2}d ago',
          productName: 'Demanded Product $index',
          newPrice: 'Quote Requested',
          brand: 'Various',
          location: 'Global',
          description: 'Seeking suppliers for various electronic components. Long-term partnership possible.',
          likeCount: 50 - index * 2,
          commentCount: 15 - index,
          shareCount: 5,
          onFollow: () {},
          onMessage: () {},
        );
      },
    );
  }
}
