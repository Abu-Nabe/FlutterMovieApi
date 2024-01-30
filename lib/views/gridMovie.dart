import 'package:flutter/material.dart';
import 'package:movieproject/model/model.dart';

Widget buildMovieGrid(List<MovieModel> _movies) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: _movies.length,
          itemBuilder: (context, index) {
            MovieModel movie = _movies[index];
            return GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/movie",
                  arguments: movie,
                );
              },
              child: buildMovieCard(movie),
            );
          },
        );
      },
    ),
  );
}

Widget buildMovieCard(MovieModel movie) {
  return Card(
    elevation: 4.0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              image: DecorationImage(
                image: NetworkImage(movie.poster),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            movie.title,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      ],
    ),
  );
}

