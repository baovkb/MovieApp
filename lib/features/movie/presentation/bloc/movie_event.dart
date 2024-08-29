import 'package:equatable/equatable.dart';

abstract class MovieEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class FetchPopularMovieEvent extends MovieEvent {}