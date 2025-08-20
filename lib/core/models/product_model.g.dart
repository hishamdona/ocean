// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as String,
      sellerId: json['sellerId'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'USD',
      category: $enumDecode(_$ProductCategoryEnumMap, json['category']),
      images: (json['images'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      condition:
          $enumDecodeNullable(_$ProductConditionEnumMap, json['condition']) ??
              ProductCondition.new_,
      quantity: (json['quantity'] as num?)?.toInt() ?? 1,
      location: json['location'] as String?,
      status: $enumDecodeNullable(_$ProductStatusEnumMap, json['status']) ??
          ProductStatus.active,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      viewsCount: (json['viewsCount'] as num?)?.toInt() ?? 0,
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      savesCount: (json['savesCount'] as num?)?.toInt() ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewsCount: (json['reviewsCount'] as num?)?.toInt() ?? 0,
      arModel: json['arModel'] == null
          ? null
          : ARModel.fromJson(json['arModel'] as Map<String, dynamic>),
      dimensions: json['dimensions'] == null
          ? null
          : ProductDimensions.fromJson(
              json['dimensions'] as Map<String, dynamic>),
      weight: (json['weight'] as num?)?.toDouble(),
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      specifications: json['specifications'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'sellerId': instance.sellerId,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'currency': instance.currency,
      'category': _$ProductCategoryEnumMap[instance.category]!,
      'images': instance.images,
      'tags': instance.tags,
      'condition': _$ProductConditionEnumMap[instance.condition]!,
      'quantity': instance.quantity,
      'location': instance.location,
      'status': _$ProductStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'viewsCount': instance.viewsCount,
      'likesCount': instance.likesCount,
      'savesCount': instance.savesCount,
      'rating': instance.rating,
      'reviewsCount': instance.reviewsCount,
      'arModel': instance.arModel,
      'dimensions': instance.dimensions,
      'weight': instance.weight,
      'brand': instance.brand,
      'model': instance.model,
      'specifications': instance.specifications,
    };

const _$ProductCategoryEnumMap = {
  ProductCategory.electronics: 'electronics',
  ProductCategory.fashion: 'fashion',
  ProductCategory.homeGarden: 'home_garden',
  ProductCategory.sportsOutdoors: 'sports_outdoors',
  ProductCategory.automotive: 'automotive',
  ProductCategory.booksMedia: 'books_media',
  ProductCategory.healthBeauty: 'health_beauty',
  ProductCategory.toysGames: 'toys_games',
  ProductCategory.foodBeverages: 'food_beverages',
  ProductCategory.industrial: 'industrial',
  ProductCategory.other: 'other',
};

const _$ProductConditionEnumMap = {
  ProductCondition.new_: 'new',
  ProductCondition.likeNew: 'like_new',
  ProductCondition.good: 'good',
  ProductCondition.fair: 'fair',
  ProductCondition.poor: 'poor',
};

const _$ProductStatusEnumMap = {
  ProductStatus.active: 'active',
  ProductStatus.inactive: 'inactive',
  ProductStatus.sold: 'sold',
  ProductStatus.pending: 'pending',
  ProductStatus.rejected: 'rejected',
};

ARModel _$ARModelFromJson(Map<String, dynamic> json) => ARModel(
      id: json['id'] as String,
      fileName: json['fileName'] as String,
      fileUrl: json['fileUrl'] as String,
      fileSizeMB: (json['fileSizeMB'] as num).toDouble(),
      instructions: json['instructions'] as String?,
      uploadedAt: DateTime.parse(json['uploadedAt'] as String),
    );

Map<String, dynamic> _$ARModelToJson(ARModel instance) => <String, dynamic>{
      'id': instance.id,
      'fileName': instance.fileName,
      'fileUrl': instance.fileUrl,
      'fileSizeMB': instance.fileSizeMB,
      'instructions': instance.instructions,
      'uploadedAt': instance.uploadedAt.toIso8601String(),
    };

ProductDimensions _$ProductDimensionsFromJson(Map<String, dynamic> json) =>
    ProductDimensions(
      length: (json['length'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      unit: json['unit'] as String? ?? 'cm',
    );

Map<String, dynamic> _$ProductDimensionsToJson(ProductDimensions instance) =>
    <String, dynamic>{
      'length': instance.length,
      'width': instance.width,
      'height': instance.height,
      'unit': instance.unit,
    };
