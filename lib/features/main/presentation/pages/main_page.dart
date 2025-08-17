import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_drawer.dart';

class MainPage extends ConsumerStatefulWidget {
  final Widget child;
  
  const MainPage({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _getCurrentIndex(String location) {
    if (location == '/') return 0;
    if (location.startsWith('/products')) return 1;
    if (location == '/upload') return 2;
    if (location == '/saved') return 3;
    if (location.startsWith('/chats')) return 4;
    return 0;
  }

  void _onTabTapped(int index) {
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

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final currentIndex = _getCurrentIndex(location);

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onNotificationPressed: () {
          // Handle notification tap
        },
      ),
      drawer: const CustomDrawer(),
      body: widget.child,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onTap: _onTabTapped,
      ),
      floatingActionButton: currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                // Handle create post
                _showCreatePostBottomSheet(context);
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showCreatePostBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.4,
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
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildPostOption(
                    context,
                    'Product Demand',
                    'Post about products you need',
                    Icons.search,
                  ),
                  _buildPostOption(
                    context,
                    'Bulk Purchase',
                    'Looking for bulk quantities',
                    Icons.inventory,
                  ),
                  _buildPostOption(
                    context,
                    'Distress Sales',
                    'Quick sale at reduced prices',
                    Icons.flash_on,
                  ),
                  _buildPostOption(
                    context,
                    'Heavy Distributors',
                    'Connect with major distributors',
                    Icons.business,
                  ),
                  _buildPostOption(
                    context,
                    'Swap Deals',
                    'Exchange products with others',
                    Icons.swap_horiz,
                  ),
                  _buildPostOption(
                    context,
                    'Auctions',
                    'Start or join auctions',
                    Icons.gavel,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPostOption(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: () {
        Navigator.pop(context);
        // Handle post creation based on type
      },
    );
  }
}