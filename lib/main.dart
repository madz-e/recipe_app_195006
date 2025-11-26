import 'package:flutter/material.dart';
import 'package:recipe_app/screens/home.dart';
import 'package:recipe_app/screens/recipes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Recipe Categories'),
      },
    );
  }
}
