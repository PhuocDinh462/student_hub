import 'dart:convert';

class ProfileCompany {
  int? id;
  int? userId;
  String? companyName;
  int size;
  String? website;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? deleteAt;

  ProfileCompany({
    this.id,
    this.userId,
    this.companyName,
    this.size = 0,
    this.website,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.deleteAt,
  });

  ProfileCompany.empty() : size = 0;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'companyName': companyName,
      'size': size,
      'website': website,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'deleteAt': deleteAt,
    };
  }

  factory ProfileCompany.fromMap(Map<String, dynamic> map) {
    return ProfileCompany(
      id: map['id'] != null ? map['id'] as int : null,
      userId: map['userId'] != null ? map['userId'] as int : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      size: map['size'] as int,
      website: map['website'] != null ? map['website'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as String : null,
      updatedAt: map['updatedAt'] != null ? map['updatedAt'] as String : null,
      deleteAt: map['deleteAt'] != null ? map['deleteAt'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileCompany.fromJson(String source) =>
      ProfileCompany.fromMap(json.decode(source) as Map<String, dynamic>);

  ProfileCompany copyWith({
    int? id,
    int? userId,
    String? companyName,
    int? size,
    String? website,
    String? description,
    String? createdAt,
    String? updatedAt,
    String? deleteAt,
  }) {
    return ProfileCompany(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      companyName: companyName ?? this.companyName,
      size: size ?? this.size,
      website: website ?? this.website,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deleteAt: deleteAt ?? this.deleteAt,
    );
  }
}
