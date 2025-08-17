import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/auth_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit profile not implemented')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  // Profile Picture
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[300],
                        backgroundImage: currentUser?.profilePicture != null
                            ? NetworkImage(currentUser!.profilePicture!)
                            : null,
                        child: currentUser?.profilePicture == null
                            ? Text(
                                currentUser?.fullName.substring(0, 1).toUpperCase() ?? 'U',
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 3,
                            ),
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.camera_alt, color: Colors.white),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Change profile picture not implemented')),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Name and Verification
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        currentUser?.fullName ?? 'User',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                      if (currentUser?.isVerified == true) ...[
                        const SizedBox(width: 8),
                        Icon(
                          Icons.verified,
                          color: Theme.of(context).colorScheme.secondary,
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Email
                  Text(
                    currentUser?.email ?? '',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Bio
                  if (currentUser?.bio != null) ...[
                    Text(
                      currentUser!.bio!,
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                  
                  // Stats
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatItem(
                        context,
                        'Posts',
                        currentUser?.postsCount.toString() ?? '0',
                      ),
                      _buildStatItem(
                        context,
                        'Followers',
                        currentUser?.followersCount.toString() ?? '0',
                      ),
                      _buildStatItem(
                        context,
                        'Following',
                        currentUser?.followingCount.toString() ?? '0',
                      ),
                    ],
                  ),
                ],
              ),
            ),
            
            const Divider(),
            
            // Profile Options
            _buildProfileOption(
              context,
              Icons.person_outline,
              'Edit Profile',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile not implemented')),
                );
              },
            ),
            
            _buildProfileOption(
              context,
              Icons.shopping_bag_outlined,
              'My Products',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('My products not implemented')),
                );
              },
            ),
            
            _buildProfileOption(
              context,
              Icons.favorite_outline,
              'Liked Posts',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Liked posts not implemented')),
                );
              },
            ),
            
            _buildProfileOption(
              context,
              Icons.analytics_outlined,
              'Analytics',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Analytics not implemented')),
                );
              },
            ),
            
            _buildProfileOption(
              context,
              Icons.payment_outlined,
              'Payment Methods',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Payment methods not implemented')),
                );
              },
            ),
            
            _buildProfileOption(
              context,
              Icons.security_outlined,
              'Privacy & Security',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Privacy & security not implemented')),
                );
              },
            ),
            
            _buildProfileOption(
              context,
              Icons.help_outline,
              'Help & Support',
              () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Help & support not implemented')),
                );
              },
            ),
            
            const Divider(),
            
            _buildProfileOption(
              context,
              Icons.logout,
              'Sign Out',
              () {
                _showSignOutDialog(context, ref);
              },
              textColor: Colors.red,
            ),
            
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildProfileOption(
    BuildContext context,
    IconData icon,
    String title,
    VoidCallback onTap, {
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: textColor,
      ),
      title: Text(
        title,
        style: TextStyle(color: textColor),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
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