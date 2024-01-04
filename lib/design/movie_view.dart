import 'package:flutter/material.dart';
import 'package:movieproject/data/categoryArray.dart';
import 'package:movieproject/data/moviesAPi.dart';
import 'package:movieproject/extension/getRandomCategory.dart';
import 'package:movieproject/queries/favorite_query.dart';
import 'package:movieproject/views/gridMovie.dart';
import '../model/model.dart';
import '../views/loadingDetail.dart';
import '../views/movieDetail.dart';
import '../views/errorDetail.dart';

class MovieView extends StatefulWidget {
  final MovieModel movieModel;

  MovieView({required this.movieModel});

  @override
  _MovieViewState createState() => _MovieViewState();
}

class _MovieViewState extends State<MovieView> {
  bool isLoading = true;
  List<MovieModel> _movies = [];

  bool isFavored = false;

  @override
  void initState() {
    super.initState();

    fetchAndSetMovies();
    retrieveHeart();
    // makes loading screen last for 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchAndSetMovies() async {
    String category = getRandomCategory(categoryArray);
    try {
      List<MovieModel> movies = await fetchMovies(category);
      setState(() {
        _movies = movies;
      });
    } catch (error) {
      // if there's an error then recall the same function
      // in case movie is already set and somehow the error is being displayed we can ignore it
      if (_movies.isEmpty) {
        fetchAndSetMovies();
      }
    }
  }

   Future<void> retrieveHeart() async {
      MovieModel movie = widget.movieModel;
      bool favored = await isMovieInFavorites(movie);
      setState(() {
        isFavored = favored;
      });
    }

  Future<bool> isMovieInFavorites(MovieModel movie) async {
    return await retrieveMovie(movie.title);
  }

  @override
  Widget build(BuildContext context) {
    MovieModel movie = widget.movieModel;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: Stack(
        children: [
          if (isLoading) buildLoadingScreen(),
          SingleChildScrollView(
            child: Column(
              children: [
                if (!isLoading) buildView(movie),
                if (!isLoading) buildMovieGrid(_movies),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        'Favorite',
        style: TextStyle(color: Color(0xFFe3e3e3)),
      ),
      centerTitle: true,
      backgroundColor: Color(0xFFE30B5C),
      actions: [
        IconButton(
          icon: Icon(Icons.favorite,
              color: isFavored ? Colors.black : Color(0xFFe3e3e3)),
          onPressed: () {
            configureFavorite();
          },
        ),
      ],
      iconTheme: IconThemeData(color: Color(0xFFe3e3e3)),
      bottom: PreferredSize(
        child: Container(
          color: Color(0xFFe3e3e3),
          height: 1.0,
        ),
        preferredSize: Size.fromHeight(1.0),
      ),
    );
  }

  Widget buildView(MovieModel movie) {
    if (movie != null) {
      return buildDetailScreen(movie);
    } else {
      return buildErrorScreen();
    }
  }

  configureFavorite() async {
    // If it's already liked then remove, and vice versa
    if (isFavored) {
      await removeMovieFromFavorites(widget.movieModel);
    } else {
      await insertMovieToFavorites(widget.movieModel);
    }
    // Toggle the isPressed state when the IconButton is pressed
    setState(() {
      isFavored = !isFavored;
    });
  }
}
