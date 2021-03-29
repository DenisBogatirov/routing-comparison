import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:routing/router/user_route_delegate.dart';
import 'package:routing/router/user_route_information_parser.dart';
import 'package:routing/users.dart';

import 'screens/users_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  UserService _userService = UserService();
  UserRouterDelegate _routerDelegate;
  UserRouteInformationParser _routeInformationParser;

  _MyAppState() {
    _routerDelegate = UserRouterDelegate(_userService);
    _routeInformationParser = UserRouteInformationParser();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: _userService),
      ],

      // Navigation 2.0
      // child: MaterialApp.router(
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //     visualDensity: VisualDensity.adaptivePlatformDensity,
      //   ),
      //   routerDelegate: _routerDelegate,
      //   routeInformationParser: _routeInformationParser,
      // ),

      // Navigation 1.0
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        onGenerateRoute: (_) => UsersScreen.getRoute(),
      ),
    );
  }
}
