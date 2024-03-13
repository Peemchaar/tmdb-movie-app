import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:movie_app/api/api.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int uval = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
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
                SizedBox(width: 10,)
              ],
            ),
          ),
          SliverList(delegate: SliverChildListDelegate([
            Center(
              child: Text('Sample Text'),
            )
          ]))
        ],
      ),
    );
  }
}