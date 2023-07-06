import 'package:flutter/material.dart';
import 'package:sameera_grocery/features/home/ui/home_screen/home_screen.dart';

import 'features/movie_details/ui/movie_detail_page.dart';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}