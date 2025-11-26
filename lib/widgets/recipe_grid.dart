import 'package:flutter/material.dart';
import 'package:recipe_app/widgets/recipe_card.dart';

import '../models/recipe_model.dart';
import 'category_card.dart';

class RecipeGrid extends StatefulWidget {
  final List<Recipe> recipes;

  const RecipeGrid({super.key, required this.recipes});

  @override
  State<StatefulWidget> createState() => _RecipeGridState();
}

class _RecipeGridState extends State<RecipeGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          childAspectRatio: 200/244
      ),
      itemCount: widget.recipes.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return RecipeCard(recipe: widget.recipes[index]);
      },
    );
  }
}
