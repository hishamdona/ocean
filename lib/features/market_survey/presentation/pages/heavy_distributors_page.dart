import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../main/presentation/widgets/custom_app_bar.dart';
import '../../../main/presentation/widgets/custom_bottom_navigation_bar.dart';
import '../../../main/presentation/widgets/custom_drawer.dart';

class HeavyDistributorsPage extends ConsumerStatefulWidget {
  const HeavyDistributorsPage({super.key});

  @override
  ConsumerState<HeavyDistributorsPage> createState() =>
      _HeavyDistributorsPageState();
}

class _HeavyDistributorsPageState extends ConsumerState<HeavyDistributorsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String? _selectedCategory = 'Heavy Distributor';
  final List<String> _categories = [
    'Heavy Distributor',
    'Manufacturer',
    'Wholesaler',
    'Retailer'
  ];

  String? _selectedLocation;
  final List<String> _locations = ['Lagos', 'Abuja', 'Kano'];

  final TextEditingController _productNameController = TextEditingController();
  bool _isFormValid = false;
  bool _showResults = false;

  @override
  void initState() {
    super.initState();
    _productNameController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _productNameController.removeListener(_validateForm);
    _productNameController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _selectedCategory != null &&
          _selectedLocation != null &&
          _productNameController.text.isNotEmpty;
    });
  }

  void _performSearch() {
    setState(() {
      _showResults = true;
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
        title: 'Heavy Distributors',
        onMenuPressed: () => _scaffoldKey.currentState?.openDrawer(),
        onNotificationPressed: () {
          // Handle notification tap
        },
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              decoration: const InputDecoration(
                labelText: 'Category',
                border: OutlineInputBorder(),
              ),
              items: _categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                  _validateForm();
                });
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _productNameController,
              decoration: const InputDecoration(
                labelText: 'Name of product',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedLocation,
              decoration: const InputDecoration(
                labelText: 'Location',
                border: OutlineInputBorder(),
              ),
              hint: const Text('Select location'),
              items: _locations.map((String location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(location),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLocation = newValue;
                  _validateForm();
                });
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isFormValid ? _performSearch : null,
                child: const Text('Search'),
              ),
            ),
            if (_showResults)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: ListView.builder(
                    itemCount: 10, // dummy count
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          title: Text(
                              'Result for ${_productNameController.text} in $_selectedLocation'),
                          subtitle: Text('Distributor ${index + 1}'),
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: -1, // No active tab
        onTap: _onTabTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Create new distributor post');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
