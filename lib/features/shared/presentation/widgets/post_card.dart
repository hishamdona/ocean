import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PostCardType { home, distress, uploaded }

class PostCard extends StatefulWidget {
  final PostCardType type;
  final String userName;
  final String userAvatarUrl;
  final String postTime;
  final String productName;
  final String? oldPrice;
  final String? newPrice;
  final String brand;
  final String location;
  final String description;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool showFollowButton;
  final bool showMessageButton;
  final VoidCallback? onFollow;
  final VoidCallback? onMessage;
  final VoidCallback? onLike;
  final VoidCallback? onComment;
  final VoidCallback? onShare;
  final VoidCallback? onSave;
  final List<PopupMenuEntry<String>>? popupMenuItems;
  final Function(String)? onPopupMenuItemSelected;

  const PostCard({
    super.key,
    this.type = PostCardType.home,
    required this.userName,
    required this.userAvatarUrl,
    required this.postTime,
    required this.productName,
    this.oldPrice,
    this.newPrice,
    required this.brand,
    required this.location,
    required this.description,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.showFollowButton = true,
    this.showMessageButton = true,
    this.onFollow,
    this.onMessage,
    this.onLike,
    this.onComment,
    this.onShare,
    this.onSave,
    this.popupMenuItems,
    this.onPopupMenuItemSelected,
    this.customAction,
  });

  final Widget? customAction;

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool _isLiked = false;

  void _handleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    if (widget.onLike != null) {
      widget.onLike!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(context),
          if (widget.customAction != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: widget.customAction,
            )
          else if (widget.showMessageButton)
            _buildMessageButton(context),
          _buildProductDetails(context),
          const SizedBox(height: 12),
          _buildImageGrid(context),
          const SizedBox(height: 12),
          _buildDescription(context),
          const SizedBox(height: 12),
          if (widget.type != PostCardType.uploaded) _buildPostActions(context),
          if (widget.type == PostCardType.home) _buildCommentInputRow(context),
        ],
      ),
    );
  }

  Widget _buildPostHeader(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.userAvatarUrl),
        backgroundColor: Colors.grey[300],
      ),
      title: Text(widget.userName),
      subtitle: Text(widget.postTime),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.showFollowButton)
            OutlinedButton(
              onPressed: widget.onFollow,
              child: const Text('Follow'),
            ),
          if (widget.popupMenuItems != null && widget.onPopupMenuItemSelected != null)
            PopupMenuButton<String>(
              itemBuilder: (context) => widget.popupMenuItems!,
              onSelected: widget.onPopupMenuItemSelected,
            ),
        ],
      ),
    );
  }

  Widget _buildMessageButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: ElevatedButton(
        onPressed: widget.onMessage,
        child: const Text('Message Me'),
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 48),
        ),
      ),
    );
  }

  Widget _buildProductDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Product: ${widget.productName}'),
              if (widget.type == PostCardType.distress)
                _buildDistressPrice(context)
              else if (widget.newPrice != null)
                Text(
                  'Price: ${widget.newPrice}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Brand: ${widget.brand}'),
              Text('Location: ${widget.location}'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistressPrice(BuildContext context) {
    return Row(
      children: [
        if (widget.oldPrice != null)
          Text(
            widget.oldPrice!,
            style: const TextStyle(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
        const SizedBox(width: 8),
        if (widget.newPrice != null)
          Text(
            widget.newPrice!,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
              fontSize: 16,
            ),
          ),
      ],
    );
  }

  Widget _buildImageGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemBuilder: (context, index) {
          return Container(
            color: Colors.grey[300],
            child: const Icon(Icons.image, size: 50, color: Colors.grey),
          );
        },
      ),
    );
  }

  Widget _buildDescription(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        widget.description,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
    );
  }

  Widget _buildPostActions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          _buildActionItem(
            context,
            onTap: _handleLike,
            icon: _isLiked ? Icons.favorite : Icons.favorite_border,
            color: _isLiked ? Colors.red : Colors.grey[600],
            text: '${widget.likeCount + (_isLiked ? 1 : 0)}',
          ),
          const SizedBox(width: 24),
          _buildActionItem(
            context,
            onTap: widget.onComment,
            icon: Icons.chat_bubble_outline,
            text: '${widget.commentCount}',
          ),
          const SizedBox(width: 24),
          _buildActionItem(
            context,
            onTap: () => _showShareModal(context),
            icon: Icons.share_outlined,
            text: '${widget.shareCount}',
          ),
          const Spacer(),
          InkWell(
            onTap: widget.onSave,
            child: Icon(Icons.bookmark_border, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
    BuildContext context, {
    required VoidCallback? onTap,
    required IconData icon,
    required String text,
    Color? color,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color ?? Colors.grey[600]),
          const SizedBox(width: 4),
          Text(text),
        ],
      ),
    );
  }

  Widget _buildCommentInputRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        children: [
          const CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Write your comments…',
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(vertical: 4),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.attach_file),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  void _showShareModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Share to', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),
              SizedBox(
                height: 80,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildSocialIcon(FontAwesomeIcons.link, 'Copy Link'),
                    _buildSocialIcon(FontAwesomeIcons.threads, 'Threads'),
                    _buildSocialIcon(FontAwesomeIcons.whatsapp, 'WhatsApp'),
                    _buildSocialIcon(FontAwesomeIcons.pinterest, 'Pinterest'),
                    _buildSocialIcon(FontAwesomeIcons.xTwitter, 'X'),
                    _buildSocialIcon(FontAwesomeIcons.telegram, 'Telegram'),
                    _buildSocialIcon(FontAwesomeIcons.facebook, 'Facebook'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialIcon(IconData icon, String label) {
    return Container(
      width: 80,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(icon, size: 32),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
