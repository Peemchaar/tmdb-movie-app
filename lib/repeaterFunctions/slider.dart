
import 'package:flutter/material.dart';
import 'package:movie_app/api/api.dart';
import 'package:movie_app/details/checker.dart';
import 'package:movie_app/details/movie_details.dart';
import 'package:movie_app/details/series_details.dart';

Widget sliderList(List items, String categoryTitle, String type, int itemCount){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10, top: 15, bottom: 40),
        child: Text(categoryTitle),  
      ),
      Container(
        height: 250,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          itemBuilder: (context, index){
            return GestureDetector(
              onTap: () {
                if(type == 'movie'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails(movieId: items[index]['id'])));
                }
                else if(type == 'tv'){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SeriesDetails(tvId: items[index]['id'])));
                }   
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken
                    ),
                    image: NetworkImage(
                      '$IMAGE_BASE_PATH${items[index]['poster_path']}'
                    ),
                    fit: BoxFit.cover
                  )
                ),
                margin: EdgeInsets.only(left: 13),
                width: 170,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 6),
                        child: Text(
                          items[index]['date']
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, left: 6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                SizedBox(width: 2,),
                                Text(
                                  items[index]['vote_average'].toString()
                                )
                              ],
                            ),
                          ),
                        )
                      )
                    ]
                  ),
                ),
              ),
            );
          }
        ),
      ),
      SizedBox(height: 20,),
    ],
  );
}