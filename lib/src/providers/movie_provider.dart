import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/movie.dart';

class MovieProvider {
  String _apyKey = "baf1083f980b4e24f01e8950b30b697d";
  String _url = "api.themoviedb.org";
  String _lang = "es-ES";

  Future<List<Movie>> getOnCinemas() async {
    return getMovies("/movie/now_playing");
  }

  Future<List<Movie>> getPopular() {
    return getMovies("/movie/popular");
  }

  Future<List<Movie>> getMovies(String path) async {
    final apiVersion = "3";
    final url = Uri.https(
        _url, "$apiVersion$path", {"api_key": _apyKey, "lenguage": _lang});

    final resp = await http.get(url);

    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData["results"]);
    return movies.items;
  }
}
