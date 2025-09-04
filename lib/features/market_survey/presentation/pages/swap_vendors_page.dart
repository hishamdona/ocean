import 'package:flutter/material.dart';
import '../../../../features/main/presentation/widgets/custom_bottom_navigation_bar.dart';

class SwapVendorsPage extends StatelessWidget {
  const SwapVendorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Swap Deals - See vendors'),
      ),
      body: ListView.builder(
        itemCount: 15, // Dummy count
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=vendor$index'),
              ),
              title: Text('Vendor ${index + 1}'),
              subtitle: Text('@vendor_user_${index + 1}'),
              trailing: ElevatedButton(
                onPressed: () {
                  // ignore: avoid_print
                  print('Messaging Vendor ${index + 1}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Messaging Vendor ${index + 1}')),
                  );
                },
                child: const Text('Message'),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
