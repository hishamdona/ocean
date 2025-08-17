import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/theme_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          // Appearance Section
          _buildSectionHeader(context, 'Appearance'),
          ListTile(
            leading: const Icon(Icons.palette),
            title: const Text('Theme'),
            subtitle: Text(_getThemeModeText(themeMode)),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showThemeDialog(context, ref);
            },
          ),
          
          const Divider(),
          
          // Notifications Section
          _buildSectionHeader(context, 'Notifications'),
          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Push Notifications'),
            subtitle: const Text('Receive notifications for messages and updates'),
            value: true, // Placeholder value
            onChanged: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Push notifications ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.email),
            title: const Text('Email Notifications'),
            subtitle: const Text('Receive email updates'),
            value: false, // Placeholder value
            onChanged: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Email notifications ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          SwitchListTile(
            secondary: const Icon(Icons.campaign),
            title: const Text('Marketing Notifications'),
            subtitle: const Text('Receive promotional offers'),
            value: true, // Placeholder value
            onChanged: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Marketing notifications ${value ? 'enabled' : 'disabled'}')),
              );
            },
          ),
          
          const Divider(),
          
          // Privacy Section
          _buildSectionHeader(context, 'Privacy & Security'),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Change Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Change password not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.security),
            title: const Text('Two-Factor Authentication'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('2FA settings not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.visibility),
            title: const Text('Privacy Settings'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy settings not implemented')),
              );
            },
          ),
          
          const Divider(),
          
          // Account Section
          _buildSectionHeader(context, 'Account'),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Account Information'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account information not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Payment Methods'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Payment methods not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            title: const Text('Subscription'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Subscription settings not implemented')),
              );
            },
          ),
          
          const Divider(),
          
          // Support Section
          _buildSectionHeader(context, 'Support'),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help Center'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Help center not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_support),
            title: const Text('Contact Support'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact support not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: const Text('Send Feedback'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Send feedback not implemented')),
              );
            },
          ),
          
          const Divider(),
          
          // About Section
          _buildSectionHeader(context, 'About'),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Ocean'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              _showAboutDialog(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Terms of Service'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms of service not implemented')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text('Privacy Policy'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy policy not implemented')),
              );
            },
          ),
          
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _getThemeModeText(ThemeMode themeMode) {
    switch (themeMode) {
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
      case ThemeMode.system:
        return 'System';
    }
  }

  void _showThemeDialog(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.read(themeModeProvider);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: const Text('Light'),
              value: ThemeMode.light,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('Dark'),
              value: ThemeMode.dark,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: const Text('System'),
              value: ThemeMode.system,
              groupValue: currentTheme,
              onChanged: (value) {
                if (value != null) {
                  ref.read(themeModeProvider.notifier).setThemeMode(value);
                  Navigator.pop(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Ocean',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.waves,
          color: Colors.white,
          size: 32,
        ),
      ),
      children: [
        const Text(
          'Ocean is a social commerce platform where buyers and sellers connect. '
          'Create posts, engage socially, and discover amazing products with AR viewing options.',
        ),
      ],
    );
  }
}