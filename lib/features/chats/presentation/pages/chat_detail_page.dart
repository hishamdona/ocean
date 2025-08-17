import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatDetailPage extends ConsumerStatefulWidget {
  final String chatId;
  
  const ChatDetailPage({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends ConsumerState<ChatDetailPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadMessages() {
    // Simulate loading messages
    final sampleMessages = [
      {
        'id': '1',
        'text': 'Hey, is this product still available?',
        'isMe': false,
        'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
        'status': 'read',
      },
      {
        'id': '2',
        'text': 'Yes, it\'s still available! Are you interested?',
        'isMe': true,
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        'status': 'read',
      },
      {
        'id': '3',
        'text': 'Can you send more photos of the product?',
        'isMe': false,
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        'status': 'read',
      },
      {
        'id': '4',
        'text': 'Sure! Let me take some more photos for you.',
        'isMe': true,
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        'status': 'delivered',
      },
      {
        'id': '5',
        'text': 'Here are some additional photos',
        'isMe': true,
        'timestamp': DateTime.now().subtract(const Duration(hours: 1, minutes: 40)),
        'status': 'sent',
        'hasImage': true,
      },
    ];
    
    setState(() {
      _messages.addAll(sampleMessages);
    });
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 18,
              child: const Icon(Icons.person, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User ${widget.chatId.split('-').last}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    'Online',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Video call not implemented')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Voice call not implemented')),
              );
            },
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'view_profile',
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('View Profile'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'mute',
                child: ListTile(
                  leading: Icon(Icons.notifications_off),
                  title: Text('Mute'),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'block',
                child: ListTile(
                  leading: Icon(Icons.block, color: Colors.red),
                  title: Text('Block User', style: TextStyle(color: Colors.red)),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
            onSelected: (value) {
              _handleMenuAction(value.toString());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages List
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return _buildMessageBubble(_messages[index]);
              },
            ),
          ),
          
          // Message Input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Attachment Button
                IconButton(
                  icon: const Icon(Icons.attach_file),
                  onPressed: () {
                    _showAttachmentOptions(context);
                  },
                ),
                
                // Message Input Field
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                    ),
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                ),
                
                const SizedBox(width: 8),
                
                // Send Button
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message['isMe'] as bool;
    final timestamp = message['timestamp'] as DateTime;
    final hasImage = message['hasImage'] as bool? ?? false;
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) ...[
            CircleAvatar(
              backgroundColor: Colors.grey[300],
              radius: 16,
              child: const Icon(Icons.person, size: 16),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isMe 
                    ? Theme.of(context).colorScheme.secondary
                    : Colors.grey[200],
                borderRadius: BorderRadius.circular(18).copyWith(
                  bottomLeft: isMe ? const Radius.circular(18) : const Radius.circular(4),
                  bottomRight: isMe ? const Radius.circular(4) : const Radius.circular(18),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage) ...[
                    Container(
                      width: 200,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.image,
                        size: 40,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                  Text(
                    message['text'] as String,
                    style: TextStyle(
                      color: isMe ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}',
                        style: TextStyle(
                          color: isMe ? Colors.white70 : Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          _getStatusIcon(message['status'] as String),
                          size: 16,
                          color: Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (isMe) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
              radius: 16,
              child: Icon(
                Icons.person,
                size: 16,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'sent':
        return Icons.done;
      case 'delivered':
        return Icons.done_all;
      case 'read':
        return Icons.done_all;
      default:
        return Icons.schedule;
    }
  }

  void _sendMessage() {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;

    final newMessage = {
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'text': text,
      'isMe': true,
      'timestamp': DateTime.now(),
      'status': 'sent',
    };

    setState(() {
      _messages.add(newMessage);
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate message status updates
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        newMessage['status'] = 'delivered';
      });
    });

    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        newMessage['status'] = 'read';
      });
    });
  }

  void _showAttachmentOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.photo_camera),
            title: const Text('Camera'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Camera not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.photo_library),
            title: const Text('Gallery'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gallery not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Location'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Location sharing not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag),
            title: const Text('Product'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Product sharing not implemented')),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _handleMenuAction(String action) {
    switch (action) {
      case 'view_profile':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('View profile not implemented')),
        );
        break;
      case 'mute':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Chat muted')),
        );
        break;
      case 'block':
        _showBlockConfirmation();
        break;
    }
  }

  void _showBlockConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Block User'),
        content: const Text('Are you sure you want to block this user? You won\'t receive messages from them.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User blocked')),
              );
            },
            child: const Text('Block', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}