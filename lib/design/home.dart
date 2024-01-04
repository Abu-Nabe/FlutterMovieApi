import 'package:flutter/material.dart';
import 'package:movieproject/data/moviesAPi.dart';
import 'package:movieproject/extension/getRandomCategory.dart';
import 'package:movieproject/views/gridMovie.dart';

import '../model/model.dart';
import '/design/movie_view.dart';
import '../data/categoryArray.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final FocusNode _searchFocus = FocusNode();
  bool _isSearchFocused = false;
  List<MovieModel> _movies = [];

  @override
  void initState() {
    super.initState();
    // it checks when search is being clicked
    _searchFocus.addListener(() {
      setState(() {
        _isSearchFocused = _searchFocus.hasFocus;
      });
    });

    // This is where we fetch our movies
    fetchAndSetMovies();
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
      if(_movies.isEmpty){
        fetchAndSetMovies();
      }
    }
  }

  @override
  void dispose() {
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_searchFocus.hasFocus) {
          _searchFocus.unfocus();
        }
      },
      child: Scaffold(
        body: ListView(
          children: [
            buildAppBar(),
            buildSearchTextField(_searchFocus, _isSearchFocused),
            SizedBox(height: 2.0),
            buildMovieGrid(_movies),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return AppBar(
      title: Text(
        'Movies',
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
    );
  }

  Widget buildSearchTextField(FocusNode searchFocus, bool isSearchFocused) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: TextField(
        focusNode: searchFocus,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Search movies (only for design)',
          prefixIcon: Icon(
            Icons.search,
            color: isSearchFocused ? Color(0xFFE30B5C) : Colors.black,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3), width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Color(0xFFE3E3E3), width: 2.0),
          ),
        ),
      ),
    );
  }
}
