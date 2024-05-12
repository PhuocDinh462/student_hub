import 'dart:convert';

import 'package:student_hub/models/models.dart';

class MeetingRoomModel extends BaseModel {
  final String meetingRoomCode;
  final String meetingRoomId;
  final String? expiredAt;

  const MeetingRoomModel({
    this.meetingRoomCode = '',
    this.meetingRoomId = '',
    this.expiredAt = '',
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  MeetingRoomModel copyWith({
    String? meetingRoomCode,
    String? meetingRoomId,
    String? expiredAt,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return MeetingRoomModel(
      meetingRoomCode: meetingRoomCode ?? this.meetingRoomCode,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      expiredAt: expiredAt ?? this.expiredAt,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'meeting_room_code': meetingRoomCode,
      'meeting_room_id': meetingRoomId,
      'expired_at': expiredAt,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory MeetingRoomModel.fromMap(Map<String, dynamic> map) {
    return MeetingRoomModel(
      meetingRoomCode: map['meeting_room_code'] as String,
      meetingRoomId: map['meeting_room_id'] as String,
      expiredAt: map['expired_at'] as String?,
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory MeetingRoomModel.fromJson(String source) =>
      MeetingRoomModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant MeetingRoomModel other) {
    if (identical(this, other)) return true;

    return other.meetingRoomCode == meetingRoomCode &&
        other.meetingRoomId == meetingRoomId &&
        other.expiredAt == expiredAt;
  }

  @override
  int get hashCode =>
      meetingRoomCode.hashCode ^ meetingRoomId.hashCode ^ expiredAt.hashCode;
}
