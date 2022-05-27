import 'package:flutter/material.dart';
import 'package:exo_widgets_inteactifs/profile_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Interactifs',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ProfilePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}