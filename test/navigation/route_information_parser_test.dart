import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habo/navigation/route_information_parser.dart';

Future<String> _parse(String url) async {
  final config = await HaboRouteInformationParser().parseRouteInformation(
    RouteInformation(uri: Uri.parse(url)),
  );
  return config.path;
}

void main() {
  group('HaboRouteInformationParser', () {
    test('habo://settings parses to /settings', () async {
      expect(await _parse('habo://settings'), '/settings');
    });

    test('habo://open (home-screen widgets) parses to /open', () async {
      expect(await _parse('habo://open'), '/open');
    });
  });
}
