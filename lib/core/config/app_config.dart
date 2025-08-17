class AppConfig {
  static const String appName = 'Ocean';
  static const String appVersion = '1.0.0';
  
  // API Configuration
  static const String baseUrl = 'https://api.ocean.com';
  static const String apiVersion = 'v1';
  
  // Firebase Configuration
  static const String firebaseProjectId = 'ocean-social-commerce';
  
  // Stripe Configuration
  static const String stripePublishableKey = 'pk_test_...';
  
  // AR Configuration
  static const String arModelBaseUrl = 'https://cdn.ocean.com/ar-models/';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 50;
  
  // File Upload Limits
  static const int maxImageSizeMB = 10;
  static const int maxVideoSizeMB = 100;
  static const int maxARModelSizeMB = 50;
  
  // Chat Configuration
  static const int maxMessageLength = 1000;
  static const int maxChatImages = 5;
  
  // Subscription Plans
  static const Map<String, double> subscriptionPlans = {
    'basic': 9.99,
    'premium': 19.99,
    'enterprise': 49.99,
  };
}