import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'user_screen.dart';
import '../users.dart';

class UsersScreen extends StatefulWidget {
  // Navigation 1.0
  static final String _routeName = '/users';
  static getRoute() {
    return MaterialPageRoute(
      settings: RouteSettings(name: _routeName),
      builder: (context) => UsersScreen(
        // No need to actually pass this with Nav 1.0, but
        // to easily switch between 1.0 and 2.0
        onUserTapped: (user) {
          Navigator.of(context).push(UserScreen.getRoute(user));
        },
      ),
    );
  }

  final ValueChanged<User> onUserTapped;

  UsersScreen({
    Key key,
    @required this.onUserTapped,
  })  : assert(onUserTapped != null),
        super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<User> _users;

  @override
  void initState() {
    final userService = context.read<UserService>();
    _users = userService.getUsers();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
      ),
      body: SafeArea(
        child: ListView.separated(
          itemCount: _users.length,
          separatorBuilder: (_, __) => Divider(),
          itemBuilder: (context, index) {
            final user = _users[index];
            return UserTileWidget(
              user: user,
              onTapped: widget.onUserTapped,
            );
          },
        ),
      ),
    );
  }
}

class UserTileWidget extends StatelessWidget {
  final User user;
  final Function(User) onTapped;

  UserTileWidget({
    Key key,
    @required this.user,
    @required this.onTapped,
  })  : assert(user != null),
        assert(onTapped != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
      title: Text(user.name),
      subtitle: Text(user.email),
      onTap: () => onTapped(user),
    );
  }
}
