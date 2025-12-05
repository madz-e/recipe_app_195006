import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../models/recipe_model.dart';
import '../screens/details.dart';
import '../services/favorites_service.dart';

class RecipeCard extends StatefulWidget {
  final Recipe recipe;

  const RecipeCard({super.key, required this.recipe});

  @override
  State<RecipeCard> createState() => _RecipeCardState();

}

class _RecipeCardState extends State<RecipeCard> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(recipe: widget.recipe),
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
              Expanded(child: Image.network(widget.recipe.img)),
              Divider(),
              Text(widget.recipe.name, style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              LikeButton(
                isLiked: widget.recipe.isFavorite,
                  onTap: (isLiked) async {
                    if (isLiked){
                      widget.recipe.isFavorite = !isLiked;
                      FavoritesService.favorites.removeWhere((r) => r.id == widget.recipe.id);
                      return widget.recipe.isFavorite;
                    }else{
                      widget.recipe.isFavorite = !isLiked;
                      FavoritesService.favorites.add(widget.recipe);
                      return widget.recipe.isFavorite;
                    }
                  },
              )
            ],
          ),
        ),
      ),
    );
  }
}
