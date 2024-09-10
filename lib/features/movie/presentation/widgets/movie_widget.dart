import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/colors.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/presentation/stream_controller/genre/fetch_movie_genre_state.dart';
import 'package:movie_app/features/movie/presentation/widgets/genre_label_widget.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/genre.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  final void Function(int id)? onTap;
  const MovieWidget({super.key, required this.movie, this.onTap});

  @override
  Widget build(BuildContext context) {
    String imageUrl = 'https://image.tmdb.org/t/p/w200${movie.poster_path}';

    return GestureDetector(
      onTap: () => onTap?.call(movie.id),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            width: 160,
            height: 260,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(imageUrl)
                )
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 200,
            height: 260,
            // color: CustomColor.primaryColor,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    softWrap: true,
                    style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18
                    ),),
                  Text(movie.release_date,
                    style: const TextStyle(
                    ),),
                  Consumer<FetchMovieGenreState>(
                      builder: (context, genreState, child) {
                        if (genreState is FetchMovieGenreInitial) {
                          return const Center(
                            child: Text('Please wait...',),
                          );
                        } else if (genreState is FetchMovieGenreLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (genreState is FetchMovieGenreLoaded) {
                          return Container(
                              margin: const EdgeInsets.symmetric(vertical: 12),
                              child: GenreLabelWidget(genreList: genreState.genreList, genreIDList: movie.genre_ids));
                        } else if (genreState is FetchMovieGenreError) {
                          return const Center(child: Text('Something happened'),);
                        } else {
                          return const Center(child: Text('Unknown error'),);
                        }
                      }),
                  Row(
                    children: [
                      const Icon(Icons.star,
                        color: Colors.yellow,),
                      Text(movie.vote_average.toStringAsFixed(1)),
                      Text('/10'),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}





