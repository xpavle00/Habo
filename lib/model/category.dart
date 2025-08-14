import 'package:flutter/material.dart';

/// Represents a category that can be assigned to habits
class Category {
  Category({
    this.id,
    required this.title,
    required this.iconCodePoint,
  });

  int? id;
  String title;
  int iconCodePoint;
  
  /// Get the IconData from the stored codePoint
  IconData get icon => IconData(iconCodePoint, fontFamily: 'MaterialIcons');

  /// Convert category to map for database storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'iconCodePoint': iconCodePoint,
    };
  }

  /// Convert category to JSON for backup/export
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'iconCodePoint': iconCodePoint,
    };
  }

  /// Create category from database map
  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] as int?,
      title: map['title'] as String,
      iconCodePoint: map['iconCodePoint'] as int,
    );
  }

  /// Create category from JSON for backup/import
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int?,
      title: json['title'] as String,
      iconCodePoint: json['iconCodePoint'] as int,
    );
  }

  /// Create a copy of this category with optional field updates
  Category copyWith({
    int? id,
    String? title,
    int? iconCodePoint,
  }) {
    return Category(
      id: id ?? this.id,
      title: title ?? this.title,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Category &&
        other.id == id &&
        other.title == title &&
        other.iconCodePoint == iconCodePoint;
  }

  @override
  int get hashCode => Object.hash(id, title, iconCodePoint);

  @override
  String toString() {
    return 'Category(id: $id, title: $title, iconCodePoint: $iconCodePoint)';
  }
}
