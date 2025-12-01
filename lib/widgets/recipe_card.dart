import 'package:flutter/material.dart';

import '../models/recipe_model.dart';
import '../screens/details.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(recipe: recipe),
              ));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.pink.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(child: Image.network(recipe.img)),
              Divider(),
              Text(recipe.name, style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            ],
          ),
        ),
      ),
    );
  }
}
