import 'package:flutter/material.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/movie/fetch_popular_movies_state.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie_app/route/route_name.dart';
import 'package:provider/provider.dart';

class PopularMoviesWidget extends StatelessWidget {
  const PopularMoviesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Popular movies',
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold
                ),
              ),
              Text('See all',
                style: TextStyle(
                    // color: Colors.white54,
                    fontSize: 16
                ),)
            ],
          ),
        ),
        Container(
            height: 260,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Consumer<FetchPopularMoviesState>(
              builder: (context, movieState, child) {

                if (movieState is FetchPopularMoviesInitial) {
                  return const Center(child:
                      Text('Please wait...',),);
                } else if (movieState is FetchPopularMoviesLoading) {
                  return const Center(child: CircularProgressIndicator(
                  ));
                } else if (movieState is FetchPopularMoviesLoaded) {
                  return PageView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movieState.movieList.results.length,
                      itemBuilder: (context, position) => MovieWidget(
                          movie: movieState.movieList.results[position],
                          onTap: (id) {
                            Navigator.pushNamed(
                                context,
                                RouteName.MOVIE_DETAILS,
                                arguments: <String, int> {
                                  'movie_id': id
                                });
                          },));
                } else if (movieState is FetchPopularMoviesError) {
                  return Center(child: Text('Something happened'),);
                } else {
                  return Center(child: Text('Unknown error'),);
                }
              },
            )

        )
      ],
    );
  }
}
