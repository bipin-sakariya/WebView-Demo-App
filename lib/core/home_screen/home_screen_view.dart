import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_demo_app/app_widgets/bottom_navigation/bottom_navigationbar.dart';
import 'package:webview_demo_app/app_widgets/bottom_navigation/tab_navigator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  Future<void> _selectTab(int tabItem) async {
    if (tabItem == _currentIndex) {
      // pop to first route
      _navigatorKeys[tabItem].currentState!.popUntil((route) => route.isFirst);
    } else {
      _navigatorKeys[_currentIndex].currentState!.popUntil((route) => route.isFirst);
      setState(() => _currentIndex = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Home screen");
    // ScreenUtil.init(
    //     BoxConstraints(
    //         maxWidth: MediaQuery.of(context).size.width,
    //         maxHeight: MediaQuery.of(context).size.height),
    //     designSize: Size(360, 690),
    //     context: context,
    //     minTextAdapt: true,
    //     orientation: Orientation.portrait);

    return  Scaffold(
          // appBar: AppBar(),
          body:
          // _buildOffstageNavigator(_currentIndex),
          Stack(
            children: [
              _buildOffstageNavigator(0),
              _buildOffstageNavigator(1),
              _buildOffstageNavigator(2),
            ],
          ),
          bottomNavigationBar: FlowNewsBottomNavigationBar(
            currentTab: _currentIndex,
            onSelectTab: _selectTab,
          ),
    );
  }

  Widget _buildOffstageNavigator(int index) {
    return Offstage(
      offstage: _currentIndex != index,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[index],
        index: index,
      ),
    );
  }

}
