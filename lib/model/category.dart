import 'package:flutter/material.dart';

/// Represents a category that can be assigned to habits
class Category {
  Category({
    this.id,
    required this.title,
    required this.iconCodePoint,
    this.fontFamily,
  });

  int? id;
  String title;
  int iconCodePoint;
  String? fontFamily;

  /// Get the IconData from the stored codePoint
  IconData get icon => IconData(iconCodePoint,
      fontFamily: fontFamily ?? 'MaterialIcons',
      fontPackage: "font_awesome_flutter");

  /// Convert category to map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'iconCodePoint': iconCodePoint,
      'fontFamily': fontFamily,
    };
  }

  /// Convert category to JSON for backup/export
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'iconCodePoint': iconCodePoint,
      'fontFamily': fontFamily,
    };
  }

  /// Create category from database map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      title: map['title'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
      fontFamily: map['fontFamily'] as String?,
    );
  }

  /// Create category from JSON for backup/import
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      title: json['title'] as String,
      iconCodePoint: json['iconCodePoint'] as int,
      fontFamily: json['fontFamily'] as String?,
    );
  }

  /// Create a copy of this category with optional field updates
  Category copyWith({
    int? id,
    String? title,
    int? iconCodePoint,
    String? fontFamily,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      fontFamily: fontFamily ?? this.fontFamily,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.title == title &&
        other.iconCodePoint == iconCodePoint &&
        other.fontFamily == fontFamily;
  }

  @override
  int get hashCode => Object.hash(id, title, iconCodePoint, fontFamily);

  @override
  String toString() {
    return 'Category(id: $id, title: $title, iconCodePoint: $iconCodePoint)';
  }
}
