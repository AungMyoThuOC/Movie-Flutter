// import 'dart:convert';

import 'package:top_rate_movie/models/cast.dart';
import 'package:top_rate_movie/models/resp_cast.dart';

import '../models/movie.dart';
import 'package:http/http.dart' as http;
import '../models/res_popular.dart';

class API {
  final String _baseURL = "https://api.themoviedb.org/3/movie/";
  static const String imageURL = "https://image.tmdb.org/t/p/w200";
  final String _apiKey = "0264b0cdba895000a1d2f5382fe17e4f";

  Future<List<Movie>> getMovieList(String category, {required}) async {
    final response = await http.get(
      Uri.parse("$_baseURL$category?api_key=$_apiKey"),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var resp = ResPopular.fromRawJson(response.body);
      return resp.results;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<List<Movie>> getTopRated(String category) async {
    return getMovieList(category);
  }

  Future<List<Movie>> getUpcoming(String category) async {
    return getMovieList(category);
  }

  Future<List<Movie>> getNowPlaying(String category) async {
    return getMovieList(category);
  }

// https://api.themoviedb.org/3/search/movie?query=$str&api_key=050c28541f900007285c3020069bfd62
  // String _Url = "https://api.themoviedb.org/3/search/movie?query=";

  Future<List<Movie>> getSearch(String name) async {
    // return getSearch("/search/movie/$name");

    var url = Uri.parse(
        'https://api.themoviedb.org/3/search/movie?query=$name&api_key=0264b0cdba895000a1d2f5382fe17e4f');
    final resp = await http.get(url);
    print(resp.statusCode);
    if (resp.statusCode == 200) {
      var movieresult = ResPopular.fromRawJson(resp.body);
      return movieresult.results;
    } else {
      throw Exception('Unable to Assest API');
      // print(resp.statusCode);
    }
  }

  Future<List<Cast>> getCast(int movieID) async {
    var url = "/movie/$movieID/credits";

    final response = await http.get(
      Uri.parse("$_baseURL$url?api_key=$_apiKey"),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      var resp = RespCast.fromRawJson(response.body);
      return resp.cast;
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
