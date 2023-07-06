part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class MoviesInitialFetchEvent extends HomeEvent{}

class HomeMovieClickEvent extends HomeEvent{}

class HomeMovieWishliatButtonClickedEvent extends HomeEvent{}


