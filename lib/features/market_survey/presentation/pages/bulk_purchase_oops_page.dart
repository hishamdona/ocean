import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../main/presentation/widgets/custom_bottom_navigation_bar.dart';

class BulkPurchaseOopsPage extends StatelessWidget {
  const BulkPurchaseOopsPage({super.key});

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
        title: const Text('Bulk Purchase'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 100,
                color: Colors.grey,
              ),
              const SizedBox(height: 32),
              Text(
                'Oops! No vendors or groups found for this product.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.pop(),
                      child: const Text('Cancel'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Potentially navigate to a different search or back to the main bulk purchase page
                        context.go('/market-survey/bulk-purchase');
                      },
                      child: const Text('Continue'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: -1, // No active tab
        onTap: onTabTapped,
      ),
    );
  }
}
