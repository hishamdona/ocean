import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class Product {
  final String id;
  final String sellerId;
  final String name;
  final String description;
  final double price;
  final String currency;
  final ProductCategory category;
  final List<String> images;
  final List<String> tags;
  final ProductCondition condition;
  final int quantity;
  final String? location;
  final ProductStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int viewsCount;
  final int likesCount;
  final int savesCount;
  final double rating;
  final int reviewsCount;
  final ARModel? arModel;
  final ProductDimensions? dimensions;
  final double? weight;
  final String? brand;
  final String? model;
  final Map<String, dynamic>? specifications;

  const Product({
    required this.id,
    required this.sellerId,
    required this.name,
    required this.description,
    required this.price,
    this.currency = 'USD',
    required this.category,
    this.images = const [],
    this.tags = const [],
    this.condition = ProductCondition.new_,
    this.quantity = 1,
    this.location,
    this.status = ProductStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.viewsCount = 0,
    this.likesCount = 0,
    this.savesCount = 0,
    this.rating = 0.0,
    this.reviewsCount = 0,
    this.arModel,
    this.dimensions,
    this.weight,
    this.brand,
    this.model,
    this.specifications,
  });

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    String? id,
    String? sellerId,
    String? name,
    String? description,
    double? price,
    String? currency,
    ProductCategory? category,
    List<String>? images,
    List<String>? tags,
    ProductCondition? condition,
    int? quantity,
    String? location,
    ProductStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? viewsCount,
    int? likesCount,
    int? savesCount,
    double? rating,
    int? reviewsCount,
    ARModel? arModel,
    ProductDimensions? dimensions,
    double? weight,
    String? brand,
    String? model,
    Map<String, dynamic>? specifications,
  }) {
    return Product(
      id: id ?? this.id,
      sellerId: sellerId ?? this.sellerId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      currency: currency ?? this.currency,
      category: category ?? this.category,
      images: images ?? this.images,
      tags: tags ?? this.tags,
      condition: condition ?? this.condition,
      quantity: quantity ?? this.quantity,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      viewsCount: viewsCount ?? this.viewsCount,
      likesCount: likesCount ?? this.likesCount,
      savesCount: savesCount ?? this.savesCount,
      rating: rating ?? this.rating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      arModel: arModel ?? this.arModel,
      dimensions: dimensions ?? this.dimensions,
      weight: weight ?? this.weight,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      specifications: specifications ?? this.specifications,
    );
  }
}

@JsonSerializable()
class ARModel {
  final String id;
  final String fileName;
  final String fileUrl;
  final double fileSizeMB;
  final String? instructions;
  final DateTime uploadedAt;

  const ARModel({
    required this.id,
    required this.fileName,
    required this.fileUrl,
    required this.fileSizeMB,
    this.instructions,
    required this.uploadedAt,
  });

  factory ARModel.fromJson(Map<String, dynamic> json) => _$ARModelFromJson(json);
  Map<String, dynamic> toJson() => _$ARModelToJson(this);
}

@JsonSerializable()
class ProductDimensions {
  final double length;
  final double width;
  final double height;
  final String unit;

  const ProductDimensions({
    required this.length,
    required this.width,
    required this.height,
    this.unit = 'cm',
  });

  factory ProductDimensions.fromJson(Map<String, dynamic> json) => 
      _$ProductDimensionsFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDimensionsToJson(this);
}

enum ProductCategory {
  @JsonValue('electronics')
  electronics,
  @JsonValue('fashion')
  fashion,
  @JsonValue('home_garden')
  homeGarden,
  @JsonValue('sports_outdoors')
  sportsOutdoors,
  @JsonValue('automotive')
  automotive,
  @JsonValue('books_media')
  booksMedia,
  @JsonValue('health_beauty')
  healthBeauty,
  @JsonValue('toys_games')
  toysGames,
  @JsonValue('food_beverages')
  foodBeverages,
  @JsonValue('industrial')
  industrial,
  @JsonValue('other')
  other,
}

enum ProductCondition {
  @JsonValue('new')
  new_,
  @JsonValue('like_new')
  likeNew,
  @JsonValue('good')
  good,
  @JsonValue('fair')
  fair,
  @JsonValue('poor')
  poor,
}

enum ProductStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('sold')
  sold,
  @JsonValue('pending')
  pending,
  @JsonValue('rejected')
  rejected,
}