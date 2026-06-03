import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/navigation/route_information_parser.dart';

void main() {
  group('HaboRouteInformationParser', () {
    late HaboRouteInformationParser parser;

    setUp(() {
      parser = HaboRouteInformationParser();
    });

    test('parses web path deep link', () async {
      final config = await parser.parseRouteInformation(
        RouteInformation(uri: Uri.parse('/sync')),
      );

      expect(config.path, '/sync');
    });

    test('parses single-slash custom scheme deep link', () async {
      final config = await parser.parseRouteInformation(
        RouteInformation(uri: Uri.parse('habo:/sync')),
      );

      expect(config.path, '/sync');
    });

    test('parses double-slash custom scheme deep link', () async {
      final config = await parser.parseRouteInformation(
        RouteInformation(uri: Uri.parse('habo://sync')),
      );

      expect(config.path, '/sync');
    });
  });
}
