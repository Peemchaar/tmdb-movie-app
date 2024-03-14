import 'package:flutter/material.dart';

class Movies extends StatefulWidget {
  const Movies({ Key? key }) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Movies'),
      ),
    );
  }
}