import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/get_favorite_movies_bloc.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_event.dart';
import 'package:movie_app/features/account/presentation/bloc/favorite_movies/favorite_movies_state.dart';
import 'package:movie_app/features/movie/domain/entities/movie.dart';
import 'package:movie_app/features/movie/presentation/widgets/movie_widget.dart';
import 'package:movie_app/route/route_name.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    // = Provider.of<FavoriteMoviesBloc>(context, listen: false);
    context.read<GetFavoriteMoviesBloc>().add(GetFavoriteMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetFavoriteMoviesBloc, GetFavoriteMoviesState>(
        builder: (context, state) {
          debugPrint(state.toString());

          if (state is GetFavoriteMoviesLoaded) {
            return _buildFavoriteMoviesList(state.movieList.results);
          } else if (state is GetFavoriteMoviesError) {
            return Text('GetFavoriteMoviesError', style: TextStyle(color: Colors.white),);
          } else {
            return Text('hmm', style: TextStyle(color: Colors.white),);
          }
        }
    );
  }
}

Widget _buildFavoriteMoviesList(List<Movie> movieList) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
    child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => SizedBox(width: 0, height: 16,),
        itemCount: movieList.length,
        itemBuilder: (context, position) => MovieWidget(
            movie: movieList[position],
        onTap: (id) {
              Navigator.pushNamed(context,
                  RouteName.MOVIE_DETAILS,
                  arguments: <String, int>{
                    'movie_id': id
                  }
              );
        },),
    ),
  );
}
