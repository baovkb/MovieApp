import 'dart:async';
import 'dart:ui';

import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/add_favorite_movie_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/get_favorite_movies_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_event.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_state.dart';
import 'package:movie_app/features/movie/data/repositories/movies_repository_impl.dart';
import 'package:movie_app/features/movie/data/repositories/videos_list_repository_impl.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/domain/entities/movie_list.dart';
import 'package:movie_app/features/movie/domain/usecases/similar_movie_use_case.dart';
import 'package:movie_app/features/movie/domain/usecases/videos_use_case.dart';
import 'package:movie_app/features/movie/presentation/pages/movie_details/widget/cast_list_widget.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_state.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie_details/fetch_similar_movie_state.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie_details/fetch_similar_movies_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/video/fetch_videos_list_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/video/fetch_videos_list_state.dart';
import 'package:movie_app/features/movie/presentation/widgets/genre_label_widget.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/movie/data/repositories/movie_details_repository_impl.dart';
import 'package:movie_app/features/movie/data/sources/movie_api_client.dart';
import 'package:movie_app/features/movie/domain/entities/movie_details.dart';
import 'package:movie_app/features/movie/domain/usecases/movie_details_use_case.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie_details/fetch_movie_details_controller.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie_details/fetch_movie_details_state.dart';

class MovieDetailsScreen extends StatefulWidget {
  int movie_id;

  MovieDetailsScreen({super.key, required this.movie_id});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late MovieApiClient movieApiClient = MovieApiClient(Client());
  late final movieDetailsController = FetchMovieDetailsController(
      MovieDetailsUseCase(
          MovieDetailsRepositoryImpl(movieApiClient)
      ));
  late final similarMoviesController = FetchSimilarMoviesController(
    SimilarMovieUseCase(
        MoviesListRepositoryImpl(client: movieApiClient))
  );

  late final fetchVideoController = FetchVideosListController(
      VideosUseCase(
          VideosListRepositoryImpl(movieApiClient)));

  StreamSubscription<FetchVideoListState>? subscription;

