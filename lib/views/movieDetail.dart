import 'package:flutter/material.dart';

Widget buildDetailScreen(movie) {
  return Container(
    height: 250,
       padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: Color(0xFFe3e3e3),
          width: 1.0,
        ),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: NetworkImage(movie.poster),
                fit: BoxFit.cover,
                height: 150.0,
              ),
              SizedBox(height: 8.0),
              Text(
                movie.title,
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),

        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Release Date: ${movie.year}",
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
            SizedBox(width: 16.0),
            Text(
              "Media Type: ${movie.type}",
              style: TextStyle(fontSize: 16.0, color: Colors.black),
            ),
          ],
        ),
      ],
    ),
  );
}
