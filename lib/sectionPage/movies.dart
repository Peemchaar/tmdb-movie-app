import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/api/api.dart';
import 'package:movie_app/repeaterFunctions/slider.dart';

class Movies extends StatefulWidget {
  const Movies({ Key? key }) : super(key: key);

  @override
  _MoviesState createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
  List<Map<String, dynamic>> popularMovies = [];
  List<Map<String, dynamic>> topRatedMovies = [];
  List<Map<String, dynamic>> nowPlayingMovies = [];

  var popularMoviesUrl = '$BASE_URL$MOVIE_POPULAR?api_key=$API_KEY';
  var topRatedMoviesUrl = '$BASE_URL$MOVIE_TOP?api_key=$API_KEY';
  var nowPlayingMoviesUrl = '$BASE_URL$MOVIE_NOW?api_key=$API_KEY';

  Future<void> moviesFunction() async {
    var popularMoviesResponse = await http.get(Uri.parse(popularMoviesUrl));
    if(popularMoviesResponse.statusCode == 200){
      var tempData = jsonDecode(popularMoviesResponse.body);
      var popularMoviesJson = tempData['results'];
      for (var i = 0; i < popularMoviesJson.length; i++) {
        popularMovies.add({
          'id' : popularMoviesJson[i]['id'],
          'poster_path' : popularMoviesJson[i]['poster_path'],
          'vote_average' : popularMoviesJson[i]['vote_average'],
          'date' : popularMoviesJson[i]['release_date'],
          'index' : i,
        });
      }
    } else{
      print(popularMoviesResponse.statusCode);
    }

    var topRatedMoviesResponse = await http.get(Uri.parse(topRatedMoviesUrl));
    if(topRatedMoviesResponse.statusCode == 200){
      var tempData = jsonDecode(topRatedMoviesResponse.body);
      var topRatedMoviesJson = tempData['results'];
      for (var i = 0; i < topRatedMoviesJson.length; i++) {
        topRatedMovies.add({
          'id' : topRatedMoviesJson[i]['id'],
          'poster_path' : topRatedMoviesJson[i]['poster_path'],
          'vote_average' : topRatedMoviesJson[i]['vote_average'],
          'date' : topRatedMoviesJson[i]['release_date'],
          'index' : i,
        });
      }
    } else{
      print(topRatedMoviesResponse.statusCode);
    }

    var nowPlayingMoviesResponse = await http.get(Uri.parse(nowPlayingMoviesUrl));
    if(nowPlayingMoviesResponse.statusCode == 200){
      var tempData = jsonDecode(nowPlayingMoviesResponse.body);
      var nowPlayingMoviesJson = tempData['results'];
      for (var i = 0; i < nowPlayingMoviesJson.length; i++) {
        nowPlayingMovies.add({
          'id' : nowPlayingMoviesJson[i]['id'],
          'poster_path' : nowPlayingMoviesJson[i]['poster_path'],
          'vote_average' : nowPlayingMoviesJson[i]['vote_average'],
          'date' : nowPlayingMoviesJson[i]['release_date'],
          'index' : i,
        });
      }
    } else{
      print(nowPlayingMoviesResponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: moviesFunction(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.amber,
            ),
          );
        }else { 
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sliderList(popularMovies, 'Popular Movies', 'movie', popularMovies.length),
              sliderList(topRatedMovies, 'Top Rated Movies', 'movie', topRatedMovies.length),
              sliderList(nowPlayingMovies, 'Now Playing', 'movie', nowPlayingMovies.length),
            ],
          );
        }
      }
    );
  }
}