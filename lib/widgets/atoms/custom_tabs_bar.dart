import 'package:flutter/material.dart';
import 'package:flutter_tabbar_lite/flutter_tabbar_lite.dart';

class CustomTabsBar extends StatelessWidget {
  final List<String> titles;
  final Function(int) onTabChange;
  const CustomTabsBar({super.key, required this.titles, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 40.0,
      child: FlutterTabBarLite.horizontal(
        scrollable: true,
        animateItemSize: false,
        titles: titles,
        borderRadius: 30.0,
        itemBorderRadius: 20.0,
        itemPadding: EdgeInsets.all(10),
        backgroundColor: Theme.of(context).cardTheme.color,
        selectedItemBgColor: Theme.of(context).colorScheme.primary,
        onTabChange: (index) {
          onTabChange(index);
        },
      ),
    );
  }
}
