// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: json['id'] as String,
      userId: json['userId'] as String,
      caption: json['caption'] as String,
      media: (json['media'] as List<dynamic>?)
              ?.map((e) => PostMedia.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      category: $enumDecode(_$PostCategoryEnumMap, json['category']),
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      location: json['location'] as String?,
      status: $enumDecodeNullable(_$PostStatusEnumMap, json['status']) ??
          PostStatus.active,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      commentsCount: (json['commentsCount'] as num?)?.toInt() ?? 0,
      sharesCount: (json['sharesCount'] as num?)?.toInt() ?? 0,
      savesCount: (json['savesCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      isSaved: json['isSaved'] as bool? ?? false,
      productId: json['productId'] as String?,
      engagement: json['engagement'] == null
          ? const PostEngagement()
          : PostEngagement.fromJson(json['engagement'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'caption': instance.caption,
      'media': instance.media,
      'category': _$PostCategoryEnumMap[instance.category]!,
      'tags': instance.tags,
      'location': instance.location,
      'status': _$PostStatusEnumMap[instance.status]!,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'likesCount': instance.likesCount,
      'commentsCount': instance.commentsCount,
      'sharesCount': instance.sharesCount,
      'savesCount': instance.savesCount,
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
      'productId': instance.productId,
      'engagement': instance.engagement,
    };

const _$PostCategoryEnumMap = {
  PostCategory.productDemand: 'product_demand',
  PostCategory.bulkPurchase: 'bulk_purchase',
  PostCategory.distressSales: 'distress_sales',
  PostCategory.heavyDistributors: 'heavy_distributors',
  PostCategory.swapDeals: 'swap_deals',
  PostCategory.auctions: 'auctions',
  PostCategory.general: 'general',
};

const _$PostStatusEnumMap = {
  PostStatus.active: 'active',
  PostStatus.inactive: 'inactive',
  PostStatus.deleted: 'deleted',
  PostStatus.reported: 'reported',
};

PostMedia _$PostMediaFromJson(Map<String, dynamic> json) => PostMedia(
      id: json['id'] as String,
      type: $enumDecode(_$PostMediaTypeEnumMap, json['type']),
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      duration: (json['duration'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      order: (json['order'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PostMediaToJson(PostMedia instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$PostMediaTypeEnumMap[instance.type]!,
      'url': instance.url,
      'thumbnailUrl': instance.thumbnailUrl,
      'duration': instance.duration,
      'width': instance.width,
      'height': instance.height,
      'order': instance.order,
    };

const _$PostMediaTypeEnumMap = {
  PostMediaType.image: 'image',
  PostMediaType.video: 'video',
};

PostEngagement _$PostEngagementFromJson(Map<String, dynamic> json) =>
    PostEngagement(
      engagementRate: (json['engagementRate'] as num?)?.toDouble() ?? 0.0,
      viewsCount: (json['viewsCount'] as num?)?.toInt() ?? 0,
      clicksCount: (json['clicksCount'] as num?)?.toInt() ?? 0,
      reactionCounts: (json['reactionCounts'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, (e as num).toInt()),
          ) ??
          const {},
    );

Map<String, dynamic> _$PostEngagementToJson(PostEngagement instance) =>
    <String, dynamic>{
      'engagementRate': instance.engagementRate,
      'viewsCount': instance.viewsCount,
      'clicksCount': instance.clicksCount,
      'reactionCounts': instance.reactionCounts,
    };

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['id'] as String,
      postId: json['postId'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      parentCommentId: json['parentCommentId'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      likesCount: (json['likesCount'] as num?)?.toInt() ?? 0,
      repliesCount: (json['repliesCount'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'postId': instance.postId,
      'userId': instance.userId,
      'content': instance.content,
      'parentCommentId': instance.parentCommentId,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'likesCount': instance.likesCount,
      'repliesCount': instance.repliesCount,
      'isLiked': instance.isLiked,
    };
