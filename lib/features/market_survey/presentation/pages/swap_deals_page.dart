import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../features/main/presentation/widgets/custom_drawer.dart';
import '../../../../features/main/presentation/widgets/custom_bottom_navigation_bar.dart';

class SwapDealsPage extends StatefulWidget {
  const SwapDealsPage({super.key});

  @override
  State<SwapDealsPage> createState() => _SwapDealsPageState();
}

class _SwapDealsPageState extends State<SwapDealsPage> {
  final _productController = TextEditingController();
  final _brandController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedCategory;

  bool get _isFormFilled =>
      _productController.text.isNotEmpty &&
      _brandController.text.isNotEmpty &&
      _descriptionController.text.isNotEmpty &&
      _selectedCategory != null;

  void _onSubmit() {
    if (_isFormFilled) {
      context.push('/swap-vendors');
    }
  }

  @override
  void dispose() {
    _productController.dispose();
    _brandController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Swap Deals'),
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
            _buildUploadSlot(context, 'Upload Image', Icons.image),
            const SizedBox(height: 16),
            _buildUploadSlot(context, 'Upload Video', Icons.videocam),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Supported formats: jpg, png, mp4',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _productController,
              decoration: const InputDecoration(
                labelText: 'Product to be swapped',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: const Text('Select Category'),
              items: ['Electronics', 'Fashion', 'Vehicles']
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
              controller: _brandController,
              decoration: const InputDecoration(
                labelText: 'Brand to be swapped to',
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
              onPressed: _isFormFilled ? _onSubmit : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildUploadSlot(BuildContext context, String text, IconData icon) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.grey),
            const SizedBox(height: 8),
            Text(text),
          ],
        ),
      ),
    );
  }
}
