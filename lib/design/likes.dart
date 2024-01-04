import 'package:flutter/material.dart';
import 'package:movieproject/data/sqlData.dart';
import 'package:movieproject/model/model.dart';
import 'package:movieproject/queries/favorite_query.dart'; // Import your data and database helper

class Likes extends StatefulWidget {
  @override
  _LikesState createState() => _LikesState();
}

class _LikesState extends State<Likes> {
  List<MovieModel> _movies = [];

  @override
  void initState() {
    super.initState();
    retrieveMovies();
  }

  Future<void> retrieveMovies() async {
    List<MovieModel> movies = await getAllMovies();
    setState(() {
      _movies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favorite',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          child: Container(
            color: Color(0xFFe3e3e3),
            height: 1.0,
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            MovieModel movie = _movies[index];
            return GestureDetector(
              onTap: () {
                // Handle tap on the entire item
                Navigator.pushNamed(
                  context,
                  "/movie",
                  arguments: movie,
                );
              },
              child: buildListItem(_movies[index]),
            );
            // return buildListItem(_movies[index]);
          },
        ),
      ),
    );
  }

  Widget buildListItem(MovieModel movie) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(movie.poster),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 80.0, // Adjust the width as needed
            height: 80.0, // Adjust the height as needed
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title, // Display movie title
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              // Your onPressed logic here
              removeFavorite(movie);
            },
            child: Icon(
              Icons.favorite,
              size: 30.0,
              color: Color(0xFFE30B5C),
            ),
          )
        ],
      ),
    );
  }

  removeFavorite(movie) async {
    // delete the movie that's tapped on
    await removeMovieFromFavorites(movie);

    setState(() {
      // Remove the movie from the _movies list
      _movies.remove(movie);
    });
  }
}
