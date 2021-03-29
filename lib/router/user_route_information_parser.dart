import 'package:flutter/material.dart';

import 'package:routing/router/user_route_path.dart';

class UserRouteInformationParser extends RouteInformationParser<UserRoutePath> {
  @override
  Future<UserRoutePath> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    if (uri.pathSegments.length >= 2) {
      var remaining = uri.pathSegments[1];
      return UserRoutePath.details(remaining);
    } else {
      return UserRoutePath.users();
    }
  }

  @override
  RouteInformation restoreRouteInformation(UserRoutePath path) {
    if (path.isUsersPage) {
      return RouteInformation(location: '/');
    }
    if (path.isDetailsPage) {
      return RouteInformation(location: '/user/${path.id}');
    }
    return null;
  }
}
