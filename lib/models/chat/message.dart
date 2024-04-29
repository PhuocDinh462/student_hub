import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

enum MessageFlag { message, interview }

// ignore: must_be_immutable
class Message extends Equatable {
  final int? id;
  final int projectId;
  final int senderUserId;
  final int receiverUserId;
  final String? content;
  final DateTime createdAt;
  final DateTime? startTime;
  final DateTime? endTime;
  final String? title;
  final String? meetingRoomId;
  final String? meetingRoomCode;
  final MessageFlag meeting;
  bool canceled;

  Message({
    this.id,
    required this.projectId,
    required this.senderUserId,
    required this.receiverUserId,
    this.content,
    required this.createdAt,
    this.startTime,
    this.endTime,
    this.title,
    this.meetingRoomId,
    this.meetingRoomCode,
    this.meeting = MessageFlag.message,
    this.canceled = false,
  });

  Message copyWith({
    int? id,
    int? projectId,
    int? senderUserId,
    int? receiverUserId,
    String? content,
    DateTime? createdAt,
    DateTime? startTime,
    DateTime? endTime,
    String? title,
    String? meetingRoomId,
    String? meetingRoomCode,
    MessageFlag? meeting,
    bool? canceled,
  }) {
    return Message(
      id: id ?? this.id,
      projectId: projectId ?? this.projectId,
      senderUserId: senderUserId ?? this.senderUserId,
      receiverUserId: receiverUserId ?? this.receiverUserId,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      title: title ?? this.title,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      meetingRoomCode: meetingRoomCode ?? this.meetingRoomCode,
      meeting: meeting ?? this.meeting,
      canceled: canceled ?? this.canceled,
    );
  }

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      projectId: json['projectId'] ?? 1,
      senderUserId: json['sender_user_id'] ?? '',
      receiverUserId: json['receiver_user_id'] ?? '',
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      startTime: json['start_time'] != null
          ? DateTime.parse(json['start_time'])
          : null,
      endTime:
          json['end_time'] != null ? DateTime.parse(json['end_time']) : null,
      title: json['title'],
      meetingRoomId: json['meeting_room_id'],
      meetingRoomCode: json['meeting_room_code'],
      meeting: json['meeting'] ?? MessageFlag.message,
      canceled: json['canceled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'projectId': projectId,
      'sender_user_id': senderUserId,
      'receiver_user_id': receiverUserId,
      'content': content,
      'created_at': createdAt.toIso8601String(),
      'start_time': startTime?.toIso8601String(),
      'end_time': endTime?.toIso8601String(),
      'title': title,
      'meeting_room_id': meetingRoomId,
      'meeting_room_code': meetingRoomCode,
      'meeting': meeting,
      'canceled': canceled,
    };
  }

  @override
  List<Object?> get props => [
        id,
        projectId,
        senderUserId,
        receiverUserId,
        content,
        createdAt,
        startTime,
        endTime,
        title,
        meetingRoomId,
        meetingRoomCode,
        meeting,
        canceled,
      ];
}
