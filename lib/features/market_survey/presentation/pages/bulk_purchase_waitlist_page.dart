import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BulkPurchaseWaitlistPage extends StatelessWidget {
  const BulkPurchaseWaitlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulk Purchase Waitlist'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 15, // dummy count
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Text('U${index + 1}'),
                  ),
                  title: Text('User Name ${index + 1}'),
                  subtitle: Text('@username${index + 1}'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
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
                      // Navigate to a dummy chat screen
                      context.push('/chats/group_chat_123');
                    },
                    child: const Text('Join Group'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
