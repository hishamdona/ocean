import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onNotificationPressed;

  const CustomAppBar({
    super.key,
    required this.onMenuPressed,
    required this.onNotificationPressed,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: onMenuPressed,
      ),
      title: Row(
        children: [
          // Logo placeholder - replace with actual logo
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.waves,
              color: Colors.white,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Ocean',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        // Stories indicator
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.camera_alt_outlined),
                onPressed: () {
                  // Handle stories
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Notifications
        Stack(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: onNotificationPressed,
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}