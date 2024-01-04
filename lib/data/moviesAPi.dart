import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:movieproject/model/model.dart';

import '../model/model.dart';

final String apiKey = 'd3b95856';

Future<List<MovieModel>> fetchMovies(action) async {
  final String apiUrl = 'http://www.omdbapi.com/?apikey=$apiKey&s=$action&page=1';

  final response = await http.get(Uri.parse(apiUrl));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the data
    final Map<String, dynamic> data = json.decode(response.body);

    // Use null-aware operators to check for the 'Search' key and its type
    List<MovieModel> movies = (data['Search'] as List?)?.map((movieData) {
          return MovieModel(
            movieData['Title'],
            int.parse(movieData['Year']),
            movieData['Type'],
            movieData['Poster'],
          );
        })?.toList() ??
        [];

    // Shuffle the list to get a random order
    movies.shuffle();

    // Take the first 10 movies (or less if there are fewer)
    return movies.take(10).toList();
  }

  // If there's an error or no movies are found, return an empty list
  return [];
}
