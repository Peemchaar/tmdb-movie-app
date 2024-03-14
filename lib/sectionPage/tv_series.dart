import 'package:flutter/material.dart';

class TvSeries extends StatefulWidget {
  const TvSeries({ Key? key }) : super(key: key);

  @override
  _TvSeriesState createState() => _TvSeriesState();
}

class _TvSeriesState extends State<TvSeries> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('TV SERIES'),
      ),
    );
  }
}