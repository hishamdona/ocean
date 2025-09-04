import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../main/presentation/widgets/custom_app_bar.dart';
import '../../../main/presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../../main/presentation/widgets/custom_drawer.dart';

class SwapDealsPage extends ConsumerStatefulWidget {
  const SwapDealsPage({super.key});

  @override
  ConsumerState<SwapDealsPage> createState() => _SwapDealsPageState();
}

class _SwapDealsPageState extends ConsumerState<SwapDealsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory;
  final List<String> _categories = ['Electronics', 'Fashion', 'Vehicles'];
  final TextEditingController _productController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    _productController.addListener(_validateForm);
    _brandController.addListener(_validateForm);
    _descriptionController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _productController.dispose();
    _brandController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  void _onTabTapped(int index) {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomAppBar(
        title: 'Swap Deals',
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onNotificationPressed: () {},
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          onChanged: _validateForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildUploadSlot(context, 'Upload Image'),
              const SizedBox(height: 16),
              _buildUploadSlot(context, 'Upload Video'),
              const SizedBox(height: 8),
              const Text(
                'Supported formats: jpg, png, mp4',
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _productController,
                decoration: const InputDecoration(
                  labelText: 'Product to be swapped',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a product' : null,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category of item to swap to',
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Select category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _brandController,
                decoration: const InputDecoration(
                  labelText: 'Brand to be swapped to',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a brand' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 4,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isFormValid
                      ? () => context.push('/market-survey/swap-deals/vendors')
                      : null,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: -1,
        onTap: _onTabTapped,
      ),
    );
  }

  Widget _buildUploadSlot(BuildContext context, String label) {
    return Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400, width: 1.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            label.contains('Image') ? Icons.image_outlined : Icons.videocam_outlined,
            color: Colors.grey.shade600,
            size: 36,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }
}
