import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/features/movie/presentation/pages/home_screen/widgets/movie_by_genre_widget.dart';
import 'package:movie_app/features/movie/presentation/pages/home_screen/widgets/popular_movies_widget.dart';
import 'package:movie_app/route/route_name.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 18
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello there',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28
                          ),
                        ),
                        Text('What to watch?')
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage('assets/images/avatar.jpg'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 50,
                  child: TextField(
                    cursorColor: colorScheme.onSurface,
                    textInputAction: TextInputAction.go,
                    onTapOutside: (pointerDownEvent) {
                      _focus.unfocus();
                    },
                    onSubmitted: (value) {
                      Navigator.pushNamed(
                          context,
                          RouteName.SEARCH_MOVIES,
                          arguments: {
                            'query': value
                          }
                      );
                    },
                    textAlignVertical: TextAlignVertical.center,
                    focusNode: _focus,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: colorScheme.secondary,
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Search',
                      hintStyle: TextStyle(
                          color: colorScheme.onSurface.withOpacity(0.5)
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none
                      ),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                    ),
                  )
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: Divider(
                  color: colorScheme.onSurface.withOpacity(0.2),
                  thickness: 1,
                  indent: 16,
                  endIndent: 16,
                ),
              ),
              const PopularMoviesWidget(),
              const MovieByGenreWidget()
            ]
        ),
      ),
    );
  }
}


