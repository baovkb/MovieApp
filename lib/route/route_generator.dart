import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/presentation/pages/main_screen.dart';
import 'package:movie_app/features/movie/presentation/pages/movie_details/movie_details_screen.dart';
import 'package:movie_app/features/movie/presentation/pages/profile_screen/profile_screen.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:movie_app/features/movie/presentation/pages/home_screen/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute (RouteSettings settings) {
    switch (settings.name) {
      case RouteName.MAIN_PAGE:
        return MaterialPageRoute(builder: (context) => const MainScreen());
      case RouteName.HOME_PAGE:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.PROFILE_PAGE:
        return MaterialPageRoute(builder: (context) => const ProfileScreen());
      case RouteName.MOVIE_DETAILS:
        final args = settings.arguments as Map<String, int>;
        return MaterialPageRoute(builder: (context) => MovieDetailsScreen(
          movie_id: args['movie_id']??0,));
      default:
        return MaterialPageRoute(builder: (context) => const MainScreen());
    }
  }
}