// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:movie_app/details/movie_details.dart';
import 'package:movie_app/details/series_details.dart';


class Checker extends StatefulWidget {
  var id;
  var type;

  Checker(this.id, this.type, {super.key});

  @override
  _CheckerState createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  checkType(){
    if(widget.type == 'movie'){
      return MovieDetails(
        movieId: widget.id,
      );
    }
    else if(widget.type == 'tv'){
      return SeriesDetails(
        tvId: widget.id,
      );
    }
    else{
      return errorUi();
    }
  }
  @override
  Widget build(BuildContext context) {
    return checkType();
  }
}

Widget errorUi(){
  return Scaffold(
    body: Center(
      child: Text('Error'),
    ),
  );
}