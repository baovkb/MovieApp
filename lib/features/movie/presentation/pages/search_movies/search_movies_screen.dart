import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:movie_app/features/movie/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/usecases/search_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/search_movies_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/search_movies_state.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:provider/provider.dart';

class SearchMoviesScreen extends StatefulWidget {
  String query;
  SearchMoviesScreen({super.key, required this.query});

  @override
  State<SearchMoviesScreen> createState() => _SearchMoviesScreenState();
}

class _SearchMoviesScreenState extends State<SearchMoviesScreen> {
  late FocusNode _focus;
  late TextEditingController _controller;
  Timer? _debounce;
  final _searchMoviesController = SearchMoviesController(
      SearchMoviesUseCase(MoviesListRepositoryImpl(client: MovieApiClient(Client()))));

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    _controller = TextEditingController();
    _controller.text = widget.query;
    _controller.addListener(_onTextChanged);
    _searchMoviesController.call(widget.query);
  }

  @override
  void dispose() {
    _focus.dispose();
    _controller.dispose();
    _searchMoviesController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (widget.query.compareTo(_controller.text) == 0) return;

    if (_debounce?.isActive?? false) {
      _debounce?.cancel();
    }

    _debounce = Timer(const Duration(milliseconds: 500), () {
      widget.query = _controller.text;
      _searchMoviesController.call(_controller.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<SearchMoviesState>(
      create: (BuildContext context) =>_searchMoviesController.stream,
      initialData: SearchMoviesInitial(),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 18),
              child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 50,
                  child: TextField(
                    textInputAction: TextInputAction.search,
                    controller: _controller,
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
                      prefixIcon: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
              ),
            ),
            Expanded(
              child: Consumer<SearchMoviesState>(
                builder: (BuildContext context, state, Widget? child) {
                  if (state is SearchMoviesLoaded) {
                    List<Movie> movieList = state.movieList.results;
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.separated(
                          itemCount: movieList.length,
                          separatorBuilder: (context, position) => const SizedBox(
                            width: 0,
                            height: 16,
                          ),
                          itemBuilder: (context, position) => MovieWidget(
                              movie: movieList[position],
                              onTap: (id) {
                                Navigator.pushNamed(
                                    context,
                                    RouteName.MOVIE_DETAILS,
                                    arguments: {
                                      'movie_id': id
                                    }
                                );
                              },
                          ),
                      ),
                    );
                  } else if (state is SearchMoviesError) {
                    return const Center(
                      child: Text('Something is wrong', style: TextStyle(color: Colors.white),),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white,),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
