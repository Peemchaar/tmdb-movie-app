import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/api/api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/homePage/home_page.dart';

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

  List<Map<String, dynamic>> movieGenres = [];

  Future <void> getDetails() async {
    var movieDetailsUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}?api_key=$API_KEY';
    var userReviewsUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/reviews?api_key=$API_KEY';
    var similarMoviesUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/similar?api_key=$API_KEY';
    var recommendedMoviesUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/recommendations?api_key=$API_KEY';
    var movieTrailersUrl = '$BASE_URL$MOVIE_GENERAL/${widget.movieId.toString()}/videos?api_key=$API_KEY';

    var movieDetailResponse = await http.get(Uri.parse(movieDetailsUrl));
    if (movieDetailResponse.statusCode == 200) {
      var movieDetailJson = jsonDecode(movieDetailResponse.body);
      for (var i = 0; i < 1; i++) {
        movieDetails.add({
          "backdrop_path": movieDetailJson['backdrop_path'],
          "title": movieDetailJson['title'],
          "vote_average": movieDetailJson['vote_average'],
          "overview": movieDetailJson['overview'],
          "release_date": movieDetailJson['release_date'],
          "runtime": movieDetailJson['runtime'],
          "budget": movieDetailJson['budget'],
          "revenue": movieDetailJson['revenue'],
        });
      }
      for (var i = 0; i < movieDetailJson['genres'].length; i++) {
        movieGenres.add(movieDetailJson['genres'][i]['name']);
      }
    } else {}

    var userReviewResponse = await http.get(Uri.parse(userReviewsUrl));
    if (userReviewResponse.statusCode == 200) {
      var userReviewJson = jsonDecode(userReviewResponse.body);
      for (var i = 0; i < userReviewJson['results'].length; i++) {
        userReviews.add({
          "name": userReviewJson['results'][i]['author'],
          "review": userReviewJson['results'][i]['content'],
          //check rating is null or not
          "rating":
              userReviewJson['results'][i]['author_details']['rating'] == null
                  ? "Not Rated"
                  : userReviewJson['results'][i]['author_details']['rating']
                      .toString(),
          "avatarphoto": userReviewJson['results'][i]['author_details']
                      ['avatar_path'] ==
                  null
              ? "https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png"
              : '$IMAGE_BASE_PATH${userReviewJson["results"][i]["author_details"]["avatar_path"]}' ,
          "creationdate":
              userReviewJson['results'][i]['created_at'].substring(0, 10),
          "fullreviewurl": userReviewJson['results'][i]['url'],
        });
      }
    } else {}

    var similarMoviesResponse = await http.get(Uri.parse(similarMoviesUrl));
    if (similarMoviesResponse.statusCode == 200) {
      var similarMoviesJson = jsonDecode(similarMoviesResponse.body);
      for (var i = 0; i < similarMoviesJson['results'].length; i++) {
        similarMovies.add({
          "poster_path": similarMoviesJson['results'][i]['poster_path'],
          "name": similarMoviesJson['results'][i]['title'],
          "vote_average": similarMoviesJson['results'][i]['vote_average'],
          "Date": similarMoviesJson['results'][i]['release_date'],
          "id": similarMoviesJson['results'][i]['id'],
        });
      }
    } else {}

    var recommendedMoviesResponse =
        await http.get(Uri.parse(recommendedMoviesUrl));
    if (recommendedMoviesResponse.statusCode == 200) {
      var recommendedMoviesJson = jsonDecode(recommendedMoviesResponse.body);
      for (var i = 0; i < recommendedMoviesJson['results'].length; i++) {
        recommendedMovies.add({
          "poster_path": recommendedMoviesJson['results'][i]['poster_path'],
          "name": recommendedMoviesJson['results'][i]['title'],
          "vote_average": recommendedMoviesJson['results'][i]['vote_average'],
          "Date": recommendedMoviesJson['results'][i]['release_date'],
          "id": recommendedMoviesJson['results'][i]['id'],
        });
      }
    } else {}

    var movieTrailersResponse = await http.get(Uri.parse(movieTrailersUrl));
    if (movieTrailersResponse.statusCode == 200) {
      var movietrailersjson = jsonDecode(movieTrailersResponse.body);
      for (var i = 0; i < movietrailersjson['results'].length; i++) {
        if (movietrailersjson['results'][i]['type'] == "Trailer") {
          movieTrailers.add({
            "key": movietrailersjson['results'][i]['key'],
          });
        }
      }
      movieTrailers.add({'key': 'aJ0cZTcTh90'});
    } else {}
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
        future: getDetails(), 
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done){
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(FontAwesomeIcons.circleArrowLeft),
                    iconSize: 28,
                    color: Colors.white,
                  ),
                  actions: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => const HomePage()
                          ),
                          (route) => false
                        );
                      },
                      iconSize: 25,
                      color: Colors.white,
                      icon: Icon(FontAwesomeIcons.houseUser)
                    )
                  ],
                  backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                  centerTitle: false,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.4,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.parallax,
                    background: FittedBox(
                      fit: BoxFit.fill,
                      child: TrailerWatch(
                        trailerYtId: movieTrailers[0]['key'],
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([ 
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, top: 10),
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: movieGenres.length,
                                itemBuilder: (context, index){
                                  return Container(
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(25, 25, 25, 1),
                                      borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Text(movieGenres[index]),
                                  );
                                }
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10, top: 10),
                              padding: EdgeInsets.all(10),
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(25, 25, 25, 1),
                                borderRadius: BorderRadius.circular(10)
                              ),
                              child: Text(
                                '${movieDetails[0]["runtime"]} min'
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Movie Story: '),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text(movieDetails[0]['overview'].toString()),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: ReviewUi(revDetails: userReviews),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Release Date: ${movieDetails[0]["release_date"]}'),
                    ),

                    Padding(
                      padding: EdgeInsets.only(left: 20, top: 10),
                      child: Text('Budget: ${movieDetails[0]["budget"]}'),
                    ),
                  ])
                )
              ],
            );
          }else{
            return Scaffold();
          }
        }
      ),
    );
  }
}