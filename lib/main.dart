import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/add_note_page.dart';
import 'pages/show_note_page.dart';

void main() {
  runApp(MyApp());
}

final routes = {
  '/': (BuildContext context) => HomePage(),
  '/home': (BuildContext context) => HomePage(),
  '/addnote': (BuildContext context) => AddNotePage(),
  '/shownote': (BuildContext context) => ShowNotePage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: routes,
      theme: ThemeData(
          // Use the old theme but apply the following three changes
          textTheme: Theme.of(context).textTheme.apply(
              fontFamily: 'Lato',
              bodyColor: Colors.blueGrey[700],
              displayColor: Colors.blueGrey[700])),
    );
  }
}
