// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:student_hub/models/models.dart';

enum NotifyFlag { unread, read }

enum TypeNotifyFlag {
  offer,
  interview,
  submitted,
  chat,
}

class NotificationModel extends BaseModel {
  final int receiverId;
  final int senderId;
  final int messageId;
  final String title;
  final String content;
  final NotifyFlag notifyFlag;
  final TypeNotifyFlag typeNotifyFlag;
  final MessageModel? message;
  final UserModel? receiver;
  final UserModel? sender;

  const NotificationModel({
    this.receiverId = -1,
    this.senderId = -1,
    this.messageId = -1,
    this.title = '',
    this.content = '',
    this.notifyFlag = NotifyFlag.unread,
    this.typeNotifyFlag = TypeNotifyFlag.submitted,
    this.message = const MessageModel(),
    this.receiver = const UserModel(),
    this.sender = const UserModel(),
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  NotificationModel copyWith({
    int? receiverId,
    int? senderId,
    int? messageId,
    String? title,
    String? content,
    NotifyFlag? notifyFlag,
    TypeNotifyFlag? typeNotifyFlag,
    MessageModel? message,
    UserModel? receiver,
    UserModel? sender,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return NotificationModel(
      receiverId: receiverId ?? this.receiverId,
      senderId: senderId ?? this.senderId,
      messageId: messageId ?? this.messageId,
      title: title ?? this.title,
      content: content ?? this.content,
      notifyFlag: notifyFlag ?? this.notifyFlag,
      typeNotifyFlag: typeNotifyFlag ?? this.typeNotifyFlag,
      message: message ?? this.message,
      receiver: receiver ?? this.receiver,
      sender: sender ?? this.sender,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'receiverId': receiverId,
      'senderId': senderId,
      'messageId': messageId,
      'title': title,
      'content': content,
      'notifyFlag': notifyFlag,
      'typeNotifyFlag': typeNotifyFlag,
      'message': message!.toMap(),
      'receiver': receiver!.toMap(),
      'sender': sender!.toMap(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      receiverId: map['receiverId'] as int,
      senderId: map['senderId'] as int,
      messageId: map['messageId'] as int,
      title: map['title'] as String,
      content: map['content'] as String,
      notifyFlag: NotifyFlag.values[int.parse(map['notifyFlag'])],
      typeNotifyFlag: TypeNotifyFlag.values[int.parse(map['typeNotifyFlag'])],
      message: map['message'] == null
          ? null
          : MessageModel.fromMap(map['message'] as Map<String, dynamic>),
      receiver: map['receiver'] == null
          ? null
          : UserModel.fromMap(map['receiver'] as Map<String, dynamic>),
      sender: map['sender'] == null
          ? null
          : UserModel.fromMap(map['sender'] as Map<String, dynamic>),
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationModel.fromJson(String source) =>
      NotificationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'NotificationModel(receiverId: $receiverId, senderId: $senderId, messageId: $messageId, title: $title, content: $content, notifyFlag: $notifyFlag, typeNotifyFlag: $typeNotifyFlag, message: $message, receiver: $receiver, sender: $sender)';
  }

  @override
  bool operator ==(covariant NotificationModel other) {
    if (identical(this, other)) return true;

    return other.receiverId == receiverId &&
        other.senderId == senderId &&
        other.messageId == messageId &&
        other.title == title &&
        other.content == content &&
        other.notifyFlag == notifyFlag &&
        other.typeNotifyFlag == typeNotifyFlag &&
        other.message == message &&
        other.receiver == receiver &&
        other.sender == sender;
  }

  @override
  int get hashCode {
    return receiverId.hashCode ^
        senderId.hashCode ^
        messageId.hashCode ^
        title.hashCode ^
        content.hashCode ^
        notifyFlag.hashCode ^
        typeNotifyFlag.hashCode ^
        message.hashCode ^
        receiver.hashCode ^
        sender.hashCode;
  }
}
