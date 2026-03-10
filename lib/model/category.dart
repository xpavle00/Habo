import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

const _uuidGenerator = Uuid();

/// Represents a category that can be assigned to habits
class Category {
  Category({
    this.id,
    String? uuid,
    required this.title,
    required this.iconCodePoint,
    this.fontFamily,
    this.deletedAt,
    DateTime? updatedAt,
  }) : uuid = uuid ?? _uuidGenerator.v4(),
       updatedAt = updatedAt ?? DateTime.now().toUtc();

  int? id;
  final String uuid;
  String title;
  int iconCodePoint;
  String? fontFamily;
  DateTime? deletedAt;
  DateTime updatedAt;

  /// Whether this category has been soft-deleted
  bool get isDeleted => deletedAt != null;

  /// Get the IconData from the stored codePoint
  IconData get icon => IconData(
    iconCodePoint,
    fontFamily: fontFamily ?? 'MaterialIcons',
    fontPackage: "font_awesome_flutter",
  );

  /// Convert category to map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'title': title,
      'iconCodePoint': iconCodePoint,
      'fontFamily': fontFamily,
      'deleted_at': deletedAt?.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Convert category to JSON for backup/export
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'uuid': uuid,
      'title': title,
      'iconCodePoint': iconCodePoint,
      'fontFamily': fontFamily,
      'deleted_at': deletedAt?.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  /// Create category from database map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      uuid: map['uuid'] as String?,
      title: map['title'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
      fontFamily: map['fontFamily'] as String?,
      deletedAt: map['deleted_at'] != null
          ? DateTime.parse(map['deleted_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  /// Create category from JSON for backup/import
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      uuid: json['uuid'] as String?,
      title: json['title'] as String,
      iconCodePoint: json['iconCodePoint'] as int,
      fontFamily: json['fontFamily'] as String?,
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  /// Create a copy of this category with optional field updates
  Category copyWith({
    int? id,
    String? uuid,
    String? title,
    int? iconCodePoint,
    String? fontFamily,
    DateTime? deletedAt,
    DateTime? updatedAt,
  }) {
    return Category(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      title: title ?? this.title,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      fontFamily: fontFamily ?? this.fontFamily,
      deletedAt: deletedAt ?? this.deletedAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.uuid == uuid &&
        other.title == title &&
        other.iconCodePoint == iconCodePoint &&
        other.fontFamily == fontFamily;
  }

  @override
  int get hashCode => Object.hash(id, uuid, title, iconCodePoint, fontFamily);

  @override
  String toString() {
    return 'Category(id: $id, uuid: $uuid, title: $title, iconCodePoint: $iconCodePoint)';
  }
}
