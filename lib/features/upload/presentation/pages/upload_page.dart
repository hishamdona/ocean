import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/models/user_model.dart';

import 'package:buyit/features/upload/presentation/widgets/uploaded_tab.dart';
import 'package:buyit/features/upload/presentation/widgets/upload_tab.dart';

class UploadPage extends ConsumerWidget {
  const UploadPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);

    if (currentUser?.role != UserRole.seller) {
      return _buildBecomeSellerPage(context);
    }

    if (currentUser?.sellerProfile?.status != SellerStatus.approved) {
      return _buildSellerStatusPage(context, currentUser!.sellerProfile!.status);
    }

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upload'),
              Tab(text: 'Uploaded'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            UploadTab(),
            UploadedTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildBecomeSellerPage(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.store,
              size: 80,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 24),
            Text(
              'Become a Seller',
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Start selling your products on Ocean and reach millions of customers.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            
            // Benefits List
            Column(
              children: [
                _buildBenefitItem(
                  context,
                  Icons.people,
                  'Reach Millions',
                  'Connect with buyers worldwide',
                ),
                _buildBenefitItem(
                  context,
                  Icons.analytics,
                  'Analytics',
                  'Track your sales and performance',
                ),
                _buildBenefitItem(
                  context,
                  Icons.view_in_ar,
                  'AR Support',
                  'Showcase products in augmented reality',
                ),
                _buildBenefitItem(
                  context,
                  Icons.chat,
                  'Direct Chat',
                  'Communicate directly with customers',
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  context.push('/auth/seller-registration');
                },
                child: const Text('Start Selling'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSellerStatusPage(BuildContext context, SellerStatus status) {
    String title;
    String message;
    IconData icon;
    Color color;

    switch (status) {
      case SellerStatus.pending:
        title = 'Application Under Review';
        message = 'Your seller application is being reviewed by our team. '
            'You will be notified once the review is complete.';
        icon = Icons.hourglass_empty;
        color = Colors.orange;
        break;
      case SellerStatus.rejected:
        title = 'Application Rejected';
        message = 'Unfortunately, your seller application was not approved. '
            'Please contact support for more information.';
        icon = Icons.cancel;
        color = Colors.red;
        break;
      case SellerStatus.suspended:
        title = 'Account Suspended';
        message = 'Your seller account has been suspended. '
            'Please contact support to resolve this issue.';
        icon = Icons.block;
        color = Colors.red;
        break;
      default:
        title = 'Unknown Status';
        message = 'Please contact support for assistance.';
        icon = Icons.help;
        color = Colors.grey;
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 80,
              color: color,
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: Theme.of(context).textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (status == SellerStatus.rejected) ...[
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/auth/seller-registration');
                  },
                  child: const Text('Reapply'),
                ),
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton(
                onPressed: () {
                  // Contact support
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Contact support feature not implemented')),
                  );
                },
                child: const Text('Contact Support'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}