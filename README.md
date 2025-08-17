# Ocean - Social Commerce Flutter App

A comprehensive social commerce platform built with Flutter where buyers and sellers connect through social interactions, product listings, and AR viewing capabilities.

## 🌊 Features

### Core Functionality
- **Social Feed**: Scrollable feed with posts, engagement (like, comment, share, save)
- **Product Marketplace**: Browse products with filters, categories, and AR viewing
- **Real-time Chat**: Direct messaging between buyers and sellers
- **User Authentication**: Email/password with buyer/seller roles
- **Seller Registration**: Complete business profile setup with document upload
- **Market Survey Tools**: Demand posts, auctions, bulk purchases, swap deals

### Key Highlights
- **AR Product Viewing**: Upload .glb files for immersive product experiences
- **Stories Feature**: Instagram-style stories in the app bar
- **Dark/Light Mode**: Complete theming system
- **Seller Analytics**: Track views, likes, sales, and engagement
- **Subscription Plans**: Monetization through seller subscriptions
- **Multi-language Ready**: Architecture supports internationalization

## 🏗️ Architecture

### Clean Architecture
```
lib/
├── core/                   # Core functionality
│   ├── config/            # App configuration
│   ├── models/            # Data models
│   ├── providers/         # Riverpod providers
│   ├── router/            # Navigation routing
│   ├── services/          # Business logic services
│   └── theme/             # App theming
├── features/              # Feature modules
│   ├── auth/              # Authentication
│   ├── home/              # Social feed
│   ├── products/          # Product marketplace
│   ├── upload/            # Product upload
│   ├── saved/             # Saved items
│   ├── chats/             # Real-time messaging
│   ├── profile/           # User profiles
│   ├── market_survey/     # Market survey tools
│   └── settings/          # App settings
└── main.dart              # App entry point
```

### State Management
- **Riverpod**: For state management and dependency injection
- **Provider Pattern**: Clean separation of business logic
- **Repository Pattern**: Data layer abstraction

### Navigation
- **GoRouter**: Declarative routing with guards
- **Bottom Navigation**: 5-tab structure (Home, Products, Upload, Saved, Chats)
- **Deep Linking**: Support for product and user profile links

## 🎨 Design System

### Color Palette
- **Primary**: Black (#000000)
- **Secondary**: White (#FFFFFF)  
- **Accent**: Purple (#8A2BE2)
- **Dark Background**: Charcoal (#121212)
- **Success**: Green (#4CAF50)
- **Warning**: Orange (#FF9800)
- **Error**: Red (#F44336)

### Typography
- **Font Family**: Poppins (modern, rounded, social vibe)
- **Responsive**: Scales appropriately across devices
- **Hierarchy**: Clear distinction between headings, body, and labels

### Components
- **Cards**: Rounded corners with elevation
- **Buttons**: Consistent styling with hover states
- **Forms**: Clean input fields with validation
- **Navigation**: Intuitive bottom navigation and drawer

## 📱 App Structure

### Bottom Navigation (5 Tabs)
1. **Home**: Social feed with stories and posts
2. **Products**: Product marketplace with filters
3. **Upload**: Product upload (seller registration for non-sellers)
4. **Saved**: Saved posts and products
5. **Chats**: Real-time messaging

### Side Drawer (Market Survey)
- **Products Demand**: My posts / Global posts by category
- **Distress Sales**: My sales / Global distress sales
- **Heavy Distributors**: Searchable list by category
- **Swap Deals**: Product exchange with messaging
- **Bulk Purchases**: Search and form submission
- **Auctions**: Listings with countdown timers

## 🔧 Technical Stack

### Dependencies
```yaml
# State Management
flutter_riverpod: ^2.4.9

# Navigation
go_router: ^12.1.3

# UI Components
google_fonts: ^6.1.0
cached_network_image: ^3.3.0
shimmer: ^3.0.0

# Storage & Database
shared_preferences: ^2.2.2
hive: ^2.2.3
cloud_firestore: ^4.13.6

# Authentication
firebase_auth: ^4.15.3
firebase_core: ^2.24.2

# Real-time Features
firebase_messaging: ^14.7.10

# Media & Files
image_picker: ^1.0.4
file_picker: ^6.1.1
permission_handler: ^11.1.0

# AR Features
ar_flutter_plugin: ^0.7.3

# Maps & Location
geolocator: ^10.1.0
geocoding: ^2.1.1

# Payments
flutter_stripe: ^9.5.0

# Networking
dio: ^5.4.0
retrofit: ^4.0.3
json_annotation: ^4.8.1
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Firebase project setup

### Installation
1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd ocean
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Firebase Setup**
   - Create a Firebase project
   - Add Android/iOS apps
   - Download and add configuration files
   - Enable Authentication, Firestore, and Cloud Messaging

5. **Run the app**
   ```bash
   flutter run
   ```

## 📊 Data Models

### User Model
```dart
class User {
  final String id;
  final String email;
  final String fullName;
  final UserRole role; // buyer, seller, admin
  final SellerProfile? sellerProfile;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  // ... additional fields
}
```

### Product Model
```dart
class Product {
  final String id;
  final String sellerId;
  final String name;
  final String description;
  final double price;
  final ProductCategory category;
  final List<String> images;
  final ARModel? arModel;
  // ... additional fields
}
```

### Post Model
```dart
class Post {
  final String id;
  final String userId;
  final String caption;
  final List<PostMedia> media;
  final PostCategory category; // demand, bulk, distress, etc.
  final int likesCount;
  final int commentsCount;
  // ... additional fields
}
```

## 🔐 Authentication Flow

1. **Registration**: Email/password with role selection
2. **Seller Onboarding**: Business profile completion
3. **Admin Approval**: Seller verification process
4. **Role-based Access**: Different UI based on user role

## 💰 Monetization

### Seller Subscription Plans
- **Basic**: $9.99/month - Basic features
- **Premium**: $19.99/month - Advanced analytics
- **Enterprise**: $49.99/month - Full feature access

### Payment Integration
- **Stripe**: Primary payment processor
- **PayPal**: Alternative payment method
- **Flutterwave**: Regional payment support

## 🌐 Internationalization

The app is architected to support multiple languages:
- String externalization ready
- RTL language support
- Currency and date formatting
- Regional payment methods

## 🔮 Future Enhancements

### AI Features
- **Smart Recommendations**: ML-powered product suggestions
- **Intelligent Search**: Natural language product search
- **Influencer Shops**: AI-curated influencer storefronts

### Advanced Features
- **Video Commerce**: Live streaming for product demos
- **Social Shopping**: Group buying and social proof
- **Advanced AR**: Try-before-buy experiences
- **Blockchain Integration**: NFT marketplace capabilities

## 📈 Scalability

### Performance Optimizations
- **Lazy Loading**: Efficient data loading strategies
- **Image Caching**: Optimized media handling
- **State Management**: Efficient state updates
- **Database Indexing**: Optimized Firestore queries

### Infrastructure
- **CDN Integration**: Fast global content delivery
- **Microservices**: Scalable backend architecture
- **Load Balancing**: Handle millions of concurrent users
- **Monitoring**: Real-time performance tracking

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions:
- Email: support@ocean.com
- Documentation: [docs.ocean.com](https://docs.ocean.com)
- Community: [community.ocean.com](https://community.ocean.com)

---

**Ocean** - Where Social Commerce Meets Innovation 🌊