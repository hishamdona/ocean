import 'package:flutter/material.dart';
import '../../../../features/main/presentation/widgets/custom_drawer.dart';
import '../../../../features/main/presentation/widgets/custom_bottom_navigation_bar.dart';

class HeavyDistributorsPage extends StatefulWidget {
  const HeavyDistributorsPage({super.key});

  @override
  State<HeavyDistributorsPage> createState() => _HeavyDistributorsPageState();
}

class _HeavyDistributorsPageState extends State<HeavyDistributorsPage> {
  String? _selectedDistributorType;
  String? _selectedLocation;
  final _productNameController = TextEditingController();
  bool _showResults = false;
  List<String> _searchResults = [];

  bool get _isFormFilled =>
      _selectedDistributorType != null &&
      _selectedLocation != null &&
      _productNameController.text.isNotEmpty;

  void _onSearch() {
    if (_isFormFilled) {
      setState(() {
        _showResults = true;
        _searchResults = List.generate(
          5,
          (index) =>
              'Result ${index + 1} for "${_productNameController.text}" in $_selectedLocation',
        );
      });
    }
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text('Heavy Distributors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchForm(),
            if (_showResults) _buildResultsList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Placeholder action
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('FAB placeholder action')),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }

  Widget _buildSearchForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: _selectedDistributorType,
          hint: const Text('Select Distributor Type'),
          items: ['Heavy Distributor', 'Manufacturers', 'Wholesalers', 'Retailers']
              .map((label) => DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedDistributorType = value;
            });
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _productNameController,
          decoration: const InputDecoration(
            labelText: 'Name of product',
            border: OutlineInputBorder(),
          ),
          onChanged: (value) => setState(() {}),
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(
          value: _selectedLocation,
          hint: const Text('Select Location'),
          items: ['Lagos', 'Abuja', 'Kano']
              .map((label) => DropdownMenuItem(
                    value: label,
                    child: Text(label),
                  ))
              .toList(),
          onChanged: (value) {
            setState(() {
              _selectedLocation = value;
            });
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: _isFormFilled ? _onSearch : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: const Text('Search'),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildResultsList() {
    return Expanded(
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(_searchResults[index]),
              subtitle: Text('Some details about distributor ${index + 1}...'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
