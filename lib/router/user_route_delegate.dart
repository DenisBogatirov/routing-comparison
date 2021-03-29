import 'package:flutter/material.dart';
import 'package:routing/screens/user_screen.dart';

import 'package:routing/users.dart';
import 'package:routing/screens/users_screen.dart';

import 'user_route_path.dart';

class UserRouterDelegate extends RouterDelegate<UserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<UserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  final UserService _userService;

  List<User> _selectedUsers = [];

  UserRouterDelegate(this._userService) : navigatorKey = GlobalKey<NavigatorState>();

  UserRoutePath get currentConfiguration {
    if (_selectedUsers.isEmpty) {
      return UserRoutePath.users();
    }

    return UserRoutePath.details(_selectedUsers.last.id);
  }

  void _handleUserTapped(User user) {
    _selectedUsers.add(user);
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      pages: [
        MaterialPage(
          key: ValueKey('UsersListPage'),
          child: UsersScreen(
            onUserTapped: _handleUserTapped,
          ),
        ),
        if (_selectedUsers.isNotEmpty)
          ..._selectedUsers.map(
            (user) => MaterialPage(
              key: ValueKey('UsersListPage_${user.id}'),
              child: UserScreen(
                userId: user.id,
                onUserTapped: _handleUserTapped,
              ),
            ),
          )
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }

        if (_selectedUsers.isNotEmpty) {
          _selectedUsers.removeLast();
          notifyListeners();
        }

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(UserRoutePath path) async {
    if (path.isDetailsPage) {
      _selectedUsers = [_userService.getById(path.id)];
    }
  }
}
