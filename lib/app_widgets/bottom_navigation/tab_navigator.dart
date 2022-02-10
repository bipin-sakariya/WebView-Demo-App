import 'package:flutter/material.dart';
import 'package:webview_demo_app/core/news_screen/news_screen_view.dart';
import 'package:webview_demo_app/core/profile_screen/profile_screen.dart';
import 'package:webview_demo_app/core/saved_screen/saved_screen_view.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator({Key? key, required this.navigatorKey, required this.index}) : super(key: key);
  final GlobalKey<NavigatorState>? navigatorKey;
  final int index;

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    return {
      '/': (context) {
        return [
          const NewsScreen(),
          const SavedScreen(),
           ProfileScreen(),
        ].elementAt(index);
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) {
              //Navigator.pop(context);
              return routeBuilders[routeSettings.name]!(context);
            }
        );
      },
    );
  }
}