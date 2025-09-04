import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../main/presentation/widgets/custom_bottom_navigation_bar.dart';

class SwapVendorsPage extends ConsumerWidget {
  const SwapVendorsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        title: const Text('Swap Deals - See vendors available to swap'),
      ),
      body: ListView.builder(
        itemCount: 5, // Dummy count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey[300],
                child: Text('V${index + 1}'),
              ),
              title: Text('Vendor Name ${index + 1}'),
              subtitle: Text('@vendorusername${index + 1}'),
              trailing: ElevatedButton(
                onPressed: () {
                  print('Message Vendor Name ${index + 1}');
                },
                child: const Text('Message'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: -1, // No active tab
        onTap: onTabTapped,
      ),
    );
  }
}
