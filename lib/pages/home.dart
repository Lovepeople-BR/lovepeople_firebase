import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

    static Map route = {routeName:(context)=>HomePage(),};
    static String routeName = '/home';
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
    );
  }
}