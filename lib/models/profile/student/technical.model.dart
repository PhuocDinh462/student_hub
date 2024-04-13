import 'dart:convert';

import 'package:student_hub/models/base.model.dart';

class TechnicalModel extends BaseModel {
  final String name;

  const TechnicalModel({
    this.name = '',
    super.id,
    super.createdAt,
    super.updatedAt,
    super.deleteAt,
  });

  TechnicalModel copyWith({
    String? name,
    int? id,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return TechnicalModel(
      name: name ?? this.name,
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory TechnicalModel.fromMap(Map<String, dynamic> map) {
    return TechnicalModel(
      name: map['name'] as String,
      id: map['id'] as int,
      createdAt: map['createdAt'] as String,
      updatedAt: map['updatedAt'] as String?,
      deleteAt: map['deleteAt'] as String?,
    );
  }

  String toJson() => json.encode(toMap());

  factory TechnicalModel.fromJson(String source) =>
      TechnicalModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TechnicalModel(name: $name)';

  @override
  bool operator ==(covariant TechnicalModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.deleteAt == deleteAt &&
        other.name == name;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deleteAt.hashCode ^
      name.hashCode;
}
