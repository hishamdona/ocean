import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/providers/auth_provider.dart';
import '../../../../core/models/user_model.dart';

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

    return _buildUploadProductPage(context);
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

  Widget _buildUploadProductPage(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Upload Product',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Add a new product to your store',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Product Images
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Images',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),
                            Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_photo_alternate,
                                    size: 48,
                                    color: Colors.grey[400],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Tap to add images',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Product Details Form
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Product Details',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 16),

                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Product Name',
                                hintText: 'Enter product name',
                              ),
                            ),

                            const SizedBox(height: 16),

                            TextFormField(
                              maxLines: 3,
                              decoration: const InputDecoration(
                                labelText: 'Description',
                                hintText: 'Describe your product',
                              ),
                            ),

                            const SizedBox(height: 16),

                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Price',
                                      hintText: '0.00',
                                      prefixText: '\$ ',
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: 'Quantity',
                                      hintText: '1',
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 16),

                            DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Category',
                              ),
                              items: const [
                                DropdownMenuItem(value: 'electronics', child: Text('Electronics')),
                                DropdownMenuItem(value: 'fashion', child: Text('Fashion')),
                                DropdownMenuItem(value: 'home', child: Text('Home & Garden')),
                                DropdownMenuItem(value: 'sports', child: Text('Sports & Outdoors')),
                              ],
                              onChanged: (value) {},
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // AR Model Upload
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AR Model (Optional)',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Upload a .glb file to enable AR viewing',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('AR model upload not implemented')),
                                );
                              },
                              icon: const Icon(Icons.view_in_ar),
                              label: const Text('Upload AR Model'),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Upload Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Product upload not implemented')),
                          );
                        },
                        child: const Text('Upload Product'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}