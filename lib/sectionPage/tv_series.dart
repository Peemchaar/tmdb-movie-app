// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/api/api.dart';
import 'package:movie_app/repeaterFunctions/slider.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({ Key? key }) : super(key: key);

  @override
  _TvSeriesState createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  List<Map<String, dynamic>> popularTvSeries = [];
  List<Map<String, dynamic>> topRatedTvSeries = [];
  List<Map<String, dynamic>> onAirTvSeries = [];

  var popularTvSeriesUrl = '$BASE_URL$TV_POPULAR?api_key=$API_KEY';
  var topRatedTvSeriesUrl = '$BASE_URL$TV_TOP?api_key=$API_KEY';
  var onAirTvSeriesUrl = '$BASE_URL$TV_ON_AIR?api_key=$API_KEY';

  Future<void> tvSeriesFunction() async {
    var popularTvResponse = await http.get(Uri.parse(popularTvSeriesUrl));
    if(popularTvResponse.statusCode == 200){
      var tempData = jsonDecode(popularTvResponse.body);
      var popularTvJson = tempData['results'];
      for (var i = 0; i < popularTvJson.length; i++) {
        popularTvSeries.add({
          'id' : popularTvJson[i]['id'],
          'poster_path' : popularTvJson[i]['poster_path'],
          'vote_average' : popularTvJson[i]['vote_average'],
          'date' : popularTvJson[i]['first_air_date'],
          'index' : i,
        });
      }
    } else{
      print(popularTvResponse.statusCode);
    }

    var topRatedTvResponse = await http.get(Uri.parse(topRatedTvSeriesUrl));
    if(topRatedTvResponse.statusCode == 200){
      var tempData = jsonDecode(topRatedTvResponse.body);
      var topRatedTvJson = tempData['results'];
      for (var i = 0; i < topRatedTvJson.length; i++) {
        topRatedTvSeries.add({
          'id' : topRatedTvJson[i]['id'],
          'poster_path' : topRatedTvJson[i]['poster_path'],
          'vote_average' : topRatedTvJson[i]['vote_average'],
          'date' : topRatedTvJson[i]['first_air_date'],
          'index' : i,
        });
      }
    } else{
      print(topRatedTvResponse.statusCode);
    }

    var onAirTvResponse = await http.get(Uri.parse(onAirTvSeriesUrl));
    if(onAirTvResponse.statusCode == 200){
      var tempData = jsonDecode(onAirTvResponse.body);
      var onAirTvJson = tempData['results'];
      for (var i = 0; i < onAirTvJson.length; i++) {
        onAirTvSeries.add({
          'id' : onAirTvJson[i]['id'],
          'poster_path' : onAirTvJson[i]['poster_path'],
          'vote_average' : onAirTvJson[i]['vote_average'],
          'date' : onAirTvJson[i]['first_air_date'],
          'index' : i,
        });
      }
    } else{
      print(onAirTvResponse.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: tvSeriesFunction(), 
      builder: (context, snapshot){
        if(snapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(
              color: Colors.amber.shade400,
            ),
          );
        }else { 
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              sliderList(popularTvSeries, 'Popular Tv Series', 'tv', popularTvSeries.length),
              sliderList(topRatedTvSeries, 'Top Rated Tv Series', 'tv', topRatedTvSeries.length),
              sliderList(onAirTvSeries, 'On the Air', 'tv', onAirTvSeries.length),
            ],
          );
        }
      }
    );
  }
}