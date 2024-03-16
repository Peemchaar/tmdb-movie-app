import 'package:flutter/material.dart';
import 'package:movie_app/api/api.dart';

class MovieDetails extends StatefulWidget {
  var movieId;

  MovieDetails({super.key,  required this.movieId});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  List<Map<String, dynamic>> movieDetails = [];
  List<Map<String, dynamic>> userReviews = [];
  List<Map<String, dynamic>> similarMovies = [];
  List<Map<String, dynamic>> recommendedMovies = [];
  List<Map<String, dynamic>> movieTrailers = [];

  List movieGenres = [];

  Future <void> getDetails() async {
    var movieDetailsUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}?api_key=$API_KEY';
    var userReviewsUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/reviews?api_key=$API_KEY';
    var similarMoviesUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/similar?api_key=$API_KEY';
    var recommendedMoviesUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/recommendations?api_key=$API_KEY';
    var movieTrailersUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/videos?api_key=$API_KEY';
  }

  @override
  Widget build(BuildContext context){
    return Container();
  }
}