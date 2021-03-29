import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:routing/screens/users_screen.dart';

import '../users.dart';

class UserScreen extends StatefulWidget {
  // Navigation 1.0
  static String _routeName(String userId) => '/user/$userId';
  // With
  static getRoute(User user) {
    return MaterialPageRoute(
      settings: RouteSettings(name: _routeName(user.id)),
      builder: (context) => UserScreen(
        // With Navigation 1.0 we can pass user directly to screen
        userId: user.id,
        // No need to actually pass this with Nav 1.0, but
        // to easily switch between 1.0 and 2.0
        onUserTapped: (user) {
          Navigator.of(context).push(UserScreen.getRoute(user));
        },
      ),
    );
  }

  final String userId;
  final ValueChanged<User> onUserTapped;

  UserScreen({
    Key key,
    @required this.userId,
    @required this.onUserTapped,
  })  : assert(userId != null),
        assert(onUserTapped != null),
        super(key: key);

  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  User user;
  List<User> friends;

  @override
  void initState() {
    final userService = context.read<UserService>();
    user = userService.getById(widget.userId);
    friends = userService.getFriendsById(widget.userId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(user.avatar),
                  radius: 80,
                ),
                Divider(color: Colors.transparent),
                Text(user.name, style: theme.textTheme.headline3),
                Text(user.email, style: theme.textTheme.subtitle1),
                Divider(color: Colors.transparent),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Friends:", style: theme.textTheme.headline4),
                  ),
                ),
                ...friends
                    .map((u) => UserTileWidget(
                          user: u,
                          onTapped: widget.onUserTapped,
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
