import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';

import '../routing.dart';
import '../auth.dart';
import 'scaffold_body.dart';

class SMSScaffold extends StatelessWidget {
  static const pageNames = [
    '/tests/logical',
    '/books/popular',
    '/authors',
    // '/address_types/popular',
    // '/organizations/popular',
    // '/branches/popular',
    // '/offices/popular',
    // '/job_bands/popular',
  ];

  const SMSScaffold({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    final selectedIndex = _getSelectedIndex(routeState.route.pathTemplate);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        appBar: AppBar(
          title: const Text('Avinya Acadamy - Admissions - Application Portal'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              tooltip: 'Logout',
              onPressed: () {
                SMSAuthScope.of(context).signOut();
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('User Signed Out')));
              },
            ),
            IconButton(
              icon: const Icon(Icons.info),
              tooltip: 'Help',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute<void>(
                  builder: (BuildContext context) {
                    return Scaffold(
                      appBar: AppBar(
                        title: const Text('Help'),
                      ),
                      body: const Center(
                        child: Text(
                          'This is the help page',
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                    );
                  },
                ));
              },
            ),
          ],
        ),
        body: const SMSScaffoldBody(),
        onDestinationSelected: (idx) {
          routeState.go(pageNames[idx]);
        },
        destinations: const [
          AdaptiveScaffoldDestination(
            title: 'Tests',
            icon: Icons.text_snippet,
          ),
          AdaptiveScaffoldDestination(
            title: 'Books',
            icon: Icons.book,
          ),
          AdaptiveScaffoldDestination(
            title: 'Authors',
            icon: Icons.person,
          ),
          AdaptiveScaffoldDestination(
            title: 'Settings',
            icon: Icons.settings,
          ),
          AdaptiveScaffoldDestination(
            title: 'Employees',
            icon: Icons.people,
          ),
          AdaptiveScaffoldDestination(
            title: 'Address Types',
            icon: Icons.location_on,
          ),
        ],
      ),
    );
  }

  int _getSelectedIndex(String pathTemplate) {
    int index = pageNames.indexOf(pathTemplate);
    if (index >= 0)
      return index;
    else
      return 0;
  }
}
