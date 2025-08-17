import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class User {
  final String id;
  final String email;
  final String fullName;
  final String? profilePicture;
  final String? bio;
  final String? location;
  final String? phoneNumber;
  final UserRole role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int followersCount;
  final int followingCount;
  final int postsCount;
  final bool isVerified;
  final bool isActive;
  final SellerProfile? sellerProfile;

  const User({
    required this.id,
    required this.email,
    required this.fullName,
    this.profilePicture,
    this.bio,
    this.location,
    this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.followersCount = 0,
    this.followingCount = 0,
    this.postsCount = 0,
    this.isVerified = false,
    this.isActive = true,
    this.sellerProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    String? id,
    String? email,
    String? fullName,
    String? profilePicture,
    String? bio,
    String? location,
    String? phoneNumber,
    UserRole? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? followersCount,
    int? followingCount,
    int? postsCount,
    bool? isVerified,
    bool? isActive,
    SellerProfile? sellerProfile,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      profilePicture: profilePicture ?? this.profilePicture,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      postsCount: postsCount ?? this.postsCount,
      isVerified: isVerified ?? this.isVerified,
      isActive: isActive ?? this.isActive,
      sellerProfile: sellerProfile ?? this.sellerProfile,
    );
  }
}

@JsonSerializable()
class SellerProfile {
  final String businessName;
  final BusinessCategory businessCategory;
  final String businessLocation;
  final String businessPhone;
  final String businessEmail;
  final String? businessDescription;
  final String? businessWebsite;
  final List<String> businessDocuments;
  final String personalId;
  final SellerStatus status;
  final DateTime? approvedAt;
  final String? rejectionReason;
  final SubscriptionPlan? currentPlan;
  final DateTime? planExpiresAt;
  final SellerAnalytics analytics;

  const SellerProfile({
    required this.businessName,
    required this.businessCategory,
    required this.businessLocation,
    required this.businessPhone,
    required this.businessEmail,
    this.businessDescription,
    this.businessWebsite,
    this.businessDocuments = const [],
    required this.personalId,
    this.status = SellerStatus.pending,
    this.approvedAt,
    this.rejectionReason,
    this.currentPlan,
    this.planExpiresAt,
    this.analytics = const SellerAnalytics(),
  });

  factory SellerProfile.fromJson(Map<String, dynamic> json) => 
      _$SellerProfileFromJson(json);
  Map<String, dynamic> toJson() => _$SellerProfileToJson(this);
}

@JsonSerializable()
class SellerAnalytics {
  final int totalViews;
  final int totalLikes;
  final int totalSales;
  final double totalRevenue;
  final int productsCount;
  final double engagementRate;

  const SellerAnalytics({
    this.totalViews = 0,
    this.totalLikes = 0,
    this.totalSales = 0,
    this.totalRevenue = 0.0,
    this.productsCount = 0,
    this.engagementRate = 0.0,
  });

  factory SellerAnalytics.fromJson(Map<String, dynamic> json) => 
      _$SellerAnalyticsFromJson(json);
  Map<String, dynamic> toJson() => _$SellerAnalyticsToJson(this);
}

enum UserRole {
  @JsonValue('buyer')
  buyer,
  @JsonValue('seller')
  seller,
  @JsonValue('admin')
  admin,
}

enum BusinessCategory {
  @JsonValue('retailer')
  retailer,
  @JsonValue('wholesaler')
  wholesaler,
  @JsonValue('manufacturer')
  manufacturer,
  @JsonValue('distributor')
  distributor,
}

enum SellerStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('approved')
  approved,
  @JsonValue('rejected')
  rejected,
  @JsonValue('suspended')
  suspended,
}

enum SubscriptionPlan {
  @JsonValue('basic')
  basic,
  @JsonValue('premium')
  premium,
  @JsonValue('enterprise')
  enterprise,
}