import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/models/user_model.dart';

class SellerRegistrationPage extends ConsumerStatefulWidget {
  const SellerRegistrationPage({super.key});

  @override
  ConsumerState<SellerRegistrationPage> createState() => _SellerRegistrationPageState();
}

class _SellerRegistrationPageState extends ConsumerState<SellerRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _businessLocationController = TextEditingController();
  final _businessPhoneController = TextEditingController();
  final _businessEmailController = TextEditingController();
  final _businessDescriptionController = TextEditingController();
  final _businessWebsiteController = TextEditingController();
  
  BusinessCategory _selectedCategory = BusinessCategory.retailer;
  final List<String> _businessDocuments = [];
  String? _personalIdPath;

  @override
  void dispose() {
    _businessNameController.dispose();
    _businessLocationController.dispose();
    _businessPhoneController.dispose();
    _businessEmailController.dispose();
    _businessDescriptionController.dispose();
    _businessWebsiteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seller Registration'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Text(
                'Complete Your Seller Profile',
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Provide your business information to start selling',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 32),
              
              // Business Name
              TextFormField(
                controller: _businessNameController,
                decoration: const InputDecoration(
                  labelText: 'Business Name *',
                  hintText: 'Enter your business name',
                  prefixIcon: Icon(Icons.business),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business name';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Business Category
              DropdownButtonFormField<BusinessCategory>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Business Category *',
                  prefixIcon: Icon(Icons.category),
                ),
                items: BusinessCategory.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(_getCategoryDisplayName(category)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              
              const SizedBox(height: 16),
              
              // Business Location
              TextFormField(
                controller: _businessLocationController,
                decoration: const InputDecoration(
                  labelText: 'Business Location *',
                  hintText: 'Enter your business location',
                  prefixIcon: Icon(Icons.location_on),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business location';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Business Phone
              TextFormField(
                controller: _businessPhoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Business Phone *',
                  hintText: 'Enter your business phone',
                  prefixIcon: Icon(Icons.phone),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business phone';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Business Email
              TextFormField(
                controller: _businessEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Business Email *',
                  hintText: 'Enter your business email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your business email';
                  }
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Business Description (Optional)
              TextFormField(
                controller: _businessDescriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Business Description',
                  hintText: 'Describe your business (optional)',
                  prefixIcon: Icon(Icons.description),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Business Website (Optional)
              TextFormField(
                controller: _businessWebsiteController,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  labelText: 'Business Website',
                  hintText: 'Enter your website URL (optional)',
                  prefixIcon: Icon(Icons.web),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Document Upload Section
              Text(
                'Documents',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              
              // Business Documents (Optional)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Business Documents (Optional)',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upload business registration, CAC certificate, etc.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _pickBusinessDocuments,
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Upload Documents'),
                      ),
                      if (_businessDocuments.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        Text('${_businessDocuments.length} document(s) selected'),
                      ],
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Personal ID (Required)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal ID *',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Upload a valid government-issued ID',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 16),
                      OutlinedButton.icon(
                        onPressed: _pickPersonalId,
                        icon: const Icon(Icons.badge),
                        label: const Text('Upload Personal ID'),
                      ),
                      if (_personalIdPath != null) ...[
                        const SizedBox(height: 8),
                        Text('ID document selected'),
                      ],
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Submit Button
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _handleSubmit,
                  child: const Text('Submit for Review'),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Info Text
              Text(
                'Your application will be reviewed by our team. You will be notified once approved.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getCategoryDisplayName(BusinessCategory category) {
    switch (category) {
      case BusinessCategory.retailer:
        return 'Retailer';
      case BusinessCategory.wholesaler:
        return 'Wholesaler';
      case BusinessCategory.manufacturer:
        return 'Manufacturer';
      case BusinessCategory.distributor:
        return 'Distributor';
    }
  }

  void _pickBusinessDocuments() {
    // Implement file picker for business documents
    // This would use file_picker package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File picker not implemented yet')),
    );
  }

  void _pickPersonalId() {
    // Implement file picker for personal ID
    // This would use file_picker package
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('File picker not implemented yet')),
    );
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      if (_personalIdPath == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload your personal ID'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // TODO: Submit seller registration
      // This would create a SellerProfile and update the user
      
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Application Submitted'),
          content: const Text(
            'Your seller application has been submitted for review. '
            'You will be notified once it has been processed.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/');
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}