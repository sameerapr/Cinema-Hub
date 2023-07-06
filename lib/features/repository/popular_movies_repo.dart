import 'dart:math';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sameera_grocery/data/models/movies_data_ui_model.dart';

class PopularMoviesRepo {
  static Future<List<Movie>> fetchMovies() async {
    var client = http.Client();
    const apiKey = 'api_key=d8f1e24833b1b0e016d75365952931b2';
    const popular = 'https://api.themoviedb.org/3/movie/popular?';
    List<Movie> movies = [];
    try {
      var response = await client.get(Uri.parse("$popular$apiKey"));
      if (response.statusCode == 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        List<dynamic> data = body['results'];
        movies = data.map((movie) => Movie.fromJson(movie)).toList();
        //print(movies[2].title);
      }
      return movies;
    } catch (error) {
    return [];
    }
  }
}
