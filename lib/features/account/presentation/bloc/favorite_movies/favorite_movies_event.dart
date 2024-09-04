class GetFavoriteMoviesEvent {}

class AddFavoriteMovieEvent {
  final int movie_id;
  final bool favorite;

  AddFavoriteMovieEvent({required this.movie_id, this.favorite = true});
}