  @override
  void initState() {
    super.initState();
    movieDetailsController.fetchMovieDetails(widget.movie_id);
    similarMoviesController.fetchSimilarMovies(widget.movie_id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: movieDetailsController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text('Please wait...',
                  style: TextStyle(color: Colors.white),),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data is FetchMovieDetailsInitial) {
                return const Center(
                  child: Text('Please wait...',
                    style: TextStyle(color: Colors.white),),
                );
              } else if (snapshot.data is FetchMovieDetailsLoading) {
                return const Center(child: CircularProgressIndicator(color: Colors.white,),);
              } else if (snapshot.data is FetchMovieDetailsLoaded) {
                return _buildMovieDetails(context, (snapshot.data as FetchMovieDetailsLoaded).movieDetails );
              } else if (snapshot.data is FetchMovieDetailsError) {
                return const Center(
                  child: Text('Something happened',
                    style: TextStyle(color: Colors.white),),);
              } else {
                return const Center(
                  child: Text('Unknown Error',
                    style: TextStyle(color: Colors.white),),);
              }
            } else {
              return const Center(
                child: Text('Fail to create controller',
                  style: TextStyle(color: Colors.white),),);
            }
          },
        ),
      ),
    );
  }

  Widget _buildMovieDetails(BuildContext context, MovieDetails movie) {
    String backdrop_path = 'https://image.tmdb.org/t/p/w400${movie.backdrop_path}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 220,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Image.network(backdrop_path,
                  fit: BoxFit.cover,
                ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //       colors: [
                //         CustomColor.mainColor.withOpacity(0.8),
                //         CustomColor.mainColor.withOpacity(0.0)
                //       ],
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       ),
                // ),
              ),
              Align(
                child: GestureDetector(
                  onTap: () => _handlePlayVideoBtn(context, movie.id),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: CustomColor.secondColor
                    ),
                    child: const Icon(
                      color: Colors.white,
                      Icons.play_arrow,
                      size: 40,),
                  ),
                ),
              ),
              Positioned(
                  top: 10,
                  left: 20,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      color: Colors.white,
                      Icons.keyboard_arrow_left_sharp,
                      size: 30,
                    ),
                  )),
              PopupMenu(),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Text('${movie.title}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20),),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 6),
          child: Row(
            children: [
              Row(
                children: [
                  Text('${movie.vote_average.toStringAsFixed(1)}'),
                  Text('/10')
                ]
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: RatingBar.readOnly(
                  maxRating: 10,
                  size: 14,
                  // filledColor: CustomColor.secondColor,
                  filledIcon: Icons.star,
                  emptyIcon: Icons.star_border_outlined,
                  halfFilledIcon: Icons.star_half,
                  // halfFilledColor: CustomColor.secondColor,
                  initialRating: movie.vote_average,),
              ),
            ],
          )
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Text('OVERVIEW', style: TextStyle(
              fontWeight: FontWeight.w500),),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          child: Text('${movie.overview}'),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('BUDGET', style: TextStyle(
                      fontWeight: FontWeight.w500),),
                  Text('${movie.budget}\$', style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),)
                ],
              )),
              Expanded(child: Column(
                children: [
                  Text('DURATION', style: TextStyle(
                      fontWeight: FontWeight.w500),),
                  Text('${movie.runtime}min', style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),)
                ],
              )),
              Expanded(child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('RELEASE DATE', style: TextStyle(
                      fontWeight: FontWeight.w500),),
                  Text('${movie.release_date}', style: TextStyle(
                      fontWeight: FontWeight.w500
                  ),)
                ],
              ))
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 18),
          child: Text('GENRES', style: TextStyle(
              fontWeight: FontWeight.w500),),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          child: Consumer<FetchMovieGenreState>(
              builder: (context, state, child) {
                if (state is FetchMovieGenreLoaded) {
                  return GenreLabelWidget(
                      genreList: state.genreList,
                      genreIDList: movie.genres.map((genre) => genre.id).toList());
                } else {
                  return const Center(
                    child: Text('Please wait...',),
                  );
                }
              }),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
          child: Text('CAST', style: TextStyle(
              fontWeight: FontWeight.w500),),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 18),
          height: 90,
          child: CastListWidget(movie_id: movie.id,),
        ),
        Container(
          margin: EdgeInsets.only(left: 18, right: 18, top: 24),
          child: Text('SIMILAR MOVIE', style: TextStyle(
              fontWeight: FontWeight.w500),),
        ),
        Container(
            height: 260,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: StreamBuilder<SimilarMovieState>(
              stream: similarMoviesController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                } else if (snapshot.hasData) {
                  if (snapshot.data is SimilarMovieInitial) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                  } else if (snapshot.data is SimilarMovieLoading) {
                    return const Center(child: CircularProgressIndicator(color: Colors.white,),);
                  } else if (snapshot.data is SimilarMovieLoaded) {
                    return _buildSimilarMoviesWidget(
                        context,
                        (snapshot.data as SimilarMovieLoaded).movieList);
                  } else if (snapshot.data is SimilarMovieError) {
                    return const Center(
                      child: Text('Something happened',
                        style: TextStyle(color: Colors.white),),);
                  } else {
                    return const Center(
                      child: Text('Unknown Error',
                        style: TextStyle(color: Colors.white),),);
                  }
                } else {
                  return const Center(
                    child: Text('Fail to create controller',
                      style: TextStyle(color: Colors.white),),);
                }
              },
            )

        ),
      ],
    );
  }

  @override
  void dispose() {
    movieDetailsController.dispose();
    similarMoviesController.dispose();
    fetchVideoController.dispose();
    subscription?.cancel();
    super.dispose();
  }

  Widget _buildSimilarMoviesWidget(BuildContext context, MovieList movieList) {
    return Container(
        height: 260,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: movieList.results.length,
                  itemBuilder: (context, position) => MovieWidget(
                    movie: movieList.results[position],
                    onTap: (id) {
                      Navigator.pushReplacementNamed(context, RouteName.MOVIE_DETAILS,
                      arguments: <String, int> {
                        'movie_id': id
                      });
                    },)
        )
    );
  }

  void _handlePlayVideoBtn(BuildContext context, final int movie_id) {
    fetchVideoController.fetchVideosList(movie_id);

    String video_id = '';
    subscription = fetchVideoController.stream.listen((state) {
      if (state is FetchVideosListLoaded) {
        for (final video in state.videosList.results) {
          if (video.site.compareTo('YouTube') == 0
              && video.type.compareTo('Teaser') == 0) {
            video_id = video.key;
            break;
          }
        }

        Navigator.pushNamed(
            context,
            RouteName.PLAY_VIDEO,
            arguments: <String, String> {
              'video_id': video_id
            });
      }
    });

  }

  Widget PopupMenu() {
    bool isExist = false;

    return BlocListener<AddFavoriteMovieBloc, AddFavoriteMovieState>(
        listener: (BuildContext context, state) {
          if (state is AddFavoriteMovieLoaded) {
            if (state.success) {
              debugPrint('add favorite success');
              context.read<GetFavoriteMoviesBloc>().add(GetFavoriteMoviesEvent());
            }
          }
        },
      child: Positioned(
        top: 10,
        right: 10,
        child: PopupMenuButton(
          icon: const Icon(Icons.more_vert, color: Colors.white,),
            itemBuilder: (context) => [
              PopupMenuItem(
                  onTap: () {
                    context.read<AddFavoriteMovieBloc>().add(AddFavoriteMovieEvent(
                        movie_id: widget.movie_id,
                        favorite: !isExist));

                    // BlocListener<AddFavoriteMovieBloc, AddFavoriteMovieState>(
                    //   listener: (BuildContext context, state) {
                    //     if (state is AddFavoriteMovieLoaded) {
                    //       if (state.success) {
                    //         debugPrint('add favorite success');
                    //         context.read<GetFavoriteMoviesBloc>().add(GetFavoriteMoviesEvent());
                    //       }
                    //     }
                    //   },);
                  },
                  child: BlocBuilder<GetFavoriteMoviesBloc, GetFavoriteMoviesState>(
                      builder: (context, state) {
                        if (state is GetFavoriteMoviesLoaded) {
                          isExist = false;
                          List<Movie> movieList = state.movieList.results;

                          for (final movie in movieList) {
                            if (movie.id == widget.movie_id) {
                              isExist = true;
                              break;
                            }
                          }

                          if (!isExist) {
                            return const Row(children: [
                                Icon(Icons.favorite_border),
                                Text('Add to favorite')
                              ],
                            );
                          } else {
                            return const Row(children: [
                              Icon(Icons.favorite, color: Colors.pinkAccent,),
                              Text('Remove from favorite')
                              ],
                            );
                          }
                        }
                        else {
                          return SizedBox();
                        }
                      },)
              ),
            ])
      ),
    );
  }
}


