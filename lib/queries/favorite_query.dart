import 'package:movieproject/data/sqlData.dart';
import 'package:movieproject/model/model.dart';
import 'package:sqflite/sqflite.dart';

// to insert to database
Future<void> insertMovieToFavorites(MovieModel movie) async {
  Database db = await DatabaseHelper.instance.database;
  await db.insert('movies', movie.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace);
}

// remove from database
Future<void> removeMovieFromFavorites(MovieModel movie) async {
  Database db = await DatabaseHelper.instance.database;
  await db.delete('movies', where: 'title = ?', whereArgs: [movie.title]);
}

// get all movies
Future<List<MovieModel>> getAllMovies() async {
  Database db = await DatabaseHelper.instance.database;
  List<Map<String, dynamic>> result = await db.query('movies');

  List<MovieModel> movies =
      result.map((map) => MovieModel.fromMap(map)).toList();
  return movies;
}

// select one
Future<bool> retrieveMovie(String title) async {
  MovieModel? movie = await DatabaseHelper.instance.getMovieByTitle(title);

  if (movie != null) {
    return true;
  } else {
    return false;
  }
}

