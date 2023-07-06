part of 'home_bloc.dart';

@immutable
abstract class HomeState {}
abstract class HomeActionState extends HomeState{}

class HomeInitial extends HomeState {}
class MovieFetchingLoadingState extends HomeState{}
class MovieFetchingErrorState extends HomeState{}

class MovieFetchingSuccessfulState extends HomeState {
  final List<Movie> movies;
  MovieFetchingSuccessfulState({required this.movies});
}

class HomeNavigateToWishlistPageActionState extends HomeActionState{}

class HomeNavigateToMovieDetailPageActionState extends HomeActionState{
  
}
