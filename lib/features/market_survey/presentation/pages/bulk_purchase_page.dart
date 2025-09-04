import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/main/presentation/widgets/custom_drawer.dart';
import '../../../../features/main/presentation/widgets/custom_bottom_navigation_bar.dart';

class BulkPurchasePage extends StatefulWidget {
  const BulkPurchasePage({super.key});

  @override
  State<BulkPurchasePage> createState() => _BulkPurchasePageState();
}

class _BulkPurchasePageState extends State<BulkPurchasePage> {
  final _productNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  bool get _isFormFilled =>
      (_selectedCategory != null && _productNameController.text.isNotEmpty) ||
      _descriptionController.text.isNotEmpty;

  void _onSearch() {
    if (_isFormFilled) {
      // Simulate a search result. In a real app, you might find no results.
      final bool hasResults = _productNameController.text.toLowerCase() != 'nonexistent';
      if (hasResults) {
        context.push('/bulk-purchase-details');
      } else {
        context.push('/bulk-purchase-oops');
      }
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Bulk Purchase (Group Buy)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildUploadSlot(context),
            const SizedBox(height: 16),
            const Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('OR'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              items: ['Electronics', 'Fashion', 'Groceries', 'Home Goods']
                  .map((label) => DropdownMenuItem(
                        value: label,
                        child: Text(label),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: 'Product Name',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
               onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _isFormFilled ? _onSearch : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Search'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildUploadSlot(BuildContext context) {
    return Container(
      height: 120,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.upload_file, size: 40, color: Colors.grey),
            SizedBox(height: 8),
            Text('Upload an image of the product'),
          ],
        ),
      ),
    );
  }
}
