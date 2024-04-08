import 'package:equatable/equatable.dart';

class BaseModel extends Equatable {
  final int? id;
  final String createdAt;
  final String? updatedAt;
  final String? deleteAt;

  const BaseModel({
    this.id,
    this.createdAt = '',
    this.updatedAt,
    this.deleteAt,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
