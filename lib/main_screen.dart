import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/account/presentation/page/favorite/favorite_screen.dart';
import 'package:movie_app/features/account/presentation/page/profile_screen/profile_screen.dart';
import 'package:movie_app/features/movie/presentation/pages/home_screen/home_screen.dart';
import 'package:movie_app/features/movie/presentation/widgets/navigation_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _current_page = 0;
  final navPageList = <Widget>[
    HomeScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _current_page,
            children: navPageList,
          ),
          CustomNavigationBar(
              backgroundColor: CustomColor.mainLightColor,
              onTap: (index) {
                setState(() {
                  _current_page = index;
                });
              },
              navItemList: [
                CustomNavigationBarItem(
                    icon: Icons.home,
                    label: const Text('Home', style: TextStyle(color: Colors.white),)),
                CustomNavigationBarItem(
                    icon: Icons.favorite,
                    label: const Text('Favorite', style: TextStyle(color: Colors.white),)),
                CustomNavigationBarItem(
                    icon: Icons.account_box,
                    label: Text('Profile', style: TextStyle(color: Colors.white))),
              ])
        ],
      ),
    );
  }
}

