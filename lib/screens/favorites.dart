import 'package:flutter/material.dart';
import 'package:recipe_app/services/favorites_service.dart';

import '../models/recipe_model.dart';
import '../widgets/recipe_grid.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  List<Recipe> _favorites= [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavoritesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("Favorites!<3"),
        actions: <Widget>[

        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: _favorites.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Recipes found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: RecipeGrid(recipes: _favorites),
            ),
          ),
        ],
      ),
    );
  }


  void _loadFavoritesList() async {
    try {
      final favorites=FavoritesService.favorites;

      setState(() {
        _favorites = favorites;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading favorites: $error');
    }


  }
}