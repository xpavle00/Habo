import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/model/category.dart';

void main() {
  group('Category.icon', () {
    test('default Material icon resolves to the app MaterialIcons font', () {
      final category = Category(
        title: 'Health',
        iconCodePoint: Icons.category.codePoint,
      );

      final icon = category.icon;

      expect(icon.codePoint, Icons.category.codePoint);
      expect(icon.fontFamily, 'MaterialIcons');
      // Must not be looked up inside font_awesome_flutter, where no
      // MaterialIcons font exists (renders as an empty box).
      expect(icon.fontPackage, isNull);
    });

    test('Font Awesome icon keeps its family and package', () {
      final category = Category(
        title: 'Gym',
        iconCodePoint: 0xf44b,
        fontFamily: 'FontAwesomeSolid',
      );

      final icon = category.icon;

      expect(icon.fontFamily, 'FontAwesomeSolid');
      expect(icon.fontPackage, 'font_awesome_flutter');
    });

    test('explicit MaterialIcons family is not treated as Font Awesome', () {
      final category = Category(
        title: 'Evening',
        iconCodePoint: Icons.category.codePoint,
        fontFamily: 'MaterialIcons',
      );

      expect(category.icon.fontPackage, isNull);
    });
  });
}
