import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomNavigationBar extends StatelessWidget {
  void Function(int index) onTap;
  List<CustomNavigationBarItem> navItemList;
  Color backgroundColor;
  Color unselectedColor;
  Color selectedColor;

  CustomNavigationBar({
    super.key,
    required this.onTap,
    required this.navItemList,
    this.backgroundColor = Colors.blueAccent,
    this.unselectedColor = Colors.white54,
    this.selectedColor = Colors.white});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NavBarStateNotifier>(
      create: (context) => NavBarStateNotifier(),
      child: Positioned(
        left: 0,
        right: 0,
        bottom: 12,
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: backgroundColor
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: () {
              List<Widget> itemList = [];
              for (int i = 0; i< navItemList.length; ++i) {
                itemList.add(NavBarItemWidget(
                  selectedColor: selectedColor,
                  unselectedColor: unselectedColor,
                  onTap: onTap,
                  customNavigationBarItem: navItemList[i],
                  position: i,
                ));
              }
              return itemList;
            }.call(),
          ),
        ),
      ),
    );
  }
}

class NavBarItemWidget extends StatelessWidget {
  Color unselectedColor;
  Color selectedColor;
  void Function(int index) onTap;
  CustomNavigationBarItem customNavigationBarItem;
  int position;

  NavBarItemWidget({
    super.key,
    required this.unselectedColor,
    required this.selectedColor,
    required this.onTap,
    required this.customNavigationBarItem,
    required this.position});

  final Duration _duration = const Duration(milliseconds: 250);

  @override
  Widget build(BuildContext context) {
    return Consumer<NavBarStateNotifier>(
      builder: (context, navState, child) {
        return Center(
          child: GestureDetector(
              onTap: () {
                if (navState.position != position) {
                  onTap(position);
                  navState.setPosition(position);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: navState.position == position ? selectedColor.withOpacity(0.07) : Colors.transparent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(customNavigationBarItem.icon,
                      color: navState.position == position ? selectedColor : unselectedColor,
                    ),
                    AnimatedSize(
                      duration: _duration,
                      child: Container(
                          margin: const EdgeInsets.only(left: 4),
                          child: navState.position == position
                              ? customNavigationBarItem.label
                              : const SizedBox()),
                    )
                  ],
                ),
              )
          ),
        );
      },
    );
  }
}

class CustomNavigationBarItem {
  IconData icon;
  Text label;

  CustomNavigationBarItem({required this.icon, required this.label});
}

class NavBarStateNotifier extends ChangeNotifier{
  int position = 0;

  void setPosition(int position) {
    this.position = position;
    notifyListeners();
  }
}
