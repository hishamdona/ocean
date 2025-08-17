import 'package:json_annotation/json_annotation.dart';

part 'chat_model.g.dart';

@JsonSerializable()
class Chat {
  final String id;
  final List<String> participantIds;
  final String? lastMessageId;
  final String? lastMessageText;
  final DateTime? lastMessageAt;
  final String? lastMessageSenderId;
  final Map<String, int> unreadCounts;
  final ChatType type;
  final String? groupName;
  final String? groupImage;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final Map<String, dynamic>? metadata;

  const Chat({
    required this.id,
    required this.participantIds,
    this.lastMessageId,
    this.lastMessageText,
    this.lastMessageAt,
    this.lastMessageSenderId,
    this.unreadCounts = const {},
    this.type = ChatType.direct,
    this.groupName,
    this.groupImage,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.metadata,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);

  Chat copyWith({
    String? id,
    List<String>? participantIds,
    String? lastMessageId,
    String? lastMessageText,
    DateTime? lastMessageAt,
    String? lastMessageSenderId,
    Map<String, int>? unreadCounts,
    ChatType? type,
    String? groupName,
    String? groupImage,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    Map<String, dynamic>? metadata,
  }) {
    return Chat(
      id: id ?? this.id,
      participantIds: participantIds ?? this.participantIds,
      lastMessageId: lastMessageId ?? this.lastMessageId,
      lastMessageText: lastMessageText ?? this.lastMessageText,
      lastMessageAt: lastMessageAt ?? this.lastMessageAt,
      lastMessageSenderId: lastMessageSenderId ?? this.lastMessageSenderId,
      unreadCounts: unreadCounts ?? this.unreadCounts,
      type: type ?? this.type,
      groupName: groupName ?? this.groupName,
      groupImage: groupImage ?? this.groupImage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      metadata: metadata ?? this.metadata,
    );
  }
}

@JsonSerializable()
class Message {
  final String id;
  final String chatId;
  final String senderId;
  final String content;
  final MessageType type;
  final List<MessageAttachment> attachments;
  final String? replyToMessageId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final MessageStatus status;
  final Map<String, DateTime> readBy;
  final bool isEdited;
  final DateTime? editedAt;
  final Map<String, dynamic>? metadata;

  const Message({
    required this.id,
    required this.chatId,
    required this.senderId,
    required this.content,
    this.type = MessageType.text,
    this.attachments = const [],
    this.replyToMessageId,
    required this.createdAt,
    required this.updatedAt,
    this.status = MessageStatus.sent,
    this.readBy = const {},
    this.isEdited = false,
    this.editedAt,
    this.metadata,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  Message copyWith({
    String? id,
    String? chatId,
    String? senderId,
    String? content,
    MessageType? type,
    List<MessageAttachment>? attachments,
    String? replyToMessageId,
    DateTime? createdAt,
    DateTime? updatedAt,
    MessageStatus? status,
    Map<String, DateTime>? readBy,
    bool? isEdited,
    DateTime? editedAt,
    Map<String, dynamic>? metadata,
  }) {
    return Message(
      id: id ?? this.id,
      chatId: chatId ?? this.chatId,
      senderId: senderId ?? this.senderId,
      content: content ?? this.content,
      type: type ?? this.type,
      attachments: attachments ?? this.attachments,
      replyToMessageId: replyToMessageId ?? this.replyToMessageId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
      readBy: readBy ?? this.readBy,
      isEdited: isEdited ?? this.isEdited,
      editedAt: editedAt ?? this.editedAt,
      metadata: metadata ?? this.metadata,
    );
  }
}

@JsonSerializable()
class MessageAttachment {
  final String id;
  final MessageAttachmentType type;
  final String url;
  final String? thumbnailUrl;
  final String fileName;
  final int fileSizeBytes;
  final String? mimeType;
  final double? duration;
  final int? width;
  final int? height;

  const MessageAttachment({
    required this.id,
    required this.type,
    required this.url,
    this.thumbnailUrl,
    required this.fileName,
    required this.fileSizeBytes,
    this.mimeType,
    this.duration,
    this.width,
    this.height,
  });

  factory MessageAttachment.fromJson(Map<String, dynamic> json) => 
      _$MessageAttachmentFromJson(json);
  Map<String, dynamic> toJson() => _$MessageAttachmentToJson(this);
}

enum ChatType {
  @JsonValue('direct')
  direct,
  @JsonValue('group')
  group,
}

enum MessageType {
  @JsonValue('text')
  text,
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('file')
  file,
  @JsonValue('location')
  location,
  @JsonValue('product')
  product,
  @JsonValue('system')
  system,
}

enum MessageStatus {
  @JsonValue('sending')
  sending,
  @JsonValue('sent')
  sent,
  @JsonValue('delivered')
  delivered,
  @JsonValue('read')
  read,
  @JsonValue('failed')
  failed,
}

enum MessageAttachmentType {
  @JsonValue('image')
  image,
  @JsonValue('video')
  video,
  @JsonValue('audio')
  audio,
  @JsonValue('document')
  document,
  @JsonValue('location')
  location,
}