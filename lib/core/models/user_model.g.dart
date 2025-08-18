// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['fullName'] as String,
      profilePicture: json['profilePicture'] as String?,
      bio: json['bio'] as String?,
      location: json['location'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      followersCount: (json['followersCount'] as num?)?.toInt() ?? 0,
      followingCount: (json['followingCount'] as num?)?.toInt() ?? 0,
      postsCount: (json['postsCount'] as num?)?.toInt() ?? 0,
      isVerified: json['isVerified'] as bool? ?? false,
      isActive: json['isActive'] as bool? ?? true,
      sellerProfile: json['sellerProfile'] == null
          ? null
          : SellerProfile.fromJson(
              json['sellerProfile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'fullName': instance.fullName,
      'profilePicture': instance.profilePicture,
      'bio': instance.bio,
      'location': instance.location,
      'phoneNumber': instance.phoneNumber,
      'role': _$UserRoleEnumMap[instance.role]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
      'postsCount': instance.postsCount,
      'isVerified': instance.isVerified,
      'isActive': instance.isActive,
      'sellerProfile': instance.sellerProfile,
    };

const _$UserRoleEnumMap = {
  UserRole.buyer: 'buyer',
  UserRole.seller: 'seller',
  UserRole.admin: 'admin',
};

SellerProfile _$SellerProfileFromJson(Map<String, dynamic> json) =>
    SellerProfile(
      businessName: json['businessName'] as String,
      businessCategory:
          $enumDecode(_$BusinessCategoryEnumMap, json['businessCategory']),
      businessLocation: json['businessLocation'] as String,
      businessPhone: json['businessPhone'] as String,
      businessEmail: json['businessEmail'] as String,
      businessDescription: json['businessDescription'] as String?,
      businessWebsite: json['businessWebsite'] as String?,
      businessDocuments: (json['businessDocuments'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      personalId: json['personalId'] as String,
      status: $enumDecodeNullable(_$SellerStatusEnumMap, json['status']) ??
          SellerStatus.pending,
      approvedAt: json['approvedAt'] == null
          ? null
          : DateTime.parse(json['approvedAt'] as String),
      rejectionReason: json['rejectionReason'] as String?,
      currentPlan:
          $enumDecodeNullable(_$SubscriptionPlanEnumMap, json['currentPlan']),
      planExpiresAt: json['planExpiresAt'] == null
          ? null
          : DateTime.parse(json['planExpiresAt'] as String),
      analytics: json['analytics'] == null
          ? const SellerAnalytics()
          : SellerAnalytics.fromJson(json['analytics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SellerProfileToJson(SellerProfile instance) =>
    <String, dynamic>{
      'businessName': instance.businessName,
      'businessCategory': _$BusinessCategoryEnumMap[instance.businessCategory]!,
      'businessLocation': instance.businessLocation,
      'businessPhone': instance.businessPhone,
      'businessEmail': instance.businessEmail,
      'businessDescription': instance.businessDescription,
      'businessWebsite': instance.businessWebsite,
      'businessDocuments': instance.businessDocuments,
      'personalId': instance.personalId,
      'status': _$SellerStatusEnumMap[instance.status]!,
      'approvedAt': instance.approvedAt?.toIso8601String(),
      'rejectionReason': instance.rejectionReason,
      'currentPlan': _$SubscriptionPlanEnumMap[instance.currentPlan],
      'planExpiresAt': instance.planExpiresAt?.toIso8601String(),
      'analytics': instance.analytics,
    };

const _$BusinessCategoryEnumMap = {
  BusinessCategory.retailer: 'retailer',
  BusinessCategory.wholesaler: 'wholesaler',
  BusinessCategory.manufacturer: 'manufacturer',
  BusinessCategory.distributor: 'distributor',
};

const _$SellerStatusEnumMap = {
  SellerStatus.pending: 'pending',
  SellerStatus.approved: 'approved',
  SellerStatus.rejected: 'rejected',
  SellerStatus.suspended: 'suspended',
};

const _$SubscriptionPlanEnumMap = {
  SubscriptionPlan.basic: 'basic',
  SubscriptionPlan.premium: 'premium',
  SubscriptionPlan.enterprise: 'enterprise',
};

SellerAnalytics _$SellerAnalyticsFromJson(Map<String, dynamic> json) =>
    SellerAnalytics(
      totalViews: (json['totalViews'] as num?)?.toInt() ?? 0,
      totalLikes: (json['totalLikes'] as num?)?.toInt() ?? 0,
      totalSales: (json['totalSales'] as num?)?.toInt() ?? 0,
      totalRevenue: (json['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      productsCount: (json['productsCount'] as num?)?.toInt() ?? 0,
      engagementRate: (json['engagementRate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$SellerAnalyticsToJson(SellerAnalytics instance) =>
    <String, dynamic>{
      'totalViews': instance.totalViews,
      'totalLikes': instance.totalLikes,
      'totalSales': instance.totalSales,
      'totalRevenue': instance.totalRevenue,
      'productsCount': instance.productsCount,
      'engagementRate': instance.engagementRate,
    };
