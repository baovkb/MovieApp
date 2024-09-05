import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/get_favorite_movies_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_event.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_state.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:provider/provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FocusNode _focus;
  List<Movie>? movieList;
  late TextEditingController _textEditingController;
  String query = '';
  late SearchableMovieNotifier searchableMovieNotifier;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    // = Provider.of<FavoriteMoviesBloc>(context, listen: false);
    _focus = FocusNode();
    _textEditingController = TextEditingController();
    _textEditingController.addListener(_onTextChanged);
    searchableMovieNotifier = SearchableMovieNotifier();
    context.read<GetFavoriteMoviesBloc>().add(GetFavoriteMoviesEvent());
  }

  @override
  void dispose() {
    _focus.dispose();
    _textEditingController.removeListener(_onTextChanged);
    _textEditingController.dispose();
    searchableMovieNotifier.dispose();
    if (_debounce?.isActive ?? false) {
      _debounce?.cancel();
    }
    super.dispose();
  }

  void _onTextChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(const Duration(milliseconds: 200), () {
      String inputText = _textEditingController.text.trim();

      if (query.compareTo(inputText) == 0) return;

      query = inputText;
      _filterMovies();
    });
  }

  void _filterMovies() {
    if (query.compareTo('') == 0) {
      searchableMovieNotifier.update(movieList!);
      return;
    }

    if (movieList != null) {
      List<Movie> searchableMovieList = [];

      movieList!.forEach((movie) {
        String title = movie.title.toLowerCase();
        if (title.contains(query)) {
          searchableMovieList!.add(movie);
        }
      });

      searchableMovieNotifier.update(searchableMovieList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<SearchableMovieNotifier>(
        create: (BuildContext context) => searchableMovieNotifier,
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
                height: 50,
                child: TextField(
                  controller: _textEditingController,
                  textInputAction: TextInputAction.done,
                  onTapOutside: (pointerDownEvent) {
                    _focus.unfocus();
                  },
                  textAlignVertical: TextAlignVertical.center,
                  focusNode: _focus,
                  style: const TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xff292b37),
                    contentPadding: EdgeInsets.zero,
                    hintText: 'Search',
                    hintStyle: const TextStyle(
                        color: Colors.white54
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none
                    ),
                    prefixIcon: const Icon(
                      Icons.search,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                )
            ),
            BlocConsumer<GetFavoriteMoviesBloc, GetFavoriteMoviesState>(
              listener: (context, state) {
                if (state is GetFavoriteMoviesLoaded) {
                  movieList = state.movieList.results;
                  _filterMovies();
                }
              },
                builder: (context, state) {
                  if (state is GetFavoriteMoviesLoaded) {
                    return SizedBox();
                  } else if (state is GetFavoriteMoviesError) {
                    return const Text('GetFavoriteMoviesError', style: TextStyle(color: Colors.white),);
                  } else {
                    return const Text('hmm', style: TextStyle(color: Colors.white),);
                  }
                }
            ),
            Consumer<SearchableMovieNotifier>(
                builder: (BuildContext context, notifier, Widget? child) {
                  return _buildFavoriteMoviesList(notifier.movieList);
                }
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildFavoriteMoviesList(List<Movie> movieList) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: ListView.separated(
          separatorBuilder: (BuildContext context, int index) => SizedBox(width: 0, height: 16,),
          itemCount: movieList.length,
          itemBuilder: (context, position) => MovieWidget(
              movie: movieList[position],
          onTap: (id) {
                Navigator.pushNamed(context,
                    RouteName.MOVIE_DETAILS,
                    arguments: {'movie_id': id}
                );
          },),
      ),
    ),
  );
}

class SearchableMovieNotifier extends ChangeNotifier {
  List<Movie> movieList = [];

  void update(List<Movie> movieList) {
    this.movieList = movieList;
    notifyListeners();
  }
}
