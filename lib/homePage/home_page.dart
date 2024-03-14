// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:movie_app/api/api.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movie_app/sectionPage/movies.dart';
import 'package:movie_app/sectionPage/tv_series.dart';
import 'package:movie_app/sectionPage/upcomming.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<Map<String, dynamic>> trendingList = [];

  Future<void> trendingListHome() async{
    if(uval == 1){
      var trendingWeekResponse = await http.get(Uri.parse('$BASE_URL$TRENDING_WEEK?api_key=$API_KEY'));
      if(trendingWeekResponse.statusCode == 200){
        var tempData = jsonDecode(trendingWeekResponse.body);
        var trendingWeekJson = tempData['results'];
        for (var i = 0; i < trendingWeekJson.length; i++) {
          trendingList.add({
            'id' : trendingWeekJson[i]['id'],
            'poster_path' : trendingWeekJson[i]['poster_path'],
            'vote_average' : trendingWeekJson[i]['vote_average'],
            'media_type' : trendingWeekJson[i]['media_type'],
            'index' : i,
          });
        }
      }
    }else if(uval == 2){
      var trendingDayResponse = await http.get(Uri.parse('$BASE_URL$TRENDING_DAY?api_key=$API_KEY'));
      if(trendingDayResponse.statusCode == 200){
        var tempData = jsonDecode(trendingDayResponse.body);
        var trendingDayJson = tempData['results'];
        for (var i = 0; i < trendingDayJson.length; i++) {
          trendingList.add({
            'id' : trendingDayJson[i]['id'],
            'poster_path' : trendingDayJson[i]['poster_path'],
            'vote_average' : trendingDayJson[i]['vote_average'],
            'media_type' : trendingDayJson[i]['media_type'],
            'index' : i,
          });
        }
      }
    }
    

    
  }

  int uval = 1;
  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                future: trendingListHome(), 
                builder: (context, snapshot){
                  if(snapshot.connectionState == ConnectionState.done){
                    return CarouselSlider(
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 2),
                        height: MediaQuery.of(context).size.height,
                      ),
                      items: trendingList.map((i){
                        return Builder(builder: (BuildContext context){
                          return GestureDetector(
                            onTap: () {},
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.3), 
                                      BlendMode.darken
                                    ),
                                    image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w500${i['poster_path']}'
                                    ),
                                    fit: BoxFit.fill
                                  )
                                ),
                              ),
                            ),
                          );
                        });
                      }).toList(),
                    );
                  }else{
                    return Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                      ),
                    );
                  }
                }
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trending 🔥',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 16
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: DropdownButton(
                      onChanged: (value){
                        setState((){
                          trendingList.clear();
                          uval = int.parse(value.toString()); 
                        });
                      },
                      autofocus: true,
                      underline: Container(height: 0,color: Colors.transparent,),
                      icon: Icon(
                        Icons.arrow_drop_down_sharp,
                        color: Colors.amber,
                        size: 30,
                      ),
                      value: uval,
                      items: [
                        DropdownMenuItem(
                          child: Text(
                            'Weekly',
                            style: TextStyle( 
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text(
                            'Daily',
                            style: TextStyle( 
                              decoration: TextDecoration.none,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          value: 2,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Center(
              child: Text('Sample Text'),
            ),
            Container(
              height: 45,
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TabBar(
                physics: BouncingScrollPhysics(),
                
                labelPadding: EdgeInsets.only(left: 20),
                isScrollable: true,
                controller: _tabController,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.amber.withOpacity(0.4)
                ),
                tabs: [
                  Tab(child: Text('Tv Series')),
                  Tab(child: Text('Movies')),
                  Tab(child: Text('Upcomming')),
                ]
              ),
            ),
            Container(
              height: 1050,
              child: TabBarView(
                controller: _tabController,
                children: [
                  TvSeries(),
                  Movies(),
                  Upcomming(),
                ],
              ),
            )
          ]))
        ],
      ),
    );
  }
}