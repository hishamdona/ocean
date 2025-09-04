import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/auth_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Drawer(
      child: Column(
        children: [
          // User Profile Header
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
            ),
            currentAccountPicture: CircleAvatar(
              backgroundImage: currentUser?.profilePicture != null
                  ? NetworkImage(currentUser!.profilePicture!)
                  : null,
              child: currentUser?.profilePicture == null
                  ? Text(
                      currentUser?.fullName.substring(0, 1).toUpperCase() ?? 'U',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            accountName: Text(
              currentUser?.fullName ?? 'User',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            accountEmail: Text(currentUser?.email ?? ''),
            otherAccountsPictures: [
              Text(
                '${currentUser?.postsCount ?? 0}\nPosts',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${currentUser?.followersCount ?? 0}\nFollowers',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '${currentUser?.followingCount ?? 0}\nFollowing',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          
          // Market Survey Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildSectionHeader(context, 'Market Survey'),
                _buildDrawerItem(
                  context,
                  'Products Demand',
                  Icons.search,
                  () => _navigateToMarketSurvey(context, 'demand'),
                ),
                _buildDrawerItem(
                  context,
                  'Distress Sales',
                  Icons.flash_on,
                  () => _navigateToMarketSurvey(context, 'distress'),
                ),
                _buildDrawerItem(
                  context,
                  'Heavy Distributors',
                  Icons.business,
                  () => _navigateToMarketSurvey(context, 'distributors'),
                ),
                _buildDrawerItem(
                  context,
                  'Swap Deals',
                  Icons.swap_horiz,
                  () => _navigateToMarketSurvey(context, 'swap'),
                ),
                _buildDrawerItem(
                  context,
                  'Bulk Purchases',
                  Icons.inventory,
                  () => _navigateToMarketSurvey(context, 'bulk'),
                ),
                _buildDrawerItem(
                  context,
                  'Auctions',
                  Icons.gavel,
                  () => _navigateToMarketSurvey(context, 'auctions'),
                ),
                
                const Divider(),
                
                _buildDrawerItem(
                  context,
                  'Profile',
                  Icons.person,
                  () => context.push('/profile'),
                ),
                _buildDrawerItem(
                  context,
                  'Settings',
                  Icons.settings,
                  () => context.push('/settings'),
                ),
              ],
            ),
          ),
          
          // Sign Out
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () {
              _showSignOutDialog(context, ref);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }

  void _navigateToMarketSurvey(BuildContext context, String section) {
    context.push('/market-survey?section=$section');
  }

  void _showSignOutDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context); // Close drawer
              ref.read(authControllerProvider.notifier).signOut();
            },
            child: const Text(
              'Sign Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}