import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sameera_grocery/features/home/bloc/home_bloc.dart';
import 'package:sameera_grocery/features/movie_details/ui/movie_detail_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String movieTitle,movieDescription,moviePoster;
  final List<String> genre = <String>[
    'Action',
    'Drama',
    'Adventure',
    'Animation',
    'Comedy'
  ];
  final HomeBloc homebloc = HomeBloc();
  @override
  void initState() {
    homebloc.add(MoviesInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cinema Hub'),
        leading:
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu_rounded)),
        actions: [
          IconButton(
              onPressed: () {
                homebloc.add(HomeMovieWishliatButtonClickedEvent());
              },
              icon: const Icon(Icons.favorite_rounded)),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: genre.length,
              itemBuilder: (context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  margin: EdgeInsets.all(5),
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${genre[index]}',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )),
                );
              },
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Popular Movies',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold)),
          ),
          BlocConsumer<HomeBloc, HomeState>(
            bloc: homebloc,
            listenWhen: (previous, current) => current is HomeActionState,
            buildWhen: (previous, current) => current is! HomeActionState,
            listener: (context, state) {
              if (state is HomeNavigateToMovieDetailPageActionState) {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MovieDetailPage(
                      description: movieDescription, name: movieTitle, poster: moviePoster,

                    )));
              }
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case MovieFetchingLoadingState:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case MovieFetchingSuccessfulState:
                  final successState = state as MovieFetchingSuccessfulState;

                  return Expanded(
                    child: GridView.builder(
                      itemCount: successState.movies.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.65),
                      itemBuilder: (context, index) {
                        moviePoster = successState.movies[index].posterPath!;
                        movieTitle = successState.movies[index].title!;
                        movieDescription = successState.movies[index].overview!;
                        return GestureDetector(
                          onTap: (() {
                            homebloc.add(HomeMovieClickEvent());
                          }),
                          child: Container(
                           
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500/${successState.movies[index].posterPath}'),
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                default:
                  return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
