import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/account/data/repositories/account_repository_impl.dart';
import 'package:movie_app/features/account/data/sources/local_data/account_db.dart';
import 'package:movie_app/features/account/data/sources/remote_data/account_api_client.dart';
import 'package:movie_app/features/account/domain/usecases/add_favorite_movie_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/create_session_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/get_account_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/get_favorite_movies_use_case.dart';
import 'package:movie_app/features/account/domain/usecases/request_token_use_case.dart';
import 'package:movie_app/features/account/presentation/bloc/account/get_account_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/add_favorite_movie_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/get_favorite_movies_bloc.dart';
import 'package:movie_app/features/movie/data/repositories/genre_repository_impl.dart';
import 'package:movie_app/features/movie/domain/usecases/genre_use_case.dart';
import 'package:movie_app/features/movie/domain/usecases/popular_movies_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_state.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_popular_movies_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_popular_movies_state.dart';
import 'package:movie_app/route/route_generator.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'features/movie/data/repositories/movies_repository_impl.dart';
import 'features/movie/data/sources/movie_api_client.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    //hide status bar and nav bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MovieApiClient client = MovieApiClient(http.Client());
    final accountApiClient = AccountApiClient(http.Client());

    final moviesListRepo = MoviesListRepositoryImpl(client: client);
    final movieGenreRepo = GenreRepositoryImpl(client);
    final accountRepo = AccountRepositoryImpl(accountApiClient, AccountDB());

    final fetchPopularMoviesController = FetchPopularMoviesController(PopularMoviesUseCase(moviesListRepo));
    final fetchMovieGenreController = FetchMovieGenreController(GenreUseCase(movieGenreRepo));

    final getAccountUseCase = GetAccountUseCase(accountRepo);

    fetchPopularMoviesController.fetchPopularMovies();
    fetchMovieGenreController.fetchMovieGenres();

    final getFavoriteMoviesUseCase = GetFavoriteMoviesUseCase(accountRepo);
    final addFavoriteMovieUseCase = AddFavoriteMovieUseCase(accountRepo);
    
    return 
      MultiProvider(
        providers: [
          StreamProvider<FetchPopularMoviesState>(
              create: (context) => fetchPopularMoviesController.stream,
              initialData: FetchPopularMoviesInitial()
          ),
          StreamProvider<FetchMovieGenreState>(
              create: (context) => fetchMovieGenreController.stream,
              initialData: FetchMovieGenreInitial()),
          BlocProvider<GetAccountBloc>(
              create: (context) => GetAccountBloc(getAccountUseCase)),
          BlocProvider<GetFavoriteMoviesBloc>(
              create: (BuildContext context) => GetFavoriteMoviesBloc(getFavoriteMoviesUseCase),
          ),
          BlocProvider<AddFavoriteMovieBloc>(
            create: (BuildContext context) => AddFavoriteMovieBloc(addFavoriteMovieUseCase),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: CustomColor.mainColor
          ),
          initialRoute: RouteName.MAIN_PAGE,
          onGenerateRoute: RouteGenerator.generateRoute,
        ),
      );
  }
}
