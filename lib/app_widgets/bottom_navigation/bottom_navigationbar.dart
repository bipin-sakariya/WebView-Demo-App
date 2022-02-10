import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_demo_app/app_widgets/bottom_navigation/tab_items.dart';

class FlowNewsBottomNavigationBar extends StatelessWidget {
  const FlowNewsBottomNavigationBar({Key? key,required this.currentTab, required this.onSelectTab}) : super(key: key);

  final int currentTab;
  final ValueChanged<int> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: const Color.fromRGBO(18, 82, 255, 1.0),
      unselectedItemColor: Colors.black,
      selectedFontSize: 12.0.sp,
      unselectedFontSize: 12.0.sp,
      items: [
        _buildItem(tabItem: 0),
        _buildItem(tabItem: 1),
        _buildItem(tabItem: 2),
      ],
      onTap: onSelectTab,
      currentIndex: currentTab,
    );
  }
  BottomNavigationBarItem _buildItem({required int tabItem}) {
    return BottomNavigationBarItem(
      icon: Icon(tabIcons[tabItem], size: 28.0.sp),
      label: tabLabels[tabItem],
    );
  }
}


