import 'dart:convert';

import 'package:student_hub/models/chat/message.dart';
import 'package:student_hub/models/models.dart';

class MessageModel extends BaseModel {
  final int? senderId;
  final int? receiverId;
  final int? projectId;
  final int? interviewId;
  final InterviewModel? interview;
  final String content;
  final MessageFlag? messageFlag;
  final UserModel? sender;
  final UserModel? receiver;
  final ProjectModel? projectModel;

  const MessageModel({
    this.projectModel = const ProjectModel(),
    this.interview = const InterviewModel(),
    this.sender = const UserModel(),
    this.receiver = const UserModel(),
    this.senderId = -1,
    this.receiverId = -1,
    this.projectId = -1,
    this.interviewId = -1,
    this.content = '',
    this.messageFlag = MessageFlag.message,
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  MessageModel copyWith({
    int? senderId,
    int? receiverId,
    int? projectId,
    int? interviewId,
    String? content,
    MessageFlag? messageFlag,
    UserModel? sender,
    UserModel? receiver,
    InterviewModel? interview,
    ProjectModel? projectModel,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return MessageModel(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      projectId: projectId ?? this.projectId,
      interviewId: interviewId ?? this.interviewId,
      content: content ?? this.content,
      messageFlag: messageFlag ?? this.messageFlag,
      sender: sender ?? this.sender,
      receiver: receiver ?? this.receiver,
      interview: interview ?? this.interview,
      projectModel: projectModel ?? this.projectModel,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'receiverId': receiverId,
      'projectId': projectId,
      'interviewId': interviewId,
      'content': content,
      'messageFlag': messageFlag,
      'sender': sender!.toMap(),
      'receiver': receiver!.toMap(),
      'interview': interview?.toMap(),
      'project': projectModel?.toMap(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as int?,
      receiverId: map['receiverId'] as int?,
      projectId: map['projectId'] as int?,
      interviewId: map['interviewId'] as int?,
      content: map['content'] as String,
      messageFlag: MessageFlag.values[map['messageFlag'] ?? 0],
      sender: map['sender'] == null
          ? null
          : UserModel.fromMap(map['sender'] as Map<String, dynamic>),
      receiver: map['receiver'] == null
          ? null
          : UserModel.fromMap(map['receiver'] as Map<String, dynamic>),
      interview: map['interview'] == null
          ? null
          : InterviewModel.fromMap(map['interview'] as Map<String, dynamic>),
      projectModel: map['project'] == null
          ? null
          : ProjectModel.fromMap(map['project'] as Map<String, dynamic>),
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MessageModel.fromJson(String source) =>
      MessageModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MessageModel(senderId: $senderId, receiverId: $receiverId, projectId: $projectId, interviewId: $interviewId, content: $content, messageFlag: $messageFlag)';
  }

  @override
  bool operator ==(covariant MessageModel other) {
    if (identical(this, other)) return true;

    return other.senderId == senderId &&
        other.receiverId == receiverId &&
        other.projectId == projectId &&
        other.interviewId == interviewId &&
        other.content == content &&
        other.messageFlag == messageFlag;
  }

  @override
  int get hashCode {
    return senderId.hashCode ^
        receiverId.hashCode ^
        projectId.hashCode ^
        interviewId.hashCode ^
        content.hashCode ^
        messageFlag.hashCode;
  }
}
