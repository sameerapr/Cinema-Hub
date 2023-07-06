import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sameera_grocery/data/models/movies_data_ui_model.dart';
import 'package:sameera_grocery/features/repository/popular_movies_repo.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<MoviesInitialFetchEvent>(moviesInitialFetchEvent);
    on<HomeMovieWishliatButtonClickedEvent>(homeMovieWishliatButtonClickedEvent);
    on<HomeMovieClickEvent>(homeMovieClickEvent);
  }

  FutureOr<void> moviesInitialFetchEvent(
      MoviesInitialFetchEvent event, Emitter<HomeState> emit) async {
    emit(MovieFetchingLoadingState());
    List<Movie> movies = await PopularMoviesRepo.fetchMovies();
    emit(MovieFetchingSuccessfulState(movies: movies));
  }

  FutureOr<void> homeMovieWishliatButtonClickedEvent(HomeMovieWishliatButtonClickedEvent event, Emitter<HomeState> emit) {
  print('WishList Navigate Button Clicked');
  emit(HomeNavigateToWishlistPageActionState());
  }

  FutureOr<void> homeMovieClickEvent(HomeMovieClickEvent event, Emitter<HomeState> emit) {
    print('Movie Detail Page Navigate Clicked');
    emit(HomeNavigateToMovieDetailPageActionState());
  }
}
