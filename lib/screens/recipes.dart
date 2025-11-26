import 'package:flutter/material.dart';
import 'package:recipe_app/models/category_model.dart';

import '../models/recipe_model.dart';
import '../services/api_service.dart';
import '../widgets/recipe_grid.dart';
class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key,required this.title,required this.category });
  final RCategory category;
  final String title;

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {

  late final List<Recipe> _recipes;
  List<Recipe> _filteredRecipes = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String _searchQuery = '';
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadRecipeList();
  }

  @override
  Widget build(BuildContext context) {

    if (_isLoading) {
      _loadRecipeList();
    }


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Recipe by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
                _searchRecipes(value);
              },
            ),
          ),
          Expanded(
            child: _filteredRecipes.isEmpty && _searchQuery.isNotEmpty
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
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: _isSearching
                        ? null
                        : () async {
                      await _searchRecipes(_searchQuery);
                    },
                    child: _isSearching
                        ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                        : const Text('Search in API'),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: RecipeGrid(recipes: _filteredRecipes),
            ),
          ),
        ],
      ),
    );
  }

  void _loadRecipeList() async {
    try{
      
      final recipeList = await _apiService.loadRecipeList(widget.category.name);

      print('Loaded ${recipeList.length} recipes');

      setState(() {
        _recipes = recipeList;
        _filteredRecipes = recipeList;
        _isLoading = false;
      });
    }catch(e){
      setState(() {
        _isLoading = false;
      });
      print('Error loading recipes: $e');
    }
  }

  Future<void> _searchRecipes(String name) async {
    if (name.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    try {
      final recipes = await _apiService.searchRecipeByName(name);
      setState(() {
        _filteredRecipes = _recipes;
        _isSearching = false;
      });
    } catch (error) {
      setState(() {
        _isSearching = false;
        _filteredRecipes = [];
      });
      print('Error searching recipes: $error');
    }
  }
}
