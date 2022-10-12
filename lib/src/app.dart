import 'dart:developer';

import 'package:ShoolManagementSystem/src/data/library.dart';
import 'package:flutter/material.dart';

import 'auth.dart';
import 'routing.dart';
import 'screens/navigator.dart';

class SchoolManagementSystem extends StatefulWidget {
  const SchoolManagementSystem({super.key});

  @override
  State<SchoolManagementSystem> createState() => _SchoolManagementSystemState();
}

class _SchoolManagementSystemState extends State<SchoolManagementSystem> {
  final _auth = SMSAuth();
  final _navigatorKey = GlobalKey<NavigatorState>();
  late final RouteState _routeState;
  late final SimpleRouterDelegate _routerDelegate;
  late final TemplateRouteParser _routeParser;

  @override
  void initState() {
    /// Configure the parser with all of the app's allowed path templates.
    _routeParser = TemplateRouteParser(
      allowedPaths: [
        '/apply',
        '/signin',
        '/authors',
        '/settings',
        '/books/new',
        '/books/all',
        '/books/popular',
        '/book/:bookId',
        '/author/:authorId',
        '/employees/new',
        '/employees/all',
        '/employees/popular',
        '/employee/:employeeId',
        '/address_types/new',
        '/address_types/all',
        '/address_types/popular',
        '/address_type/:id',
        '/address_type/new',
        '/address_type/edit',
        '/#access_token',
      ],
      guard: _guard,
      initialRoute: '/apply',
    );

    _routeState = RouteState(_routeParser);

    _routerDelegate = SimpleRouterDelegate(
      routeState: _routeState,
      navigatorKey: _navigatorKey,
      builder: (context) => SMSNavigator(
        navigatorKey: _navigatorKey,
      ),
    );

    // Listen for when the user logs out and display the signin screen.
    _auth.addListener(_handleAuthStateChanged);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => RouteStateScope(
        notifier: _routeState,
        child: SMSAuthScope(
          notifier: _auth,
          child: MaterialApp.router(
            routerDelegate: _routerDelegate,
            routeInformationParser: _routeParser,
            // Revert back to pre-Flutter-2.5 transition behavior:
            // https://github.com/flutter/flutter/issues/82053
            theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                },
              ),
            ),
          ),
        ),
      );

  Future<ParsedRoute> _guard(ParsedRoute from) async {
    final signedIn = _auth.getSignedIn();
    final applyRoute = ParsedRoute('/apply', '/apply', {}, {});
    final signInRoute = ParsedRoute('/signin', '/signin', {}, {});

    // Go to /apply if the user is not signed in
    log("signed in $signedIn");
    log("application submitted ${hrSystemInstance.getApplicationSubmitted()}");
    log("from apply route ${from == applyRoute}\n");
    log("from ${from.toString()}\n");
    if (!signedIn &&
        from != applyRoute &&
        !hrSystemInstance.getApplicationSubmitted()) {
      return applyRoute;
    } else if (hrSystemInstance.getApplicationSubmitted() &&
        from != applyRoute) {
      return ParsedRoute('/authors', '/authors', {}, {});
    }
    // Go to /books if the user is signed in and tries to go to /signin.
    else if (signedIn && from == signInRoute) {
      return ParsedRoute('/books/popular', '/books/popular', {}, {});
    }
    return from;
  }

  void _handleAuthStateChanged() {
    if (!_auth.getSignedIn()) {
      _routeState.go('/apply');
    }
  }

  @override
  void dispose() {
    _auth.removeListener(_handleAuthStateChanged);
    _routeState.dispose();
    _routerDelegate.dispose();
    super.dispose();
  }
}
