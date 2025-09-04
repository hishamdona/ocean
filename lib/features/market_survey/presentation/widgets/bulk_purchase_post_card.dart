import 'package:flutter/material.dart';

class BulkPurchasePostCard extends StatelessWidget {
  const BulkPurchasePostCard({
    super.key,
    required this.productName,
    required this.brand,
    required this.price,
    required this.location,
    required this.description,
    required this.onSeeWaitlist,
  });

  final String productName;
  final String brand;
  final double price;
  final String location;
  final String description;
  final VoidCallback onSeeWaitlist;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Seller Name', style: TextStyle(fontWeight: FontWeight.bold)),
                    Text('@seller_username', style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            // For now, no image grid as it adds complexity.
            // Will add if user insists.
            Text(
              productName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text('Brand: $brand'),
            const SizedBox(height: 4),
            Text('Price: \$${price.toStringAsFixed(2)}'),
            const SizedBox(height: 4),
            Text('Location: $location'),
            const SizedBox(height: 16),
            Text(description),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onSeeWaitlist,
                child: const Text('See Waitlist'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
