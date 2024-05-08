import 'dart:convert';

import 'package:student_hub/models/models.dart';

class InterviewModel extends BaseModel {
  final String title;
  final String startTime;
  final String endTime;
  final int meetingRoomId;
  final DisableFlag disableFlag;
  final MeetingRoomModel meetingRoom;

  const InterviewModel({
    this.title = '',
    this.startTime = '',
    this.endTime = '',
    this.meetingRoomId = -1,
    this.disableFlag = DisableFlag.enable,
    this.meetingRoom = const MeetingRoomModel(),
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  InterviewModel copyWith({
    String? title,
    String? startTime,
    String? endTime,
    int? meetingRoomId,
    DisableFlag? disableFlag,
    MeetingRoomModel? meetingRoom,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return InterviewModel(
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      meetingRoomId: meetingRoomId ?? this.meetingRoomId,
      disableFlag: disableFlag ?? this.disableFlag,
      meetingRoom: meetingRoom ?? this.meetingRoom,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'startTime': startTime,
      'endTime': endTime,
      'meetingRoomId': meetingRoomId,
      'disableFlag': disableFlag,
      'meetingRoom': meetingRoom.toMap(),
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory InterviewModel.fromMap(Map<String, dynamic> map) {
    return InterviewModel(
      title: map['title'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      meetingRoomId: map['meetingRoomId'] as int,
      disableFlag: DisableFlag.values[map['disableFlag'] as int],
      meetingRoom: MeetingRoomModel.fromMap(map['meetingRoom']),
      id: map['id'] as int,
      createdAt: map['createdAt'] ?? map['createdAt'] as String?,
      updatedAt: map['updatedAt'] ?? map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] ?? map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory InterviewModel.fromJson(String source) =>
      InterviewModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InterviewModel(title: $title, startTime: $startTime, endTime: $endTime, meetingRoomId: $meetingRoomId, disableFlag: $disableFlag)';
  }

  @override
  bool operator ==(covariant InterviewModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.title == title &&
        other.startTime == startTime &&
        other.endTime == endTime &&
        other.meetingRoomId == meetingRoomId &&
        other.disableFlag == disableFlag;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        deleteAt.hashCode ^
        title.hashCode ^
        startTime.hashCode ^
        endTime.hashCode ^
        meetingRoomId.hashCode ^
        disableFlag.hashCode;
  }
}
