import 'dart:convert';

class ProfileCompany {
  String? id;
  String? userId;
  String? companyName;
  int size;
  String? website;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deleteAt;

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

  void setCompanyName(String companyName) {
    this.companyName = companyName;
  }

  void setSize(int size) {
    this.size = size;
  }

  void setWebsite(String website) {
    this.website = website;
  }

  void setDescription(String description) {
    this.description = description;
  }

  ProfileCompany copyWith({
    String? id,
    String? userId,
    String? companyName,
    int? size,
    String? website,
    String? description,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deleteAt,
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'companyName': companyName,
      'size': size,
      'website': website,
      'description': description,
      'createdAt': createdAt?.millisecondsSinceEpoch,
      'updatedAt': updatedAt?.millisecondsSinceEpoch,
      'deleteAt': deleteAt?.millisecondsSinceEpoch,
    };
  }

  factory ProfileCompany.fromMap(Map<String, dynamic> map) {
    return ProfileCompany(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      companyName:
          map['companyName'] != null ? map['companyName'] as String : null,
      size: map['size'],
      website: map['website'] != null ? map['website'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : null,
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : null,
      deleteAt: map['deleteAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['deleteAt'] as int)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileCompany.fromJson(String source) =>
      ProfileCompany.fromMap(json.decode(source) as Map<String, dynamic>);
}
