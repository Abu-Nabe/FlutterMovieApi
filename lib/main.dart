import 'package:flutter/material.dart';

import 'design/login.dart';
import 'design/movie_view.dart';
import 'bottom_navigation.dart';
import 'model/model.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/main':
            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return MainPage(); // Replace with the actual page widget
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // No animation, just return the child
              },
            );
          case '/movie':
            final args = settings.arguments as MovieModel;

            return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return MovieView(movieModel: args); // Replace with the actual page widget
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return child; // No animation, just return the child
              },
            );
          // Handle other routes if needed
          default:
            // You can return a default page or null for unknown routes
            return null;
        }
      },
    );
  }
}
