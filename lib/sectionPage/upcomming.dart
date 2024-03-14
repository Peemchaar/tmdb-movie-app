import 'package:flutter/material.dart';

class Upcomming extends StatefulWidget {
  const Upcomming({ Key? key }) : super(key: key);

  @override
  _UpcommingState createState() => _UpcommingState();
}

class _UpcommingState extends State<Upcomming> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Upcomming'),
      ),
    );
  }
}