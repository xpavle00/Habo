import 'package:flutter/material.dart';

/// Custom route configuration for Navigation 2.0
class HaboRouteConfiguration {
  final String path;

  const HaboRouteConfiguration({required this.path});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HaboRouteConfiguration &&
          runtimeType == other.runtimeType &&
          path == other.path;

  @override
  int get hashCode => path.hashCode;
}

/// Route information parser for handling deep links in Navigation 2.0
class HaboRouteInformationParser
    extends RouteInformationParser<HaboRouteConfiguration> {
  @override
  Future<HaboRouteConfiguration> parseRouteInformation(
    RouteInformation routeInformation,
  ) async {
    // For custom schemes, the path is in the host part. For web, it's in the path.
    final uri = routeInformation.uri;
    String path = uri.path;

    // For custom schemes, Uri.parse('habo://sync') produces an empty path and
    // host='sync'. Accept both empty and '/' paths when host is present.
    if ((path.isEmpty || path == '/') && uri.host.isNotEmpty) {
      path = '/${uri.host}';
    }

    return HaboRouteConfiguration(path: path);
  }

  @override
  RouteInformation? restoreRouteInformation(
    HaboRouteConfiguration configuration,
  ) {
    return RouteInformation(uri: Uri.parse(configuration.path));
  }
}
