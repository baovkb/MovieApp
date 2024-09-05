import 'package:flutter/material.dart';
import 'package:movie_app/features/account/presentation/page/favorite/favorite_screen.dart';
import 'package:movie_app/features/account/presentation/page/profile_screen/profile_screen.dart';
import 'package:movie_app/features/movie/presentation/pages/search_movies/search_movies_screen.dart';
import 'package:movie_app/main_screen.dart';
import 'package:movie_app/features/movie/presentation/pages/movie_details/movie_details_screen.dart';
import 'package:movie_app/features/movie/presentation/pages/play_video/play_video_screen.dart';
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
      case RouteName.PLAY_VIDEO:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(builder: (context) => PlayVideoScreen(
          video_id: args['video_id']??'',));
      case RouteName.FAVORITE_MOVIE:
        return MaterialPageRoute(builder: (context) => FavoriteScreen());
      case RouteName.SEARCH_MOVIES:
        final args = settings.arguments as Map<String, String>;
        return MaterialPageRoute(builder: (context) => SearchMoviesScreen(query: args['query']??''));
      default:
        return MaterialPageRoute(builder: (context) => const MainScreen());
    }
  }
}