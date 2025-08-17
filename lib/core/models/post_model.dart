import 'package:json_annotation/json_annotation.dart';

part 'post_model.g.dart';

@JsonSerializable()
class Post {
  final String id;
  final String userId;
  final String caption;
  final List<PostMedia> media;
  final PostCategory category;
  final List<String> tags;
  final String? location;
  final PostStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final int savesCount;
  final bool isLiked;
  final bool isSaved;
  final String? productId;
  final PostEngagement engagement;

  const Post({
    required this.id,
    required this.userId,
    required this.caption,
    this.media = const [],
    required this.category,
    this.tags = const [],
    this.location,
    this.status = PostStatus.active,
    required this.createdAt,
    required this.updatedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.savesCount = 0,
    this.isLiked = false,
    this.isSaved = false,
    this.productId,
    this.engagement = const PostEngagement(),
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);

  Post copyWith({
    String? id,
    String? userId,
    String? caption,
    List<PostMedia>? media,
    PostCategory? category,
    List<String>? tags,
    String? location,
    PostStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    int? savesCount,
    bool? isLiked,
    bool? isSaved,
    String? productId,
    PostEngagement? engagement,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      caption: caption ?? this.caption,
      media: media ?? this.media,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      location: location ?? this.location,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      savesCount: savesCount ?? this.savesCount,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      productId: productId ?? this.productId,
      engagement: engagement ?? this.engagement,
    );
  }
}

@JsonSerializable()
class PostMedia {
  final String id;
  final PostMediaType type;
  final String url;
  final String? thumbnailUrl;
  final double? duration;
  final int? width;
  final int? height;
  final int order;

  const PostMedia({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    this.duration,
    this.width,
    this.height,
    this.order = 0,
  });

  factory PostMedia.fromJson(Map<String, dynamic> json) => 
      _$PostMediaFromJson(json);
  Map<String, dynamic> toJson() => _$PostMediaToJson(this);
}

@JsonSerializable()
class PostEngagement {
  final double engagementRate;
  final int viewsCount;
  final int clicksCount;
  final Map<String, int> reactionCounts;

  const PostEngagement({
    this.engagementRate = 0.0,
    this.viewsCount = 0,
    this.clicksCount = 0,
    this.reactionCounts = const {},
  });

  factory PostEngagement.fromJson(Map<String, dynamic> json) => 
      _$PostEngagementFromJson(json);
  Map<String, dynamic> toJson() => _$PostEngagementToJson(this);
}

@JsonSerializable()
class Comment {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final String? parentCommentId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int repliesCount;
  final bool isLiked;

  const Comment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    this.parentCommentId,
    required this.createdAt,
    required this.updatedAt,
    this.likesCount = 0,
    this.repliesCount = 0,
    this.isLiked = false,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);
}

enum PostCategory {
  @JsonValue('product_demand')
  productDemand,
  @JsonValue('bulk_purchase')
  bulkPurchase,
  @JsonValue('distress_sales')
  distressSales,
  @JsonValue('heavy_distributors')
  heavyDistributors,
  @JsonValue('swap_deals')
  swapDeals,
  @JsonValue('auctions')
  auctions,
  @JsonValue('general')
  general,
}

enum PostMediaType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
}

enum PostStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
  @JsonValue('deleted')
  deleted,
  @JsonValue('reported')
  reported,
}