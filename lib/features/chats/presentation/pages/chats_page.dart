import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChatsPage extends ConsumerStatefulWidget {
  const ChatsPage({super.key});

  @override
  ConsumerState<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends ConsumerState<ChatsPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search conversations...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Chats List
          Expanded(
            child: ListView.builder(
              itemCount: 15, // Placeholder count
              itemBuilder: (context, index) {
                return _buildChatListItem(context, index);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewChatBottomSheet(context);
        },
        child: const Icon(Icons.chat),
      ),
    );
  }

  Widget _buildChatListItem(BuildContext context, int index) {
    final isUnread = index % 3 == 0; // Simulate unread messages
    final lastMessageTime = DateTime.now().subtract(Duration(hours: index + 1));
    
    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Text('U$index'),
          ),
          if (index % 5 == 0) // Simulate online status
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    width: 2,
                  ),
                ),
              ),
            ),
        ],
      ),
      title: Row(
        children: [
          Expanded(
            child: Text(
              'User $index',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Text(
            timeago.format(lastMessageTime),
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: isUnread 
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.grey[600],
            ),
          ),
        ],
      ),
      subtitle: Row(
        children: [
          if (index % 4 == 0) // Simulate sent messages
            Icon(
              Icons.done_all,
              size: 16,
              color: Colors.blue[600],
            ),
          if (index % 4 == 0) const SizedBox(width: 4),
          Expanded(
            child: Text(
              _getLastMessage(index),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: isUnread ? FontWeight.w500 : FontWeight.normal,
                color: isUnread ? null : Colors.grey[600],
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isUnread)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${index % 5 + 1}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
      onTap: () {
        context.push('/chats/chat-$index');
      },
      onLongPress: () {
        _showChatOptions(context, index);
      },
    );
  }

  String _getLastMessage(int index) {
    final messages = [
      'Hey, is this product still available?',
      'Thanks for the quick response!',
      'Can you send more photos?',
      'What\'s the best price you can offer?',
      'I\'m interested in bulk purchase',
      'When can you deliver?',
      'Product looks great in AR view!',
      'Let me know if you have other colors',
      'Perfect! I\'ll take it',
      'Can we negotiate the price?',
    ];
    return messages[index % messages.length];
  }

  void _showChatOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.mark_chat_read),
            title: const Text('Mark as Read'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Marked chat $index as read')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications_off),
            title: const Text('Mute Notifications'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Muted notifications for chat $index')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete Chat', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showDeleteConfirmation(context, index);
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Chat'),
        content: const Text('Are you sure you want to delete this conversation? This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deleted chat $index')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showNewChatBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
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
                'New Chat',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Search users...',
                  prefixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  // Implement user search
                },
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 10, // Placeholder count
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      child: Text('U$index'),
                    ),
                    title: Text('User $index'),
                    subtitle: Text('Last seen ${index + 1} hours ago'),
                    onTap: () {
                      Navigator.pop(context);
                      context.push('/chats/new-chat-$index');
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}