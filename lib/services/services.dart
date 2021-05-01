import 'package:movieapp/models/movie_details.dart';
import 'package:movieapp/models/movie_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:movieapp/models/movie_suggestion.dart';

class Services {
  Future<Welcome> fetchAlbum(String genre) async {
    final response =
        //await http.get('https://yts.mx/api/v2/list_movies.json?genre=comedy');
        await http.get('https://yts.mx/api/v2/list_movies.json?genre=$genre');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Welcome.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Welcome> recentMovies() async {
    final response =
        //await http.get('https://yts.mx/api/v2/list_movies.json?genre=comedy');
        await http.get(
            'https://yts.mx/api/v2/list_movies.json?limit=50&sort_by=year');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Welcome.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Welcome> movieDetails() async {
    final response =
        //await http.get('https://yts.mx/api/v2/list_movies.json?genre=comedy');
        await http.get(
            'https://yts.mx/api/v2/list_movies.json?limit=50&sort_by=year');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Welcome.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<MovieDetail> futureDetails(int id) async {
    final response =
        //await http.get('https://yts.mx/api/v2/list_movies.json?genre=comedy');
        await http.get(
            "https://yts.mx/api/v2/movie_details.json?movie_id=$id&with_cast=true");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieDetail.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<MovieSuggestions> suggestionDetails(int id) async {
    final response =
        //await http.get('https://yts.mx/api/v2/list_movies.json?genre=comedy');
        await http
            .get("https://yts.mx/api/v2/movie_suggestions.json?movie_id=$id");

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieSuggestions.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
