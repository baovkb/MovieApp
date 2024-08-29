import 'package:movie_app/features/movie/domain/entities/casts_list.dart';

abstract class FetchCastState {}

class FetchCastInitial extends FetchCastState {}

class FetchCastLoading extends FetchCastState {}

class FetchCastLoaded extends FetchCastState {
  final CastsList castsList;

  FetchCastLoaded(this.castsList);
}

class FetchCastError extends FetchCastState {
  final dynamic message;

  FetchCastError(this.message);
}