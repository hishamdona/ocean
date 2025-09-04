import 'package:flutter/material.dart';
import '../../../shared/presentation/widgets/post_card.dart';
import '../../../../features/main/presentation/widgets/custom_drawer.dart';

class AuctionsPage extends StatelessWidget {
  const AuctionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        drawer: const CustomDrawer(),
        appBar: AppBar(
          title: const Text('Auctions'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'My Auctions'),
              Tab(text: 'Global Auctions'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildMyAuctionsTab(),
            _buildGlobalAuctionsTab(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // TODO: Implement create auction post
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildMyAuctionsTab() {
    return ListView.builder(
      itemCount: 1, // Dummy count
      itemBuilder: (context, index) {
        return PostCard(
          userName: 'My Auction House',
          userAvatarUrl: 'https://i.pravatar.cc/150?u=myauction',
          postTime: 'Ends in 2d 4h',
          productName: 'Vintage Rolex Watch',
          newPrice: 'Current Bid: \$5,400',
          brand: 'Rolex',
          location: 'New York, USA',
          description: 'A rare 1985 Rolex Submariner. Auction is live now. Place your bids!',
          likeCount: 152,
          commentCount: 45,
          shareCount: 22,
        );
      },
    );
  }

  Widget _buildGlobalAuctionsTab() {
    return ListView.builder(
      itemCount: 8, // Dummy count
      itemBuilder: (context, index) {
        return PostCard(
          userName: 'Global Auctioneer $index',
          userAvatarUrl: 'https://i.pravatar.cc/150?u=globalauctioneer$index',
          postTime: 'Ends in ${index + 1}d',
          productName: 'Collectible Item $index',
          newPrice: 'Starting Bid: \$${100 + index * 50}',
          brand: 'Collectible Co.',
          location: 'London, UK',
          description: 'Global auction for rare collectibles. Don\'t miss out.',
          likeCount: 200 - index * 10,
          commentCount: 40 - index * 2,
          shareCount: 20 - index,
          onFollow: () {},
          onMessage: () {},
        );
      },
    );
  }
}
