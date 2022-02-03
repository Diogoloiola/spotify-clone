import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/home_page.dart';
import 'package:spotify_clone/screens/search.dart';

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {Key? key, required this.navigatorKey, required this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {
    Widget child = Home();
    if (tabItem == 'Home') {
      child = const Home();
    } else if (tabItem == 'Search') {
      child = const Search();
    }

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}
